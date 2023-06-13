/*
    File: para_server_init.sqf
    Author: Savage Game Design
    Public: Yes

    Description:
        Called to initialise the server on game start.

    Parameter(s):
        None

    Returns:
        None

    Example(s):
        //In description.ext
        use_paradigm_init = 1;
*/

private _gamemode_config = (missionConfigFile >> "gamemode");

private _wipeSave = (["wipe_save", 0] call BIS_fnc_getParamValue) > 0;
if (_wipeSave) then {
    ["CLEAR"] call para_s_fnc_profile_db;
};

vn_mf_enableRanks = (["enable_ranks", 0] call BIS_fnc_getParamValue) > 0;
publicVariable "vn_mf_enableRanks";

// Create traits hashmap for reference by traits system
private _traits = (_gamemode_config >> "traits") call BIS_fnc_getCfgSubClasses;
vn_mf_traits_map = createHashMap;
{
    vn_mf_traits_map set [_x,[]];
}forEach _traits;
publicVariable "vn_mf_traits_map";

//Set whether the building system needs vehicles (fuel/repair/rearm, etc) nearby to build certain structures.
para_l_buildables_require_vehicles = [false, true] select (["buildables_require_vehicles", 1] call BIS_fnc_getParamValue);
publicVariable "para_l_buildables_require_vehicles";
vn_mf_dawnLength = ["dawn_length", 1200] call BIS_fnc_getParamValue;
vn_mf_dayLength = ["day_length", 9000] call BIS_fnc_getParamValue;
vn_mf_duskLength = ["dusk_length", 1200] call BIS_fnc_getParamValue;
vn_mf_nightLength = ["night_length", 1800] call BIS_fnc_getParamValue;

//Set whether stamia is enabled
vn_mf_param_enable_stamina = (["param_enable_stamina", 1] call BIS_fnc_getParamValue) > 0;
vn_mf_param_set_stamina = (["param_set_stamina", 1] call BIS_fnc_getParamValue);
publicVariable "vn_mf_param_enable_stamina";
publicVariable "vn_mf_param_set_stamina";

//Set whether withstand is always available.
vn_revive_withstand_allow = (["always_allow_withstand", 1] call BIS_fnc_getParamValue) > 0;
publicVariable "vn_revive_withstand_allow";
//Set number of bandages needed to withstand.
vn_revive_withstand_amount = 4;
publicVariable "vn_revive_withstand_amount";
//Set number of max players per team
vn_mf_max_players_acav = ["max_players_acav", 99] call BIS_fnc_getParamValue;
vn_mf_max_players_greenhornets = ["max_players_greenhornets", 99] call BIS_fnc_getParamValue;;
vn_mf_max_players_mikeforce = ["max_players_mikeforce", 99] call BIS_fnc_getParamValue;;
vn_mf_max_players_spiketeam = ["max_players_spiketeam", 99] call BIS_fnc_getParamValue;;
publicVariable "vn_mf_max_players_acav";
publicVariable "vn_mf_max_players_greenhornets";
publicVariable "vn_mf_max_players_mikeforce";
publicVariable "vn_mf_max_players_spiketeam";
//Disable RTO Support if desired
private _airSupport = ["enable_air_support", 1] call BIS_fnc_getParamValue;
private _artySupport = ["enable_arty_support", 1] call BIS_fnc_getParamValue;
if (_airSupport != 0 || _artySupport != 0) then {
  if (_airSupport == 0) then {
    vn_artillery_config_array set [0, nil];
  };
  if (_airSupport == 2) then {
    private _airArray = vn_artillery_config_array select 0;
    _airArray resize 1;
    _airArray select 0 select 1 resize 2;
    vn_artillery_config_array set [0, _airArray];
  };
  if (_artySupport == 0) then {
    vn_artillery_config_array set [2, nil];
  };
};

//TODO: Parameterise these
vn_mf_campAttackFrequency = 600;
vn_mf_counterAttackTime = 3600;
vn_mf_counterAttackShortenedTime = 600;
vn_mf_counterattackBaseInfantryMultiplier = 3;
vn_mf_counterattackCampInfantryMultiplier = 6;
para_s_bf_respawn_supply_cost = 50;


// Set desired number of simultaneously active zones.
vn_mf_targetNumberOfActiveZones = 1;
// Set number of enemies per player. Scale the default value by the percentage set in the config options.
para_g_enemiesPerPlayer = ((["ai_scaling", 100] call BIS_fnc_getParamValue) / 100) * 2;
//Global variable, so it needs syncing across the network.
publicVariable "para_g_enemiesPerPlayer";

diag_log "VN MikeForce: Initialising markers";
//Read map markers and populate appropriate arrays
call vn_mf_fnc_marker_init;

// restore enlisted player counter
(["GET", "enlisted_counter", 745001] call para_s_fnc_profile_db) params ["",["_enlisted_counter",0]];
vn_mf_enlisted_counter = _enlisted_counter;

