/*
    File: fn_director_process_active_zone.sqf
    Author: Spoffy
    Date: 2023-01-07
    Last Update: 2023-01-07
    Public: Yes
    
    Description:
	   	Checks the current status of the zone, and handles the flow for that zone if needed.
		For example, creating a new task or completing the zone.
    
    Parameter(s):
		_zone - The zone name [STRING]
    
    Returns:
	   	Nothing
    
    Example(s):
		["zone_ba_ria"] call vn_mf_fnc_director_process_active_zone;
*/

params ["_zone"];

if !(_zone in mf_s_dir_activeZones) exitWith {
	["WARNING", format ["Attempted to process inactive zone '%1'", _zone]] call para_g_fnc_log;
};

private _zoneInfo = mf_s_dir_activeZones get _zone;

private _currentState = _zoneInfo get "state";
private _task = _zoneInfo get "currentTask";
private _taskIsCompleted = [_task] call vn_mf_fnc_task_is_completed;
private _taskResult = _task getVariable ["taskResult", ""];

if (_taskIsCompleted) then {
	if (_currentState isEqualTo "capture") exitWith {
		["INFO", format ["Zone '%1' captured, moving to counterattack", _zone]] call para_g_fnc_log;

		private _counterattackTask = ((["defend_counterattack", _zone, [["prepTime", 180]]] call vn_mf_fnc_task_create) # 1);
		_zoneInfo set ["state", "counterattack"];
		_zoneInfo set ["currentTask", _counterattackTask];
	};

	if (_currentState isEqualTo "counterattack") exitWith {
		if (_taskResult isEqualTo "FAILED") exitWith {
			["INFO", format ["Zone '%1' defend against counterattack failed, moving to recapture zone", _zone]] call para_g_fnc_log;

			private _zoneData = mf_s_zones select (mf_s_zones findIf {_zone isEqualTo (_x select struct_zone_m_marker)});
			[[_zoneData]] call vn_mf_fnc_sites_generate;

			private _captureZoneTask = ["capture_zone", _zone] call vn_mf_fnc_task_create select 1; 
			_zoneInfo set ["state", "capture"];
			_zoneInfo set ["currentTask", _captureZoneTask];
		};

		// Task is finished, and hasn't failed
		["INFO", format ["Zone '%1' counterattack successfully defended against, completing zone", _zone]] call para_g_fnc_log;
		[_zone] call vn_mf_fnc_director_complete_zone;
	};
};

