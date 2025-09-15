// @dijksterhuis: PR TODO: Add new Stringtable entries.
// @dijksterhuis: PR TODO: Delete old description/subheading Stringtable entries.
// @dijksterhuis: PR TODO: vn_artillery config options from here instead of config file?
// @dijksterhuis: PR TODO: the bra mission.sqm needs the presence condition for advanced revive module added.
// @dijksterhuis: PR TODO: sites -- configure the max random distance from site pos for markers?
// @dijksterhuis: PR TODO: helper function to load booleans variable from 0/1 parameter values (see below)
/*
// ["sites_discovery_something_bool", false] call _fnc_load_from_params;

params [
    ["_param_key", "", ""],
    ["_default_value", false, true]
];

[false, true] select ([param_key, [0, 1] select _default_value] call BIS_fnc_getParamValue);
*/
/* ================================ BOILERPLATE ================================*/

#define TOGGLE_OPTION_DISABLED_DEFAULT(class_name, string_title) \
    class class_name \
    { \
        title = string_title; \
        values[] = {0, 1}; \
        texts[] = {"Disabled (Default)", "Enabled"}; \
        default = 0; \
    };

#define TOGGLE_OPTION_ENABLED_DEFAULT(class_name, string_title) \
    class class_name \
    { \
        title = string_title; \
        values[] = {0, 1}; \
        texts[] = {"Disabled", "Enabled (Default)"}; \
        default = 1; \
    };


#define HEADER_CLASS(class_name, string_title) \
    class class_name \
    { \
        title = string_title; \
        values[] = {""}; \
        texts[] = {""}; \
        default = ""; \
    };


/* ================================ MISC ================================*/

HEADER_CLASS(misc_header, "$STR_vn_mf_param_misc_header")

TOGGLE_OPTION_DISABLED_DEFAULT(wipe_save, "$STR_vn_mf_param_wipe_save")
TOGGLE_OPTION_DISABLED_DEFAULT(enable_ranks, "$STR_vn_mf_param_enable_ranks")
TOGGLE_OPTION_ENABLED_DEFAULT(allow_map_markers, "$STR_vn_mf_param_allow_map_markers")

class respawn_delay
{
    title = $STR_vn_mf_param_respawn_delay;
    values[] = {5, 10, 20, 30};
    texts[] = {"5 seconds", "10 seconds", "20 seconds (Default)", "30 seconds"};
    default = 20;
};

TOGGLE_OPTION_DISABLED_DEFAULT(
    toggle_global_tutorials,
    "TOGGLE TUTORIAL HINTS: Toggle tutorial hints for all players; overrides player gamemode option for tutorial hints"
)

/* ================================ ZONES ================================*/
HEADER_CLASS(zones_header, "========================================== Zones ==========================================")

class zones_concurrent_active_limit
{
    title = "ACTIVE ZONES LIMIT: Limit the number of active zones";
    values[] = {1, 2, 3, 4, -1};
    texts[] = {"One Zone", "Two Zones", "Three Zones", "Four Zones", "No Limit"};
    default = -1;
};

class zones_marker_alpha_percent
{
    title = "ZONE MARKER ALPHA: Change the zone map marker alpha value";
    values[] = {0, 10, 20, 30, 40, 50, 60, 70};
    texts[] = {"0% (Disabled)", "10%", "20%", "30%", "40%", "50% (Default)", "60%", "70%"};
    default = 50;
};

/* ================================ SITES ================================*/
HEADER_CLASS(sites_header, "========================================== Sites ==========================================")

TOGGLE_OPTION_ENABLED_DEFAULT(
    sites_passive_discovery_toggle,
    "TOGGLE SITE PASSIVE DISCOVERY: Enable/Disable displaying site map markers when players are nearby"
)

class sites_partial_discovery_radius_meters
{
    title = "PARTIAL DISCOVERY MARKER RADIUS: Radius from player where partially discovered site map markers display (red circles)";
    values[] = {100, 200, 300, 400, 500};
    texts[] = {"100M", "200M", "300M (Default)", "400M", "500M"};
    default = 300;
};

