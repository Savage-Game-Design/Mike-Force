/*
    File: fn_task_client_on_task_completed.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Fired on all clients by our task system when a task is completed.
    
    Parameter(s):
       _taskId - Id of the task completed [String]
	   _completionType - Id of the task completed [String]
    
    Returns: none
    
    Example(s):
        [_completedTaskId, "SUCCEEDED"] remoteExecCall ["vn_mf_fnc_task_client_on_task_completed", 0];
*/

params ["_taskId", ["_completionType", ""]];

if (!hasInterface) exitWith {};

private _lastTask = player getVariable ["lastTask", taskNull];
private _completedTask = player getVariable (_taskId call BIS_fnc_taskVar);

if (!isNull _completedTask && !isNull _lastTask && {_lastTask isEqualTo _completedTask || taskParent _lastTask isEqualTo _completedTask}) then {
	if (_completionType == "SUCCEEDED") exitWith {
		["TaskSucceeded", ["", taskDescription _completedTask select 1]] call para_c_fnc_show_notification;
	};
	if (_completionType == "FAILED") exitWith {
		["TaskFailed", ["", taskDescription _completedTask select 1]] call para_c_fnc_show_notification;
	};
	if (_completionType == "CANCELED" || _completionType == "") then {
		["TaskCanceled", ["", taskDescription _completedTask select 1]] call para_c_fnc_show_notification;
	};

	//Now we assign a new subtask if one's available
	private _parent = taskParent _lastTask;

	//Assign a new subtask within the current task
	if (!isNull _parent && isNull currentTask player) then {
		private _availableChildren = taskChildren _parent select {taskState _x in ["Created", "Assigned"] && !(_x isEqualTo _completedTask)};
		if !(_availableChildren isEqualTo []) then {
			player setCurrentTask (_availableChildren select 0);
			["TaskAssigned", ["", taskDescription _completedTask select 1]] call para_c_fnc_show_notification;
		};
	};
};
