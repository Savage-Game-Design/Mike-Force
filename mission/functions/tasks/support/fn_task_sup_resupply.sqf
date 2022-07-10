/*
    File: fn_task_sup_resupply.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Support task for moving a resupply crate to a target.
		Uses the state machine task system.

    Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

    Returns: nothing

    Example(s):
        Not directly called.
*/

/*
 * Task Parameters:
 *    crateSpawnPosition - initial position to spawn the resupply crate.
 * Subtask Parameters:
 * 	  None
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _taskConfig = _taskDataStore getVariable "taskConfig";
	private _taskParameters = _taskConfig >> "parameters";

	private _supplies = getText (_taskParameters >> "supplies");
	private _supplyClass = getText (_taskParameters >> "supplyClass");
	private _crateType = getText (missionConfigFile >> "gamemode" >> "supplydrops" >> _supplyClass >> _supplies >> "className");
	_taskDataStore setVariable ["crateType", _crateType];

	private _deliverPosition = _taskDataStore getVariable "supportRequestPos";

	[[["deliver_crate", _deliverPosition]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["deliver_crate", {
	params ["_taskDataStore"];

	private _crateType = _taskDataStore getVariable "crateType";
	private _cratesInRange = entities _crateType inAreaArray [_taskDataStore getVariable "supportRequestPos", 50, 50, 0, false];
	private _crate = selectRandom _cratesInRange;

	if !(isNil "_crate") then {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	params ["_taskDataStore"];
}];