class sites_partial_discovery_marker_alpha_percent
{
    title = "PARTIAL DISCOVERY MARKER ALPHA: Change the map marker alpha value for partially discovered sites (red circles)";
    values[] = {0, 10, 20, 30, 40, 50, 60, 70};
    texts[] = {"0% (Disabled)", "10%", "20%", "30% (Default)", "40%", "50%", "60%", "70%"};
    default = 30;
};

class sites_discovery_radius_meters
{
    title = "FULL DISCOVERY MARKER RADIUS: Radius from player where fully discovered site map markers display (objective markers)";
    values[] = {25, 50, 75, 100, 150, 200};
    texts[] = {"25M", "50M (Default)", "75M", "100M", "150M", "200M"};
    default = 50;
};

class sites_discovery_marker_alpha_percent
{
    title = "FULL DISCOVERY MARKER ALPHA: Change the map marker alpha value for fully discovered sites (objective markers)";
    values[] = {0, 10, 20, 30, 40, 50, 60, 70};
    texts[] = {"0% (Disabled)", "10%", "20%", "30%", "40%", "50% (Default)", "60%", "70%"};
    default = 50;
};

TOGGLE_OPTION_ENABLED_DEFAULT(
    sites_discovery_aa_marker_toggle,
    "TOGGLE AA AOE FULL DISCOVERY MARKER: Toggle the hashed 'area of effect' marker for fully discovered AA sites"
)

class sites_scout_action_cooldown_seconds
{
    title = "SCOUTING COOLDOWN: Time players must wait until they can use the scout action again";
    values[] = {15, 30, 45, 60, 90, 120, 180, 300, 600};
    texts[] = {"15 Seconds", "30 Seconds (Default)", "45 Seconds", "60 Seconds", "90 Seconds", "2 Minutes", "3 Minutes", "5 Minutes", "10 Minutes"};
    default = 30;
};

/* ================================ STAMINA ================================*/

HEADER_CLASS(stamina_header, "$STR_vn_mf_param_stamina_header")

TOGGLE_OPTION_DISABLED_DEFAULT(enable_stamina, "$STR_vn_mf_param_enable_stamina")

class set_stamina
{
    title = $STR_vn_mf_param_set_stamina;
    values[] = {0, 1, 2, 3};
    texts[] = {"Normal", "Default", "FastDrain", "Exhausted"};
    default = 1;
};

/* ================================ AI UNITS ================================*/

HEADER_CLASS(ai_header, "$STR_vn_mf_param_ai_header")

class hard_ai_limit
{
    title = $STR_vn_mf_param_hard_ai_limit;
    values[] = {60, 80, 100, 120, 140, 160, 180, 200};
    texts[] = {"60", "80 (recommended)", "100", "120", "140", "160", "180", "200"};
    default = 80;
};

class ai_scaling
{
    title = $STR_vn_mf_param_ai_scaling;
    values[] = {25, 50, 75, 100, 150, 200, 250, 300};
    texts[] = {"25%", "50%", "75%", "100%", "150%", "200%", "250%", "300%"};
    default = 100;
};

TOGGLE_OPTION_ENABLED_DEFAULT(
    ai_harass_enabled,
    "TOGGLE AI HARASS: Enable AI harassment units to track/hunt players on specific teams"
)

class ai_harass_minimum_delay
{
    title = "AI HARASS MINIMUM SPAWN DELAY: Minimum timne between spawning new harassment units";
    values[] = {60, 120, 180, 240, 300, 360};
    texts[] = {"1 Minute", "2 Minutes", "3 Minutes", "4 Minutes (Default)", "5 Minutes", "6 Minutes"};
    default = 240;
};

TOGGLE_OPTION_DISABLED_DEFAULT(
    ai_harass_inside_zones,
    "AI HARASSMENT IN ZONES: Whether harassment units will spawn for players inside active zones or not"
)


/* ================================ BUILDING SYSTEMS ================================*/

HEADER_CLASS(building_header, "$STR_vn_mf_param_building_header")

TOGGLE_OPTION_ENABLED_DEFAULT(
    toggle_building_systems,
    "TOGGLE BUILDING SYSTEM: Enable/disable the Mike Force build system for all players."
)
TOGGLE_OPTION_DISABLED_DEFAULT(
    buildables_require_vehicles,
    "$STR_vn_mf_buildables_require_vehicles"
)

