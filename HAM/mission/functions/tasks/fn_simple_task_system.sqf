/*
	File: fn_simple_task_system.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Task script for the 'simple task system'.

	Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

	Returns: nothing

	Example(s):
		Not directly called.
*/

//Check conditions
//Fire activation while valid
//Handle timeout
//Handle delay
//File failed on fail
//Propagate to next task

params ["_taskDataStore"];

//If we've finished, cleanup any resources in use and do nothing else, as this will be the last call to the script.
if (_taskDataStore getVariable ["taskCompleted", false]) exitWith {
	//Cleanup all our subtask namespaces.
	private _runningSubtasks = _taskDataStore getVariable ["stsRunningSubtasks", []];
	{
		_x call para_g_fnc_delete_namespace;
	} forEach _runningSubtasks;
};


//Deliberately writing this to error if there isn't a taskConfig.
private _taskClass = _taskDataStore getVariable "taskClass";
private _taskConfig = _taskDataStore getVariable "taskConfig";
private _taskParameters = _taskConfig >> "parameters";

if !(isClass _taskParameters) exitWith {
	"Error: Simple task system given task with no parameters." call BIS_fnc_log;
	false
};

//Loads a subtask from the config
private _fnc_createSimpleSubtask = {
	params ["_subtaskType"];

	private _subtaskConfig = _taskConfig >> _subtaskType;

	if !(isClass _subtaskConfig) exitWith {
		["Error: Simple Task System trying to create subtask with no config (%1 - %2)", _taskClass, _subtaskType] call BIS_fnc_logFormat;
		locationNull
	};

	private _subtaskParameters = _subtaskConfig >> "parameters";

	private _subtask = false call para_g_fnc_create_namespace;
	_subtask setVariable ["subtaskType", _subtaskType];
	_subtask setVariable ["subtaskInit", compile getText (_subtaskParameters >> "init")];
	_subtask setVariable ["subtaskCanRun", compile getText (_subtaskParameters >> "canrun")];
	_subtask setVariable ["subtaskRunAtRegularIntervals", compile getText (_subtaskParameters >> "runatregularintervals")];
	_subtask setVariable ["subtaskFailureCondition", compile getText (_subtaskParameters >> "failurecondition")];
	_subtask setVariable ["subtaskOnFailure", compile getText (_subtaskParameters >> "onfailure")];
	_subtask setVariable ["subtaskOnSuccess", compile getText (_subtaskParameters >> "onsuccess")];
	_subtask setVariable ["subtaskNextSubtasks", getArray (_subtaskParameters >> "nextsubtasks")];
	_subtask setVariable ["subtaskTimeout", getNumber (_subtaskParameters >> "timeout")];

	private _subtaskPos = getArray (_subtaskParameters >> "pos");
	if !(_subtaskPos isEqualTo []) then {
		_subtaskPos = _subtaskPos call para_g_fnc_parse_pos_config;
	};

	//If there's no correctly configured position, default it to the center of the zone.
	if (isNil "_subtaskPos" || {_subtaskPos isEqualTo []}) then {
		_subtaskPos = getMarkerPos (_taskDataStore getVariable "taskMarker");
	};
	_subtask setVariable ["subtaskPos", _subtaskPos];

	_subtask
};

private _fnc_startSubtask = {
	params ["_subtask"];
	//Run subtask init
	[_taskDataStore, _subtask] call (_subtask getVariable "subtaskInit");
	//Set the start time
	_subtask setVariable ["subtaskStartTime", diag_tickTime];
	//Create the subtask in the main task system.
	private _id = [_taskDataStore, _subtask getVariable "subtaskType", _subtask getVariable "subtaskPos"] call vn_mf_fnc_task_subtask_create;
	_subtask setVariable ["subtaskId", _id];
	_subtask
};

private _isRunning = _taskDataStore getVariable ["stsRunning", false];

//If the simple task system isn't running, we need to initialize it.
if (!_isRunning) then {
	private _initialSubtasksIds = getArray (_taskParameters >> "initialSubtasks");

	//Create the subtask namespaces
	private _runningSubtasks = _initialSubtasksIds apply {_x call _fnc_createSimpleSubtask};
	//Save them to the data store for use in the next run.
	_taskDataStore setVariable ["stsRunningSubtasks", _runningSubtasks];

	//Start all of the initial subtasks
	{
		_x call _fnc_startSubtask;
	} forEach _runningSubtasks;

	//Save that we're running to the data store.
	_isRunning = true;
	_taskDataStore setVariable ["stsRunning", _isRunning];
};

//We're running, so run all of our checks for this call from the scheduler.
if (_isRunning) then {
	private _runningSubtasks = _taskDataStore getVariable ["stsRunningSubtasks", []];
	private _finishedSubtasks = [];
	{
		private _subtask = _x;
		private _hasSucceeded = false;
		private _hasFailed = false;
		private _timeout = _subtask getVariable "subtaskTimeout";
		private _arguments = [_taskDataStore, _subtask];

		if (_timeout != 0 && (diag_tickTime - (_subtask getVariable "subtaskStartTime") > _timeout)) then {
			_hasFailed = true;
		};

		if (_arguments call (_subtask getVariable "subtaskFailureCondition")) then {
			_hasFailed = true;
		};

		if (!_hasFailed && _arguments call (_subtask getVariable "subtaskCanRun")) then {
			_arguments call (_subtask getVariable "subtaskRunAtRegularIntervals");
		};

		if (_hasFailed) then {
			_arguments call (_subtask getVariable "subtaskOnFailure");
			[_taskDataStore, _subtask getVariable "subtaskId", "FAILED"] call vn_mf_fnc_task_subtask_complete;
			//Add an entry to finished subtasks, with 'false' for the success parameter.
			_finishedSubtasks pushback _subtask;
		};

		if (!_hasFailed && _hasSucceeded) then {
			_arguments call (_subtask getVariable "subtaskOnSuccess");
			[_taskDataStore, _subtask getVariable "subtaskId", "SUCCEEDED"] call vn_mf_fnc_task_subtask_complete;
			//Add an entry to finished subtasks, with 'false' for the success parameter.
			_finishedSubtasks pushback _subtask;

			//Create next subtask
			{
				_runningSubtasks pushback ((_x call _fnc_createSimpleSubtask) call _fnc_startSubtask);
			} forEach (_subtask getVariable "subtaskNextSubtasks")
		};
	} forEach _runningSubtasks;

	_runningSubtasks = _runningSubtasks - _finishedSubtasks;
	_taskDataStore setVariable ["stsRunningSubtasks", _runningSubtasks];

	//Clean up the namespaces of finished subtasks.
	{
		_x call para_g_fnc_delete_namespace;
	} forEach _finishedSubtasks;

	//If there's no running subtasks, and we aren't marked as completed, there's no hope a subtask will do it.
	//So manually mark the task as CANCELED
	//Should make it obvious if a task isn't completing correctly
	if (_runningSubtasks isEqualTo [] && !(_taskDataStore getVariable ["taskCompleted", false])) then {
		["WARNING: Simple Task System: Task %1 has run out of subtasks, but hasn't completed.", _taskClass] call BIS_fnc_logFormat;
		[_taskDataStore, "CANCELED"] call vn_mf_fnc_task_complete;
	};
};
