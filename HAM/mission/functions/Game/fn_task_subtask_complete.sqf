/*
    File: fn_task_subtask_complete.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
		Marks an existing subtask as complete.
		This is *only* for subtasks. Do *NOT* use it on top-level tasks.

    Parameter(s):
		_parentDataStore - Data store of the parent task. [LOCATION]
		_subtaskId - Id of the subtask to create (currently classname) [STRING]
		_completionType - One of 'SUCCEEDED', 'CANCELED' or 'FAILED' [STRING]
    
    Returns:
		Successfully completed subtask [BOOL]
    
    Example(s):
		[taskDataStore, "13_subtask_a", "SUCCEEDED"] call vn_mf_fnc_task_subtask_complete
*/

params ["_parentDataStore", "_subtaskId", "_completionType"];

//Check we have a valid completion type. Abandon all hope if we aren't one of these!
if !(_completionType in ['CANCELED', 'FAILED', 'SUCCEEDED']) exitWith {
	["Not completing task %1 due to invalid completion type %2", _subtaskId, _completionType] call BIS_fnc_logFormat;
	false
};

private _parentTaskId = _parentDataStore getVariable ["taskId", ""];
private _parentSubtasks = _parentDataStore getVariable ["taskSubtasks", []];

private _subtaskArrayPos = _parentSubtasks findIf {_x # 0 == _subtaskId};
//If we're not in the parents list of subtasks, we must not exist! Do nothing.
if (_subtaskArrayPos < 0) exitWith {
	false
};

//Don't remove the subtask from the parent's list of subtasks, so we can clean it up or reference later if needed.
//_parentTasks deleteAt _subtaskArrayPos;

//Update our supplementary info before updating the task framework.
call vn_mf_fnc_task_update_clients;
//Return result of this taskSetState
private _result = [_subtaskId, _completionType, false] call BIS_fnc_taskSetState;
[_subtaskId, _completionType] remoteExecCall ["vn_mf_fnc_task_client_on_task_completed", 0];

_result