//Initialise task list
vn_mf_tasks = [];
//Counts the number of tasks that have been created, to let us have unique IDs.
vn_mf_taskCounter = 0;
//Build the lists of secondary tasks, so we can create them later.
//Tasks without a marker aren't valid secondary tasks.
vn_mf_secondaryTaskConfigs = "getText (_x >> 'taskCategory') == 'SEC' && getText (_x >> 'taskname') != ''" configClasses (missionConfigFile >> "gamemode" >> "tasks");

//Create a lookup for tasks by zone and team
vn_mf_secondaryTasksBySide = false call para_g_fnc_create_namespace;
vn_mf_secondaryTasksBySide setVariable ["MikeForce", []];
vn_mf_secondaryTasksBySide setVariable ["SpikeTeam", []];
vn_mf_secondaryTasksBySide setVariable ["GreenHornets", []];
vn_mf_secondaryTasksBySide setVariable ["ACAV", []];


// vn_mf_allowed_functions = ("isClass _x && getNumber _x >> 'rec' isEqualTo 1" configClasses (missionConfigFile >> "cfgfunctions" >> "vn_mf" >> "rehandler") apply {configName _x});

vn_mf_default_awards = [];
{
    vn_mf_default_awards pushBack [configName _x, -1];
} forEach ("isClass(_x)" configClasses (missionConfigFile >> "gamemode" >> "awards_config"));

// setup game optimizations server side
setviewdistance (getNumber(_gamemode_config >> "performance" >> "setviewdistance"));
setobjectviewdistance (getArray(_gamemode_config >> "performance" >> "setobjectviewdistance")); // this also controls ai target range
setterraingrid (getNumber(_gamemode_config >> "performance" >> "setterraingrid"));
(getArray(_gamemode_config >> "performance" >> "enableenvironment")) params ["_ambientlife","_ambientsound"];
enableenvironment [[false,true] select _ambientlife,[false,true] select _ambientsound];

//Set up respawn points.
[] call vn_mf_fnc_respawn_points_init;

// start scheduler
diag_log "VN MikeForce: Starting scheduler";
[] call para_g_fnc_scheduler_subsystem_init;

// start the event dispatcher, so anything relying on events can fire.
call para_g_fnc_event_subsystem_init;

diag_log "VN MikeForce: Initialising Cleanup Routine";
// start cleanup subsystem
[
    createHashmapFromArray [
        ["minPlayerDistance", ["cleanup_min_player_distance", 400] call BIS_fnc_getParamValue],
        ["maxBodies", ["cleanup_max_bodies", 50] call BIS_fnc_getParamValue],
        ["cleanPlacedGear", ["cleanup_placed_gear", 1] call BIS_fnc_getParamValue > 0],
        ["placedGearCleanupTime", ["cleanup_placed_gear_lifetime", 300] call BIS_fnc_getParamValue],
        ["cleanDroppedGear", ["cleanup_dropped_gear", 1] call BIS_fnc_getParamValue > 0],
        ["droppedGearCleanupTime", ["cleanup_dropped_gear_lifetime", 300] call BIS_fnc_getParamValue]
    ]
] call para_s_fnc_cleanup_subsystem_init;

// creates and initialize groups and duty officers
diag_log "VN MikeForce: Initialising groups and duty officers";
call vn_mf_fnc_group_init;

{
    private _taskConfig = _x;
    //Add the task to appropriate team arrays for the zone
    {
        vn_mf_secondaryTasksBySide getVariable _x pushBack configName _taskConfig;
    } forEach (getArray (_taskConfig >> 'taskGroups'));
} forEach (vn_mf_secondaryTaskConfigs);

// start generic scheduler functions
diag_log "VN MikeForce: Starting game time monitor";
// broadcast total time elapsed - initial
missionNamespace setVariable ["para_g_totalgametime",["GET", "game_time", 0] call para_s_fnc_profile_db select 1,true];
diag_log format ["VN MikeForce: Total Game Time - %1", para_g_totalgametime];
["save_time_elapsed", {call vn_mf_fnc_save_time_elapsed}, [], 5] call para_g_fnc_scheduler_add_job;

// spawn buildables and init vars
diag_log "VN MikeForce: Initialising building system";
call para_s_fnc_building_system_init;

diag_log "VN MikeForce: Creating supply officers";
// spawn supply officers
{
    [_x] call vn_mf_fnc_create_supply_officer;
} forEach vn_mf_markers_supply_officer_initial;

diag_log "VN MikeForce: Starting building state tracker";
// building state tracking
["building_state_tracker", {call para_s_fnc_building_state_tracker}, [], 60] call para_g_fnc_scheduler_add_job;

diag_log "VN MikeForce: Starting player list tracker";
// do slow allplayers list updates
["loadbal_fps_aggregator", {call para_s_fnc_loadbal_fps_aggregator}, [], 15] call para_g_fnc_scheduler_add_job;

