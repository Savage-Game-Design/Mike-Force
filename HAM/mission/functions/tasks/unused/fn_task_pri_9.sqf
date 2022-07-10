/*
	File: fn_task_pri_9.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Primary task to destroy the VC HQ.
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
 * 	  pos - Position to spawn the HQ at
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _spawnPos = _taskDataStore getVariable ["pos", getMarkerPos (_taskDataStore getVariable "taskMarker")];

	private _hqBuilding = ['Land_vn_b_trench_firing_05', _spawnPos] call para_g_fnc_create_vehicle;

	_taskDataStore setVariable ["spawnPos", _spawnPos];
	_taskDataStore setVariable ["hqBuilding", _hqBuilding];

	[[["destroy_hq", _spawnPos]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["destroy_hq", {
	params ["_taskDataStore"];

	private _targetsAlive = alive (_taskDataStore getVariable "hqBuilding");

	if (!_targetsAlive) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	[_taskDataStore getVariable ["hqBuilding", objNull]] call para_s_fnc_cleanup_add_items;
}];
