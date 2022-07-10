/*
    File: fn_task_sup_destroy_target.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Support task for destroyed a specific type of target in an area.
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
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _taskConfig = _taskDataStore getVariable "taskConfig";
	private _taskParameters = _taskConfig >> "parameters";

	private _targetPos = _taskDataStore getVariable "supportRequestPos";

	_taskDataStore setVariable ["targetTypes", getArray (_taskParameters >> "targetTypes")];

	[[["destroy_targets", _targetPos]]] call _fnc_initialSubtasks;
}];

/*
_taskDataStore setVariable ["go_to_area", {
	params ["_taskDataStore"];

	private _groups = (_taskDataStore getVariable "taskGroups") apply {missionNamespace getVariable [_x, grpNull};
	private _players = [];
	{ _players append units _x } forEach _groups;

	private _targetPos = _taskDataStore getVariable "supportRequestPos";
	if (_players inAreaArray [_targetPos, 50, 50]) then {
		["SUCCEEDED", [["destroy_targets", _targetPos]]] call _fnc_finishSubtask;
	};
}];
*/
_taskDataStore setVariable ["destroy_targets", {
	params ["_taskDataStore"];

	private _targetPos = _taskDataStore getVariable "supportRequestPos";
	
	private _targetsAlive = false;

	{
		if (_targetPos nearEntities [_x, 50] findIf {alive _x} > -1) exitWith {
			_targetsAlive = true;
		};
	} forEach (_taskDataStore getVariable "targetTypes");

	if (!_targetsAlive) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};

}];

_taskDataStore setVariable ["FINISH", {
}];