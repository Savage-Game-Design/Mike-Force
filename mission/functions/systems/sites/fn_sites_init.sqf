/*
    File: fn_sites_init.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
        Starts the sites system, which is responsible for managing all of the AI controlled installations and building new ones.
    
    Parameter(s):
        None
    
    Returns:
        None
    
    Example(s):
        [] call vn_mf_fnc_sites_init
*/
vn_mf_s_max_camps_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_camps_per_zone");
vn_mf_s_max_aa_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_aa_per_zone");
vn_mf_s_max_artillery_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_artillery_per_zone");
vn_mf_s_max_fortifications_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_fortifications_per_zone");
vn_mf_s_max_tunnels_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_tunnels_per_zone");
vn_mf_s_max_vehicle_depots_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_vehicle_depots_per_zone");


vn_mf_g_sites_partial_discovery_radius = ["sites_partial_discovery_radius_meters", 300] call BIS_fnc_getParamValue;
publicVariable "vn_mf_g_sites_partial_discovery_radius";

vn_mf_g_sites_discovery_radius = ["sites_discovery_radius_meters", 50] call BIS_fnc_getParamValue;
publicVariable "vn_mf_g_sites_discovery_radius";

vn_mf_g_sites_scout_action_cooldown = ["sites_scout_action_cooldown_seconds", 30] call BIS_fnc_getParamValue;
publicVariable "vn_mf_g_sites_scout_action_cooldown";

vn_mf_s_sites_discovery_aa_marker_enabled = [false, true] select (["sites_discovery_aa_marker_toggle", 1] call BIS_fnc_getParamValue);

missionNamespace setVariable ["sites", []];
publicVariable "sites";

private _loadSuccessful = [] call vn_mf_fnc_sites_load;

if !(_loadSuccessful) then 
{
    //Generate sites
    [] call vn_mf_fnc_sites_generate;
};

[] call vn_mf_fnc_sites_aa_reveal_targets;


/*
["sites_discovery_something_number", 100] call _fnc_load_from_params;
["sites_discovery_something_bool", false, true] call _fnc_load_from_params;


private _fnc_load_bool_from_params = {
    params [
        ["_param_key", "", ""],
        ["_default_value", false, true]
    ];

    [false, true] select ([param_key, [0, 1] select _default_value] call BIS_fnc_getParamValue);

};
*/