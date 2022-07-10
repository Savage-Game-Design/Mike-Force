/*
    File: fn_task_pri_1.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Primary task - Build checkpoints.
		Uses the state machine task system.

    Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

    Returns: nothing

    Example(s):
        Not directly called.
*/

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _zonePosition = getMarkerPos (_taskDataStore getVariable "taskMarker");

	[[["setup_checkpoints", _zonePosition]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["setup_checkpoints", {
	params ["_taskDataStore"];

	private _zone = (_taskDataStore getVariable "taskMarker");
	
	if !((allUnits inAreaArray _zone) select {alive _x && side _x == west} isEqualTo []) then {
		private _defaultPosition = getMarkerPos (_taskDataStore getVariable "taskMarker");
		private _checkpointPosition = _taskDataStore getVariable ["pos", _defaultPosition];

		_taskDataStore setVariable ["checkpointPos", _checkpointPosition];
		["SUCCEEDED", [["build_checkpoint", _checkpointPosition]]] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["build_checkpoint", {
	params ["_taskDataStore"];

	private _checkpointPos = _taskDataStore getVariable "checkpointPos";
	if !((para_buildings_checkpoints inAreaArray [_checkpointPos, 50, 50, 0, false]) select {alive _x} isEqualTo []) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
}];
