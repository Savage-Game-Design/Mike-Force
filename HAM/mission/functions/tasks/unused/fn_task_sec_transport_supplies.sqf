/*
  Author: Savage Game Design
  Description:
	Called every scheduler tick to maintain the "Ash and Trash" task.

	This is an example of a 'raw' task system task, that isn't using one the task system 'framework' scripts. This is driven directly by the task system.
  Params:
	_taskDataStore - Data store for the task that's using this script. Created by the task system.

  Task Runtime Parameters:
     crateSpawnPos - Position to spawn the crate at that needs collecting
	 crateDestPos - Place the crate needs dropping.

  Returns:
	None

  Example Usage:
	Shouldn't be called directly.
*/

params ["_taskDataStore"];

private _currentTaskState = _taskDataStore getVariable ["taskState", "INIT"];

private _crateDestination = _taskDataStore getVariable ["crateDestPos", getMarkerPos (_taskDataStore getVariable "taskMarker")];

if (_currentTaskState == "INIT") then {
	private _subtaskId = [_taskDataStore, "transport_supplies", _crateDestination] call vn_mf_fnc_task_subtask_create;
	_currentTaskState = "TRANSPORTING_SUPPLIES";
	_taskDataStore setVariable ["taskState", _currentTaskState];
	_taskDataStore setVariable ["subtaskId", _subtaskId];
};

if (_currentTaskState == "TRANSPORTING_SUPPLIES") exitWith {
	private _crateType = getText (missionConfigFile >> "gamemode" >> "supplydrops" >> "construction" >> "BuildingSuppliesCrate" >> "className"); 
	private _cratesInRange = entities _crateType inAreaArray [_crateDestination, 15, 15, 0, false];
	private _crate = selectRandom _cratesInRange;

	if (!isNil "_crate" && {isNull attachedTo _crate && isNull ropeAttachedTo _crate}) then {
		private _subtaskId = _taskDataStore getVariable "subtaskId";
		[_taskDataStore, _subtaskId, "SUCCEEDED"] call vn_mf_fnc_task_subtask_complete;
		[_taskDataStore, "SUCCEEDED"] call vn_mf_fnc_task_complete;
		deleteVehicle _crate;
	};
};
