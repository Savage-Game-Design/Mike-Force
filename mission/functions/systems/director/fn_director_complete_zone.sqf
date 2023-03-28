/*
    File: fn_director_complete_zone.sqf
    Author: Spoffy
    Date: 2023-01-07
    Last Update: 2023-01-07
    Public: Yes
    
    Description:
	   	Closes down an active zone, and marks it as completed.
    
    Parameter(s):
	   	_zone - Zone to complete [STRING]
    
    Returns:
	   	Nothing
    
    Example(s):
		["zone_ba_ria"] call vn_mf_fnc_director_complete_zone;
*/

params ["_zone"];

if !(_zone in mf_s_dir_activeZones) exitWith {
	["WARNING", format ["Attempting to close inactive zone '%1'", _zone]] call para_g_fnc_log;
};

private _zoneInfo = mf_s_dir_activeZones get _zone;

private _task = _zoneInfo getOrDefault ["currentTask", objNull];
if !([_task] call vn_mf_fnc_task_is_completed) then {
	[_task, 'SUCCEEDED'] call vn_mf_fnc_task_complete;
};

[_zone] call vn_mf_fnc_zones_capture_zone;
[] call vn_mf_fnc_director_open_connected_zones;

mf_s_dir_activeZones deleteAt _zone;
mf_g_dir_activeZoneNames = keys mf_s_dir_activeZones;
publicVariable "mf_g_dir_activeZoneNames";