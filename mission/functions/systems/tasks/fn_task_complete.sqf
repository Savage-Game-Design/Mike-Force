/*
	File: fn_task_complete.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Marks an existing task as complete and cleans up the tasks so there's no leaked resources.
		This is *only* for top-level tasks. *Not* subtasks.
	
	Parameter(s):
		_taskDataStore - DataStore from the task being completed [Location]
		_completionType - Type of the completion. Valid are 'CANCELED', 'FAILED' and 'SUCCEEDED' [String]
		_rankPoints - Optional, number of rank-points to award [Number, defaults to objNull]
	
	Returns:
		whether the task was successfully removed [Boolean]
	
	Example(s):
		[vn_mf_tasks # 0 # 1, "SUCCEEDED"] call vn_mf_fnc_task_complete
*/

params ["_taskDataStore", "_completionType", ["_rankPointsReward", objNull]];

private _taskClass = _taskDataStore getVariable "taskClass";
private _taskArrayPos = vn_mf_tasks findIf {_x select 1 isEqualTo _taskDataStore};

// Prevents an already completed task from being completed twice, or trying to complete an invalid task
if (_taskArrayPos < 0) exitWith {
	false
};

if !(_completionType in ['CANCELED', 'FAILED', 'SUCCEEDED']) exitWith {
	["Not completing task %1 due to invalid completion type %2", _taskClass, _completionType] call BIS_fnc_logFormat;
	false
};

private _task = vn_mf_tasks select _taskArrayPos;

//Remove the task from the tasks array, to avoid us thinking it's an active task later.
vn_mf_tasks deleteAt _taskArrayPos;

//Firstly - we set a flag in the taskDataStore, to inform the task we're done with it.
//This gives the task a chance to handle its own exit, and do its own cleanup. Then we don't have to worry about it.
//The task monitoring system should also use this to know which tasks can be removed safely.
//That's why we do this before any other checks kick in.
_taskDataStore setVariable ["taskCompleted", true];
_taskDataStore setVariable ["taskResult", _completionType];

//We tell the scheduler to only run the task once more.
//This is to give the task a chance to clean itself up, now taskCompleted is set.
//We use the task's Task Framework id for this.
private _job = [_task select 0] call para_g_fnc_scheduler_get_job;
_job setVariable ["remainingIterations", 1];

//Update the client with our task info before we call Bohemia's task functions
call vn_mf_fnc_task_update_clients;
//Tell Bohemia's Task Framework we won! (Or lost)
[_task select 0, _completionType, false] call BIS_fnc_taskSetState;

//Essentials are all done now. Now we focus on updating the gamemode state.

private _taskConfig = _taskDataStore getVariable ["taskConfig", configNull];
//Oh. Somehow we lost the task config. That's... pretty bad.
if (_taskConfig == configNull) exitWith {
	["ERROR: Lost the task config for %1.", _taskClass] call BIS_fnc_logFormat;
	false;
};

//Note: This is *changed* from the original implementation.
//Specifically, we now only award zone progress if the task was completed successfully.

if (_completionType isEqualTo "SUCCEEDED") then
{
	//Firstly - we reward rankpoints to all players in the involved groups. Huzzah,  rank points for all!
	if !(_rankPointsReward isEqualType 0) then {
		_rankPointsReward = getNumber(_taskConfig >> "rankpoints");
	};

	if !(_rankPointsReward isEqualTo 0) then
	{
		private _taskGroups = _taskDataStore getVariable ["taskGroups", []] apply {missionNamespace getVariable [_x, []]};
		{
			private _grp = _x;
			if !(_grp isEqualTo []) then
			{
				[_grp,"rank",_rankPointsReward] call vn_mf_fnc_change_player_stat;
			};
		} forEach _taskGroups;
	};

	// Force a save to profileNamespace (force save to write to disk, basically)
	["SAVE"] call para_s_fnc_profile_db;
};

//Finally, confident everything else is done, we can call the onComplete handler for the task.
[_completionType, _taskDataStore] call compile getText ((_taskDataStore getVariable "taskConfig") >> "onCompletion");
[_taskDataStore getVariable "taskId", _completionType] remoteExecCall ["vn_mf_fnc_task_client_on_task_completed", 0];
["taskCompleted", _taskDataStore] call para_g_fnc_event_dispatch;

//TODO Delete the task data store in here.