class building_sandbag_value
{
    title = $STR_vn_mf_building_sandbag_value;
    values[] = {1, 5, 10, 20, 30, 40, 50};
    texts[] = {"1", "5", "10 (Default)", "20", "30", "40", "50"};
    default = 10;
};

/* ================================ VEHICLE SYSTEMS ================================*/

HEADER_CLASS(veh_asset_header, "========================================== Vehicle Asset Management ==========================================")

class veh_asset_abandoned_timer_seconds
{
    title = "IDLE VEHICLE TIMER: Length of time until vehicles are marked as abandoned (idle) on map"
    values[] = {120, 180, 240, 300, 360, 420, 480, 540, 600};
    texts[] = {"2 Minutes", "3 Minutes", "4 Minutes", "5 Minutes (Default)", "6 Minutes", "7 Minutes", "8 Minutes", "9 Minutes", "10 Minutes"};
    default = 300;
};

class veh_asset_abandoned_min_distance
{
    title = "IDLE VEHICLE DISTANCE: Distance from the vehicle spawn point for vehicles to be marked as abandoned (idle) on map"
    values[] = {20, 60, 100, 140, 180};
    texts[] = {"20 Meters (Default)", "60 Meters", "100 Meters", "140 Meters", "180 Meters"};
    default = 20;
};

TOGGLE_OPTION_ENABLED_DEFAULT(
    veh_asset_lock_idle_vehicles,
    "IDLE VEHICLE LOCKING TOGGLE: Whether abandoned (idle) vehicles should be locked (simulation disabled)"
)

class veh_asset_relock_time_seconds
{
    title = "IDLE VEHICLE LOCK TIME: How long to wait before locking a vehicle once it is marked as abandoned (idle)"
    values[] = {10, 30, 60, 90, 120};
    texts[] = {"10", "30 (Default)", "60", "90", "120"};
    default = 30;
};

class veh_asset_marker_update_delay_seconds
{
    title = "MARKER UPDATE TIMER: Length of time between updating position of a vehicle's map marker"
    values[] = {10, 30, 60, 90, 120};
    texts[] = {"10 (Default)", "30", "60", "90", "120"};
    default = 10;
};


/* ================================ DAY / NIGHT TIME LENGTH ================================*/

#define DAYNIGHT_TIME_CLASS(X, Y, Z) \
    class X \
    { \
        title = Y; \
        values[] = {600, 1200, 1800, 2400, 3600, 5400, 7200, 9000, 10800, 21600, 43200, 86400, 172800}; \
        texts[] = {"10 minutes", "20 minutes", "30 minutes", "40 minutes", "1 hour", "1.5 hours", "2 hours", "2.5 hours", "3 hours", "6 hours", "12 hours", "24 hours", "48 hours"}; \
        default = Z; \
    };


HEADER_CLASS(daynight_length_header, "$STR_vn_mf_param_daynight_length_header")

DAYNIGHT_TIME_CLASS(dawn_length, "$STR_vn_mf_dawn_length", 1200)
DAYNIGHT_TIME_CLASS(day_length, "$STR_vn_mf_day_length", 7200)
DAYNIGHT_TIME_CLASS(dusk_length, "$STR_vn_mf_dusk_length", 1200)
DAYNIGHT_TIME_CLASS(night_length, "$STR_vn_mf_night_length", 1200)

/* ================================ MAX PLAYERS PER TEAM ================================*/

#define MAXPLAYERS_CLASS(X, Y, Z) \
    class X \
    { \
        title = Y; \
        values[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30, 35, 40, 45, 50, 99}; \
        texts[] = {"0 players", "1 player", "2 players", "3 players", "4 players", "5 players", "6 players", "7 players", "8 players", "9 players", "10 players", "15 players", "20 players", "25 players", "30 players", "35 players", "40 players", "45 players", "50 players", "99 players"}; \
        default = Z; \
    };

HEADER_CLASS(teams_header, "$STR_vn_mf_param_teams_header")

MAXPLAYERS_CLASS(max_players_acav, "$STR_vn_mf_max_players_acav", 99)
MAXPLAYERS_CLASS(max_players_greenhornets, "$STR_vn_mf_max_players_greenhornets", 99)
MAXPLAYERS_CLASS(max_players_mikeforce, "$STR_vn_mf_max_players_mikeforce", 99)
MAXPLAYERS_CLASS(max_players_spiketeam, "$STR_vn_mf_max_players_spiketeam", 6)

