/*
	File: fn_task_is_completed.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
    Checks if a task has been completed.
	
	Parameter(s):
    _taskDataStore - DataStore from the task to check [Location]
	
	Returns:
    whether the task is completed (or doesn't exist) [Boolean]
	
	Example(s):
    [vn_mf_tasks # 0 # 1] call vn_mf_fnc_task_is_completed
*/

params ["_taskDataStore"];

isNull _taskDataStore || _taskDataStore getVariable ["taskCompleted", false]
