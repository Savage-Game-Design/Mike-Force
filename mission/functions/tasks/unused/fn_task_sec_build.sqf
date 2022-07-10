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
	private _taskConfig = _taskDataStore getVariable "taskConfig";

	//Buildable is a non-optional parameter.
	private _buildableType = _taskDataStore getVariable "buildable";
	private _buildableConfig = missionConfigFile >> "gamemode" >> "buildables" >> _buildableType;

	if (!isClass _buildableConfig) then {
		diag_log format ["VN MikeForce: Warning, build task created for type %1, which has no class", _buildableType];
		["CANCELED"] call _fnc_finishTask;
	};

	_taskDataStore setVariable ["buildableVar", format ["para_buildings_%1", getText (_buildableConfig >> "type")]];

	[[
		["build", _zonePosition]
	]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["build", {
	params ["_taskDataStore"];

	private _zone = (_taskDataStore getVariable "taskMarker");
	private _buildables = missionNamespace getVariable [(_taskDataStore getVariable "buildableVar"), []];
	private _buildablesInZone = (_buildables inAreaArray _zone) select {alive _x};

	if !(_buildablesInZone isEqualTo []) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {

}];