/* ================================ VN SUPPORT MODULE ================================*/

HEADER_CLASS(vnsupport_header, "$STR_vn_mf_param_vnsupport_header")

class enable_air_support
{
    title = $STR_vn_mf_enable_air_support;
    values[] = {0, 1, 2};
    texts[] = {"Disabled", "Enabled (Default)", "Enabled: Unique Supports Only"};
    default = 1;
};

TOGGLE_OPTION_DISABLED_DEFAULT(enable_arty_support, "$STR_vn_mf_enable_arty_support")

/* ================================ MEDICAL SYSTEM ================================*/

HEADER_CLASS(medical_header, "$STR_vn_mf_param_medical_header")

TOGGLE_OPTION_ENABLED_DEFAULT(
    advanced_revive,
    "TOGGLE ADVANCED REVIVE: Toggles SOG Prairie Fire Medical System; subsequent medical settings are ignored when disabled"
)
TOGGLE_OPTION_DISABLED_DEFAULT(revive_headshot_kill, "$STR_vn_mf_param_headshot_kill")
TOGGLE_OPTION_ENABLED_DEFAULT(always_allow_withstand, "$STR_vn_mf_always_allow_withstand")

class revive_bleedout_time
{
    title = $STR_vn_mf_param_bleedout_time;
    values[] = {100, 200, 300, 400, 500};
    texts[] = {"100", "200", "300 (Default)", "400", "500"};
    default = 300;
};

class revive_withstand_percentage
{
    title = $STR_vn_mf_param_withstand_percentage;
    values[] = {30, 50, 70, 80, 100};
    texts[] = {"70%", "50%", "30%", "20% (Default)", "0%"};
    default = 80;
};

class revive_respawn_action_time
{
    title = "RESPAWN PERCENTAGE: Percentage of bleedout time that must pass before respawning is an option";
    values[] = {25, 45, 65, 75, 95};
    texts[] = {"75%", "55%", "35%", "25% (Default)", "5%"};
    default = 75;
};

class revive_revive_delay
{
    title = "REVIVE DELAY: How long players must wait until they can revive a patient";
    values[] = {0, 5, 10, 15, 20, 30, 45, 60};
    texts[] = {"No Delay", "5 Seconds (Default)", "10 Seconds", "15 Seconds", "20 Seconds", "30 Seconds", "45 Seconds", "60 Seconds"};
    default = 5;
};

TOGGLE_OPTION_ENABLED_DEFAULT(
    revive_bleedout_affects_actions,
    "TOGGLE BLEEDOUT AFFECTS ACTIONS: If the time spent bleeding out decreases the chances to complete actions."
)

// @dijksterhuis: PR TODO: Add other chance actions (again)

class revive_move_chance
{
    title = "ROLL OVER MOVE CHANCE: Base chance of rolling over when pressing movement keys (multiplied by current bleedout time)";
    values[] = {0, 25, 50, 75, 100};
    texts[] = {"0%", "25%", "50%", "75% (Default)", "100%"};
    default = 75;
};

TOGGLE_OPTION_DISABLED_DEFAULT(revive_revive_requirement, "$STR_vn_mf_param_revive_requirement")

class revive_bandage_item
{
    values[] = {0, 1, 2};
    title = "BANDAGE ITEMS: Items that can be used to stabilize patients";
    texts[] = {"Nothing", "Medikits", "Medikits + First Aid Kits (Default)"};
    default = 2;
};

TOGGLE_OPTION_ENABLED_DEFAULT(revive_remove_bandage_item, "$STR_vn_mf_param_remove_bandage_item")

class revive_revive_item
{
    values[] = {0, 1, 2};
    title = "REVIVE ITEMS: Items that can be used to resucitate patients";
    texts[] = {"Nothing", "Medikits", "Medikits + First Aid Kits (Default)"};
    default = 2;
};

TOGGLE_OPTION_DISABLED_DEFAULT(revive_remove_revive_item, "$STR_vn_mf_param_remove_revive_item")

