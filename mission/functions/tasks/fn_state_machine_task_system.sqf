/*
  Author: Savage Game Design
  Description:
	Task script for the 'state machine task system'.

	Less rigid than the 'Simple task System', but more rigid than writing a task yourself.
	Avoids the need to directly manage when subtasks are created and completed, and keep track of the current task state.

	Not a 'Finite State Machine', as it can be in several states simultaneously.

	Essentially:
		Uses 'stateMachineCode' to initialise the state machine, by adding several code blocks to a namespace/data store:
		- 'INIT' - Called once, when the state machine starts the first time.
		- '$subtask_id' - A code block for each subtask, that is run while that subtask is active
		- 'FINISH' - Called once, when the tasks completes, to clean up any resources used by the tasks, such as units/vehicles.

  Params:
	_taskDataStore - Data store for the top-level task using this script.

  Task Parameters:
    stateMachineCode - String that, when run, returns the code to initialise the state machine

	Any additional parameters needed by the state machine being run.

  Returns:
	None

  Example Usage:
	Shouldn't be called directly.
*/

params ["_taskDataStore"];

//If we've completed the task, and not yet cleaned up - we need to perform cleanup.
if (_taskDataStore getVariable ["taskCompleted", false]) exitWith {
	if !(_taskDataStore getVariable ["taskCleanedUp", false]) then {
		//Make sure these are set. They won't be if we're being completed by something else - I.e, not the task running in this script.
		//Whereas if we complete via _fnc_finishTask, they get set in there.
		//We can't *just* have this one, as it's better to know stateMachineFinished as soon as possible, so we can stop running as soon as possible.
		_taskDataStore setVariable ["stateMachineFinished", true];
		_taskDataStore setVariable ["stateMachineResult", _taskDataStore getVariable "taskResult"];

		//Perform state machine cleanup function.
		[_taskDataStore] call (_taskDataStore getVariable ["FINISH", {}]);

		_taskDataStore setVariable ["taskCleanedUp", true];
	};
};

//Do nothing if we've terminated the state machine already.
//Should be impossible to get here (at the current point in time), but leaving it in just to be safe.
if (_taskDataStore getVariable ["stateMachineFinished", false]) exitWith {
	false
};

//Deliberately writing this to error if there isn't a taskConfig.
private _taskConfig = _taskDataStore getVariable "taskConfig";
private _taskParameters = _taskConfig >> "parameters";

if (!isClass _taskParameters) exitWith {
	"Error: State machine task system given task with no parameters." call BIS_fnc_log;
	false
};


//Timeout support - create a new task end time if we don't have one.
private _taskEndTime = _taskDataStore getVariable "taskEndTime";
if (isNil "_taskEndTime") then {
	//First, check to see if we've got a parameter passed in that'll override the timeout from the config.
	private _taskTimeout = _taskDataStore getVariable "taskTimeout";
	//No override, so we'll pull the config time.
	if (isNil "_taskTimeout") then {
		_taskTimeout = getNumber (_taskParameters >> "timeout");
	};

	if (_taskTimeout <= 0) then {
		_taskEndTime = -1;
	} else {
		_taskEndTime = serverTime + _taskTimeout;
	};

	_taskDataStore setVariable ["taskEndTime", _taskEndTime];
	_taskDataStore setVariable ["taskTimeout", _taskTimeout];
};

//If we're not an infinite-running task, and we've exceeded our end time, we've failed.
if (_taskEndTime > 0 && _taskEndTime < serverTime) exitWith {
	[_taskDataStore, "FAILED"] call vn_mf_fnc_task_complete;
};


///////////////////////////////////////////////////////////////////////////
//These functions should NOT be called directly from within subtask code.//
///////////////////////////////////////////////////////////////////////////

