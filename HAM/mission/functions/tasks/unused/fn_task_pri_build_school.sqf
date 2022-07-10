/*
	File: fn_task_pri_build_school.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Primary task to build a school in the zone.
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
 *    None
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _zonePosition = getMarkerPos (_taskDataStore getVariable "taskMarker");

	[[
		["build_school", _zonePosition]
	]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["build_school", {
	params ["_taskDataStore"];

	private _zone = (_taskDataStore getVariable "taskMarker");

	private _schoolsInZone = (para_buildings_schools inAreaArray _zone) select {alive _x};

	if !(_schoolsInZone isEqualTo []) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {

}];
