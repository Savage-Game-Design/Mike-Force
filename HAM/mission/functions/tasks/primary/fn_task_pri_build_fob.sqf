/*
	File: fn_task_pri_build.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Primary task to build an FOB near to a zone.
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

	[[
		["build"]
	]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["build", {
	params ["_taskDataStore"];

	private _possibleBases = [] call vn_mf_fnc_director_zones_in_range_of_bases;

	if !(_possibleBases isEqualTo []) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {

}];