//Ends a given subtask with the specified result, and removes it form the list of subtasks to run/
private _fnc_endSubtask = {
	params ["_subtaskId", "_result"];

	[_taskDataStore, _subtaskId, _result] call vn_mf_fnc_task_subtask_complete;

	private _currentStates = _taskDataStore getVariable "stateMachineCurrentStates";
	//Remove the current state from the list of states we're in.
	_currentStates deleteAt (_currentStates findIf {_x # 0 == _currentSubtaskId});
};

//Starts 1 or more new subtasks, creating the tasks in the task list and adding them to the state machine
private _fnc_startSubtasks = {
	params [["_newSubtasks", []]];

	private _currentStates = _taskDataStore getVariable "stateMachineCurrentStates";

	{
		_x params ["_newSubtaskType", ["_newSubtaskLocation", objNull]];
		private _newSubtaskId = [_taskDataStore, _newSubtaskType, _newSubtaskLocation] call vn_mf_fnc_task_subtask_create;
		_currentStates pushBack [_newSubtaskId, _newSubtaskType];
	} forEach _newSubtasks;
};

////////////////////////////////////////////////////////////////////
//These functions CAN be called directly from within subtask code.//
//They require these variables defined before they can be called: //
// _currentSubtaskId                                              //
// _subtasksToRun                                                 //
////////////////////////////////////////////////////////////////////

//Sets the initial subtasks to run.
//Should ONLY be called from the 'INIT' section of a state machine.
private _fnc_initialSubtasks = {
	params [["_initialSubtasks", []]];

	[_initialSubtasks] call _fnc_startSubtasks;
};

//Finishes the current subtask, and optionally starts 1 or more new subtasks.
//Grabs the ID of the current subtask from the environment. So _currentSubtaskId *must* be defined.
private _fnc_finishSubtask = {
	params ["_result", ["_nextSubtasks", []]];

	[_currentSubtaskId, _result] call _fnc_endSubtask;
	[_nextSubtasks] call _fnc_startSubtasks;
};

//Called to mark the end of the task. Sets the state machine result code, and marks the task as finished with the task system.
//Task cleanup is handled on the next (and final) call to the task script.
private _fnc_finishTask = {
	params ["_result", ["_rankPointsReward", objNull]];

	//Empty to the current states to make sure none of them continue running.
	_taskDataStore setVariable ["stateMachineFinished", true];
	_taskDataStore setVariable ["stateMachineResult", _result];
	[_taskDataStore, _result, _rankPointsReward] call vn_mf_fnc_task_complete;
};

/////////////////////////////////////////////////////////////////////
// State machine code - Initialising and running the state machine //
/////////////////////////////////////////////////////////////////////

//Initialise the state machine if it's not already initialised
if !(_taskDataStore getVariable ["stateMachineInitialised", false]) then {
	private _initCodeString = getText (_taskParameters >> "stateMachineCode");

	_taskDataStore setVariable ["stateMachineCurrentStates", []];

	//Initialise the FSM by calling the state machine code
	//This code should return the code we need to run to initialise the FSM.
	[_taskDataStore] call (call compile _initCodeString);
	[_taskDataStore] call (_taskDataStore getVariable "INIT");

	_taskDataStore setVariable ["stateMachineInitialised", true];
};

//Runs before all of the states, can add new states before this execution.
[_taskDataStore] call (_taskDataStore getVariable ["BEFORE_STATES_RUN", {}]);

//Run all of the current subtasks/states;.
//Copy the array, so it isn't modified while we iterate over it.
//The copied array CAN be modified by the functions called in the state machine code.
//This isn't a deep clone though - so don't modify any individual entries in-place.
private _subtasksToRun = +(_taskDataStore getVariable "stateMachineCurrentStates");
private _currentSubtaskPosition = 0;

//If we've got no subtasks, then something has gone wrong.
if (count _subtasksToRun isEqualTo 0) then {
	["CANCELED"] call _fnc_finishTask;
	diag_log format ["VN MikeForce: Warning, task %1 ran out of states", _taskDataStore getVariable "taskClass"];
};


//While loop allows us to push items onto 'subtasksToRun' if we want to.
while  {_currentSubtaskPosition < count _subtasksToRun} do
{
	private _currentSubtask = _subtasksToRun select _currentSubtaskPosition;
	_currentSubtask params ["_currentSubtaskId", "_currentSubtaskType"];

	//If previous code has finished the state machine, stop running states.
	if (_taskDataStore getVariable ["stateMachineFinished", false]) exitWith {};

	//run the code for the subtask
	[_taskDataStore] call (_taskDataStore getVariable [_currentSubtaskType, {}]);

	//Move to the next state in the queue that we need to run.
	_currentSubtaskPosition = _currentSubtaskPosition + 1;
};

[_taskDataStore] call (_taskDataStore getVariable ["AFTER_STATES_RUN", {}]);