class revive_icon_distance
{
    title = "INCAPACITATED ICON DISTANCE";
    values[] = {0, 25, 50, 75, 100, 125, 150, 175, 200};
    texts[] = {"0 Meters", "25 Meters", "50 Meters (Default)", "75 Meters", "100 Meters", "125 Meters", "150 Meters", "175 Meters", "200 Meters"};
    default = 50;
};

/* ================================ SNAKE BITES ================================*/

HEADER_CLASS(snake_header, "$STR_vn_mf_param_snake_header")

class snake_bite_chance
{
    title = $STR_vn_mf_param_snake_bite_chance;
    values[] = {0, 15, 25, 35, 50, 65, 75};
    texts[] = {"0% (Off)", "15%", "25%", "35%", "50% (Default)", "65%", "75%"};
    default = 50;
};

class snake_bite_distance
{
    title = $STR_vn_mf_param_snake_bite_distance;
    values[] = {25, 50, 75, 100, 125, 150};
    texts[] = {"25cm", "50cm", "75cm", "1m (Default)", "1.25m", "1.5m"};
    default = 100;
};

class snake_bite_frequency
{
    title = $STR_vn_mf_param_snake_bite_frequency;
    values[] = {150, 300, 450, 600};
    texts[] = {"2.5 minutes", "5 minutes (Default)", "7.5 minutes", "10 minutes"};
    default = 300;
};

class snake_bite_extra_time
{
    title = $STR_vn_mf_param_snake_bite_extra_time;
    values[] = {150, 300, 450, 600};
    texts[] = {"2.5 minutes", "5 minutes (Default)", "7.5 minutes", "10 minutes"};
    default = 300;
};

/* ================================ HUNGER/THIRST ================================*/

HEADER_CLASS(consumables_header, "$STR_vn_mf_param_hunger_thirst_header")

class hunger_loss_rate
{
    title = $STR_vn_mf_param_hunger_loss_rate;
    values[] = {1, 5, 10, 25, 50, 100};
    texts[] = {"0.01%", "0.05% (Default)", "0.1%", "0.25%", "0.5%", "1%"};
    default = 5;
};

class thirst_loss_rate
{
    title = $STR_vn_mf_param_thirst_loss_rate;
    values[] = {1, 5, 10, 25, 50, 100};
    texts[] = {"0.01%", "0.05%", "0.1% (Default)", "0.25%", "0.5%", "1%"};
    default = 10;
};

/* ================================ CLEAN UP SYSTEMS ================================*/

HEADER_CLASS(cleanup_header, "$STR_vn_mf_param_cleanup_header")

class cleanup_min_player_distance
{
    title = $STR_vn_mf_param_cleanup_min_player_distance;
    values[] = {10, 50, 100, 200, 300, 400, 500, 1000};
    texts[] = {"10m", "50m", "100m", "200m", "300m", "400m", "500m", "1000m"};
    default = 400;
};

class cleanup_max_bodies
{
    title = $STR_vn_mf_param_cleanup_max_bodies;
    values[] = {10, 25, 50, 75, 100, 125, 150, 200};
    texts[] = {"10", "25", "50", "75", "100", "125", "150", "200"};
    default = 50;
};

TOGGLE_OPTION_ENABLED_DEFAULT(cleanup_placed_gear, "$STR_vn_mf_param_cleanup_placed_gear")
TOGGLE_OPTION_ENABLED_DEFAULT(cleanup_dropped_gear, "$STR_vn_mf_param_cleanup_dropped_gear")

class cleanup_placed_gear_lifetime
{
    title = $STR_vn_mf_param_cleanup_placed_gear_lifetime;
    values[] = {60, 120, 180, 300, 600, 1800, 3600};
    texts[] = {"1 minute", "2 minutes", "3 minutes", "5 minutes", "10 minutes", "30 minutes", "1 hour"};
    default = 300;
};

class cleanup_dropped_gear_lifetime
{
    title = $STR_vn_mf_param_cleanup_dropped_gear_lifetime;
    values[] = {60, 120, 180, 300, 600, 1800, 3600};
    texts[] = {"1 minute", "2 minutes", "3 minutes", "5 minutes", "10 minutes", "30 minutes", "1 hour"};
    default = 300;
};