// Clear Trees
["GET", "chopped_trees", ""] call para_s_fnc_profile_db params ["","_chopped_trees"];
if !(_chopped_trees isEqualType "") then {
    {[_x] call para_s_fnc_fell_tree_initial;} forEach (_chopped_trees # 0);
};

//Example unit types. Should be made more dynamic as the gamemode progresses.
unit_civilian = "vn_c_men_20";
units_vc_basic = ["vn_o_men_vc_02","vn_o_men_vc_03","vn_o_men_vc_06", "vn_o_men_vc_12", "vn_o_men_vc_local_16", "vn_o_men_vc_local_12"];
units_vc_officer = ["vn_o_men_vc_01"];
units_vc_smg = ["vn_o_men_vc_06","vn_o_men_vc_05","vn_o_men_vc_04"];
units_vc_marksman = ["vn_o_men_vc_10", "vn_o_men_vc_local_10"];
units_vc_medic = ["vn_o_men_vc_08"];
units_vc_grenadier = ["vn_o_men_vc_07", "vn_o_men_nva_dc_07"];
units_vc_at = ["vn_o_men_vc_14", "vn_o_men_vc_local_28"];
units_vc_mg = ["vn_o_men_vc_11", "vn_o_men_vc_local_11"];

units_sog_teamleader = ["vn_b_men_sog_01", "vn_b_men_sog_13"];
units_sog_rto = ["vn_b_men_sog_02", "vn_b_men_sog_14"];
units_sog_medic = ["vn_b_men_sog_03", "vn_b_men_sog_15"];
units_sog_scout = ["vn_b_men_sog_09", "vn_b_men_sog_19"];
units_sog_grenadier = ["vn_b_men_sog_07", "vn_b_men_sog_11"];
units_sog_machinegunner = ["vn_b_men_sog_06", "vn_b_men_sog_16", "vn_b_men_sog_18"];

vehicles_nva_helis = ["vn_o_air_mi2_01_01"];
vehicles_nva_planes = [];
vehicles_vc_mortars = ["vn_o_vc_static_mortar_type63"];

pavn_ammo_crate = "Land_vn_pavn_weapons_stack2";
aa_emplacement_build_crate = "Land_vn_pavn_weapons_stack3";

jungleTraps = [
    "vn_mine_punji_01",
    "vn_mine_punji_02",
    "vn_mine_punji_03"
];

enemyAPMines = [
    "vn_mine_tripwire_arty",
    "vn_mine_tripwire_m16_04",
    "vn_mine_tripwire_f1_04",
    "vn_mine_tripwire_f1_02"
];

enemyATMines = [
    "vn_mine_tm57"
];

friendlyAPMines = [
    "vn_mine_m16",
    "vn_mine_m14",
    "vn_mine_m18_range",
    "vn_mine_m18_x3_range"
];

friendlyATMines = [
    "vn_mine_m15"
];

diag_log "VN MikeForce: Initialising stats";
[] call vn_mf_fnc_stats_init;

//Set date here - it's as good a place as any. Day is just before a full moon, for good night ops.
[vn_mf_dawnLength, vn_mf_dayLength, vn_mf_duskLength, vn_mf_nightLength] call para_s_fnc_day_night_subsystem_init;

diag_log "VN MikeForce: Initialising Loadbalancer";
//Initialise the AI loadbalancer.
[] call para_s_fnc_loadbal_subsystem_init;


diag_log "VN MikeForce: Initialising AI Objectives";
// start ai subsystem. Depends on the load balancer subsystem.
[
    ["hardAiLimit", ["hard_ai_limit", 80] call BIS_fnc_getParamValue]
] call para_s_fnc_ai_obj_subsystem_init;

diag_log "VN MikeForce: Initialising Harass";
// Start harassment subsystem. Depends on the AI subsystem.
[] call para_s_fnc_harass_subsystem_init;

diag_log "VN MikeForce: Initialising Vehicle Manager";
// start vehicle asset management subsystem
[] call vn_mf_fnc_veh_asset_subsystem_init;

diag_log "VN MikeForce: Initialising Vehicle Creation Detection";
// start vehicle creation detection subsystem
[] call vn_mf_fnc_veh_create_detection_subsystem_init;

diag_log "VN MikeForce: Initialising AI Behaviour";
// start the behaviour subsystem
[] call para_g_fnc_ai_behaviour_subsystem_init;

//Set up slingloaded item locality on helicopters.
["vehicleCreated", [
    {
        params ["_args", "_vehicle"];
        //Call it on every vehicle - it'll abort if it's not a helicopter.
        [_vehicle] call para_g_fnc_localize_slingloaded_objects;
    },
    []
]] call para_g_fnc_event_add_handler;

diag_log "VN MikeForce: Initialising Zones";
// Initialise the zones
[] call vn_mf_fnc_zones_init;

diag_log "VN MikeForce: Initialising Sites";
// Initialise sites - must be done after zones.
[] call vn_mf_fnc_sites_init;

diag_log "VN MikeForce: Initialising Gameplay Director";
// Initialise the gameplay director
[] call vn_mf_fnc_director_init;

diag_log "VN MikeForce: Initialising Respawn Scheduler";
// Initialise respawn job
["veh_asset_respawner_job", {call vn_mf_fnc_veh_asset_respawn_job}, [], 1] call para_g_fnc_scheduler_add_job;

diag_log "VN MikeForce: Initialising Performance Logging";
[] call vn_mf_fnc_init_performance_logging;

diag_log "VN MikeForce: Initialising Dynamic Groups";
["Initialize"] call para_c_fnc_dynamicGroups;
