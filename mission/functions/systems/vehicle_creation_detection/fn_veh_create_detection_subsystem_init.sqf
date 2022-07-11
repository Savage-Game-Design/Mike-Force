/*
    File: fn_veh_create_detection_subsystem_init.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
        The Vehicle Creation Detection subsystem fires events when a vehicle is created.
		This initialises that subsystem.
    
    Parameter(s):
		None
    
    Returns:
        Function reached the end [BOOL]
    
    Example(s):
        [] call vn_mf_fnc_veh_create_detection_subsystem_init;
*/

["vehicle_creation_detection", vn_mf_fnc_veh_create_detection_job, [], 30] call para_g_fnc_scheduler_add_job;

true