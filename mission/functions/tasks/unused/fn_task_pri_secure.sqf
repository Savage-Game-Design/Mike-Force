/*
	File: fn_task_pri_secure.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Primary task to secure a zone that's been cleared of enemy forces.
		This task does not complete itself. It must be completed by other code.
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
 * Runtime Parameters:
 *    None
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _zone = _taskDataStore getVariable "taskMarker";
	private _zonePosition = getMarkerPos _zone;

	private _campQuantity = 3;

	private _campTasks = [];
	for "_i" from 1 to _campQuantity do {

		private _task = ["secondary_mf3", _zone, [
			["defenseScaling", [{count allPlayers}, 1]],
			["attackScaling", [{count allPlayers}, 0.25]]
		]] call vn_mf_fnc_task_create;

		_campTasks pushBack (_task select 1);
	};

	private _buildTasks = [
		["secondary_build", _zone, [["buildable", "Land_vn_guardhouse_01"]]] call vn_mf_fnc_task_create select 1,
		["secondary_build", _zone, [["buildable", "Land_vn_tent_mash_01"]]] call vn_mf_fnc_task_create select 1,
		["secondary_build", _zone, [["buildable", "vn_b_ammobox_supply_07"]]] call vn_mf_fnc_task_create select 1,
		["secondary_build", _zone, [["buildable", "vn_b_ammobox_supply_08"]]] call vn_mf_fnc_task_create select 1,
		["secondary_build", _zone, [["buildable", "vn_b_ammobox_supply_09"]]] call vn_mf_fnc_task_create select 1
	];

	_taskDataStore setVariable ["campTasks", _campTasks];
	//Do this, so we have a stable interface for other code to use.
	_taskDataStore setVariable ["totalCamps", count _campTasks];
	_taskDataStore setVariable ["buildTasks", _buildTasks];

	[[
		["destroy_camps", _zonePosition],
		["build_fob", _zonePosition]
	]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["destroy_camps", {
	params ["_taskDataStore"];

	private _campTasks = _taskDataStore getVariable "campTasks";
	private _campsCompleted = {_x call vn_mf_fnc_task_is_completed} count _campTasks;
	_taskDataStore setVariable ["campsCompleted", _campsCompleted];
	//If all camp tasks are finished...
	if (count _campTasks == _campsCompleted) then {
		_taskDataStore setVariable ["areCampTasksCompleted", true];
		["SUCCEEDED"] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["build_fob", {
	params ["_taskDataStore"];

	private _buildTasks = _taskDataStore getVariable "buildTasks";
	private _buildTasksCompleted = {_x call vn_mf_fnc_task_is_completed} count _buildTasks;
	if (count _buildTasks == _buildTasksCompleted) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["AFTER_STATES_RUN", {
	params ["_taskDataStore"];

	private _completed =
		_taskDataStore getVariable ["areCampTasksCompleted", false];

	_taskDataStore setVariable ["allSubtasksCompleted", _completed];
}];

_taskDataStore setVariable ["FINISH", {
	private _tasks = (_taskDataStore getVariable "campTasks") + (_taskDataStore getVariable "buildTasks");
	{
		if !(_x call vn_mf_fnc_task_is_completed) then {
			[_x, "FAILED"] call vn_mf_fnc_task_complete;
		};
	} forEach _tasks;
}];
