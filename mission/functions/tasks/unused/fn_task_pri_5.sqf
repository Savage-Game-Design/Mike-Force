/*
	File: fn_task_pri_5.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Build a school in the zone.
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
 *    pos - Position to build the school at
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _defaultPosition = getMarkerPos (_taskDataStore getVariable "taskMarker");
	private _destPos = _taskDataStore getVariable ["pos", _defaultPosition];

	_taskDataStore setVariable ["destPos", _destPos];

	[[["build_school", _destPos]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["build_school", {
	params ["_taskDataStore"];

	private _destPos = _taskDataStore getVariable "destPos";
	if !((para_buildings_schools inAreaArray [_destPos, 50, 50, 0, false]) select {alive _x} isEqualTo []) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
}];