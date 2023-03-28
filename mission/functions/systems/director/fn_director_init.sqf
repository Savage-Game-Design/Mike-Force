/*
	File: fn_director_init.sqf
	Author: Savage Game Design
	Public: Yes
	
	Description:
		Initialises the gameplay director subsystem
		This subsystem is responsible for handling primary tasks, and directing mission flow.
	
	Parameter(s):
		None
	
	Returns:
		None
	
	Example(s):
		[] call vn_mf_fnc_director_init;
*/

//Array in format - [Task Object]
mf_s_dir_activeZones = createHashMap;
mf_s_baseZoneUnlockDistance = 4000;

mf_g_dir_activeZoneNames = [];
publicVariable "mf_g_dir_activeZoneNames";

//Delay between actions.
mf_s_dir_action_delay = 1200;
mf_s_dir_current_action = [objNull];
mf_s_dir_next_action_time = serverTime;
mf_s_dir_attack_prep_time = 600;
mf_s_dir_action_fired = true; //Mark it as dispatched, so we reset back to a new timer.

//Create tasks for any zones that aren't captured, but are connected a captured zone.
[] call vn_mf_fnc_director_open_connected_zones;

// Trigger a zone process whenever a task completes there, to make the zones feel more responsive.
[
	"taskCompleted",
	[{
		params ["_handlerParams", "_eventParams"];
		_eventParams params ["_taskDataStore"];
		private _zoneName = _taskDataStore getVariable ["taskMarker", ""];
		if (_zoneName in mf_s_dir_activeZones) then {
			[_zoneName] call vn_mf_fnc_director_process_active_zone;
		};
	}, []]
] call para_g_fnc_event_add_handler;

["gameplay_director", vn_mf_fnc_director_job, [], 15] call para_g_fnc_scheduler_add_job;