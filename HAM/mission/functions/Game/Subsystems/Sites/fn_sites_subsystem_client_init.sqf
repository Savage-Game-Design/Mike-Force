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

/*
    The marker discovery system allows site markers to be discovered thru passive exploration of the map
    as well as thru active scouting. 
    This initialises the passive exploration of the system.
*/
["marker_discovery_subsystem", vn_mf_fnc_sites_discovery_job, [], 10] call para_g_fnc_scheduler_add_job;

true