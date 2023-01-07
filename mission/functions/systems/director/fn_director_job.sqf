/*
    File: fn_director_job.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Periodic job that runs the gameplay director, which manages the main game flow.

    Parameter(s):
		None

    Returns:
		None

    Example(s):
		["gameplay_director", vn_mf_fnc_director_job, [], 30] call para_g_fnc_scheduler_add_job;
*/

/////////////////////////////////////////////////////////////////////////////////
// Identify the zones which have tasks finished and therefore need processing. //
/////////////////////////////////////////////////////////////////////////////////

private _zonesToProcess = [];

{
	private _zone = _x;
	private _info = _y;

	if ([_info getOrDefault ["currentTask", objNull]] call vn_mf_fnc_task_is_completed) then {
		_zonesToProcess pushBack _zone;
	};
} forEach mf_s_dir_activeZones;

{ [_x] call vn_mf_fnc_director_process_active_zone } forEach _zonesToProcess;

///////////////////////
// Mission end state //
///////////////////////

[] call vn_mf_fnc_director_check_mission_end;