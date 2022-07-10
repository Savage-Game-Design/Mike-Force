/*
	File: fn_task_subtask_create.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Marks an existing task as complete and cleans up the tasks so there's no leaked resources.
		This is *only* for top-level tasks. *Not* subtasks.

	Parameters(s):
		_parentDataStore - Data store of the parent task [Location]
		_subtaskType - Id of the subtask to create (currently classname) [String]
		_subtaskPos - Position of the newly created subtask [Position2D]

	Returns:
		boolean [Boolean]

	Example Usage:
		[parentTaskDataStore, subtaskId] call vn_mf_fnc_task_subtask_create
*/


params ["_parentDataStore", "_subtaskType", ["_subtaskPos", objNull]];

private _parentTaskId = _parentDataStore getVariable ["taskId", ""];
private _parentConfig = _parentDataStore getVariable ["taskConfig", configNull];
private _subtaskConfig = (_parentConfig >> _subtaskType);

if !(isClass _subtaskConfig) exitWith {
	["Unable to create subtask - invalid config %1", _subtaskConfig] call BIS_fnc_logFormat;
	false;
};

private _subtaskName = getText (_subtaskConfig >> "taskname");
private _subtaskDesc = getText (_subtaskConfig >> "taskdesc");
private _taskGroups = _parentDataStore getVariable ["taskGroups", []] apply {missionNamespace getVariable _x};

private _subtasks = _parentDataStore getVariable ["taskSubtasks", []];
private _subtaskTaskId = format ["%1_%2_%3", _parentTaskId, count _subtasks,  _subtaskType];
_subtasks pushBack [_subtaskTaskId, _subtaskType];

//TODO: Add more checks here to make sure we have all data needed to create subtask.
//Set the subtask list to include our new subtask
_parentDataStore setVariable ["taskSubtasks", _subtasks];

//Update our supplementary info before updating the task framework.
call vn_mf_fnc_task_update_clients;
//Call Bohemia's task framework to create the subtask
[true, [_subtaskTaskId, _parentTaskId], [_subtaskDesc, _subtaskName, "Fish"], _subtaskPos, "CREATED", 10, false] call BIS_fnc_taskCreate;
[_subtaskTaskId] remoteExecCall ["vn_mf_fnc_task_client_on_task_created", 0];

_subtaskTaskId
