/*
	File: fn_task_pri_4a.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Primary 'Destroy Enemy Bunker'.
		Uses the state machine task system.

	Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

	Returns: nothing

	Example(s):
		Not directly called.
*/

/*
 * Task Parameters:
 *    None
 * Subtask Parameters:
 * 	  None
 * Runtime Parameters:
 *    pos - Position to spawn the bunker at.
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _bunkerPos = _taskDataStore getVariable ["pos", getMarkerPos (_taskDataStore getVariable "taskMarker")];

	private _bunker = ['Land_vn_b_trench_firing_05', _bunkerPos] call para_g_fnc_create_vehicle;

	_taskDataStore setVariable ["bunker", _bunker];

	[[["destroy_bunker", _bunkerPos getPos [20 + random 100, random 360]]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["destroy_bunker", {
	params ["_taskDataStore"];

	if !(alive (_taskDataStore getVariable ["bunker", objNull])) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	[_taskDataStore getVariable ["bunker", objNull]] call para_s_fnc_cleanup_add_items;
}];