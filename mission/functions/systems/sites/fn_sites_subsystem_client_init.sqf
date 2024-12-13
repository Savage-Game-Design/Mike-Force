/*
    File: fn_sites_subsystem_client_init.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
        Starts the client portion of the sites system.
    
    Parameter(s):
        None
    
    Returns:
        None
    
    Example(s):
        [] call vn_mf_fnc_sites_client_init
*/

vn_mf_c_sites_partial_discovery_marker_alpha_percent = (["sites_partial_discovery_marker_alpha_percent", 30] call BIS_fnc_getParamValue) / 100;
vn_mf_c_sites_discovery_marker_alpha_percent = (["sites_discovery_marker_alpha_percent", 50] call BIS_fnc_getParamValue) / 100;

private _toggle_site_discovery = [false, true] select (["sites_passive_discovery_toggle", 1] call BIS_fnc_getParamValue);
if (!_toggle_site_discovery) exitWith {true};

/*
    The marker discovery system allows site markers to be discovered thru passive exploration of the map
    as well as thru active scouting. 
    This initialises the passive exploration of the system.
*/
["marker_discovery_subsystem", vn_mf_fnc_sites_discovery_job, [], 10] call para_g_fnc_scheduler_add_job;

true