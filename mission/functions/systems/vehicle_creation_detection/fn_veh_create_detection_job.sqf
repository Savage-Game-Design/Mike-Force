/*
    File: fn_veh_create_detection_job.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
		Job that runs periodically to detect new vehicles.
    
    Parameter(s):
        None
    
    Returns:
        Function reached the end [BOOL]
    
    Example(s):
		["vehicle_creation_detection", vn_mf_fnc_veh_create_detection_job, [], 30] para_g_fnc_scheduler_add_job;
*/


private _newVehicles = vehicles select {!(_x getVariable ["vehCreateEventFired", false])};

{
	["vehicleCreated", _x] call para_g_fnc_event_dispatch;
  _x setVariable ["vehCreateEventFired", true];
} forEach _newVehicles;


true