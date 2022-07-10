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

vn_mf_g_sites_partial_discovery_radius = 300;
publicVariable "vn_mf_g_sites_partial_discovery_radius";
vn_mf_g_sites_discovery_radius = 50;
publicVariable "vn_mf_g_sites_discovery_radius";
vn_mf_g_sites_scout_action_cooldown = 30;
publicVariable "vn_mf_g_sites_scout_action_cooldown";

missionNamespace setVariable ["sites", []];
publicVariable "sites";

private _loadSuccessful = [] call vn_mf_fnc_sites_load;

if !(_loadSuccessful) then 
{
    //Generate sites
    [] call vn_mf_fnc_sites_generate;
};

[] call vn_mf_fnc_sites_aa_reveal_targets;
