/*
    File: fn_task_client_on_task_created.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Fired on all clients by our task system when a task is created.
    
    Parameter(s):
        _taskId - Id of the task created [String]
    
    Returns: none
    
    Example(s):
        [_createdTaskId] remoteExecCall ["vn_mf_fnc_task_client_on_task_created", 0];
*/

params ["_taskId"];

if (!hasInterface) exitWith {};

private _lastTask = player getVariable ["lastTask", taskNull];
private _newTask = player getVariable [(_taskId call BIS_fnc_taskVar), taskNull];

//At the time of writing, taskParent taskNull crashes Arma.
if (isNull _lastTask || isNull _newTask) exitWith {};

private _parent = taskParent _lastTask;

//Assign a new subtask within the current task if the player doesn't have one
if (!isNull _newTask && !isNull _parent && isNull currentTask player && taskParent _newTask == _parent && taskState _newTask in ["Created", "Assigned"]) then {
	player setCurrentTask _newTask;
	["TaskAssigned", ["", taskDescription _newTask select 1]] call para_c_fnc_show_notification;
};
