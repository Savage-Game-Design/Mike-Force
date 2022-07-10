/*
    File: fn_task_sec_patrol.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Task to patrol the area. Waypoints have a chance to spawn something interesting.
    
    Parameter(s):
        _taskDataStore - Data store to write the states to

    Returns:
        None
    
    Example(s):
        [parameter] call vn_fnc_myFunction
*/


params ["_taskDataStore"];


_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _fnc_generatePatrolPositions = {
		params ["_center"];

		private _positions = [_center getPos [200 + random 100, random 360]];
		private _patrolDirection = (_center getDir (_positions select 0)) + (selectRandom [90, -90]);
		
		for "_i" from 1 to 3 do {
			_positions pushBack ((_positions select 0) getPos [70 + random 70, _patrolDirection + (-25 + random 50)]);
		};

		_positions
	};

	private _patrolPositions = _taskDataStore getVariable ["patrolPositions", []];

	if (_patrolPositions isEqualTo []) then {
		private _zoneCenter = _taskDataStore getVariable ["pos", getMarkerPos (_taskDataStore getVariable "taskMarker")];
		_patrolPositions = [_zoneCenter] call _fnc_generatePatrolPositions;
	};

	//Create little surprise for them;
	//Select any waypoint but the first.
	private _ambushIndex = 1 + floor random (count _patrolPositions - 1);
	private _ambushPos = _patrolPositions select _ambushIndex;
	private _groups = _taskDataStore getVariable "taskGroups" apply {missionNamespace getVariable _x};
	private _unitScaling = [_groups, {_this call para_g_fnc_count_alive_units_in_groups}];
	private _ambush = [[_unitScaling, 1.5], _ambushPos] call para_s_fnc_ai_obj_request_ambush;

	_taskDataStore setVariable ["patrolPositions", _patrolPositions];
	_taskDataStore setVariable ["patrolIndex", 0];
	_taskDataStore setVariable ["aiObjectives", [_ambush]];

	[[["patrol_area", _patrolPositions select 0]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["patrol_area", {
	params ["_taskDataStore"];

	private _patrolIndex = _taskDataStore getVariable "patrolIndex";
	private _patrolPositions = _taskDataStore getVariable "patrolPositions";
	private _currentPosition = _patrolPositions select _patrolIndex;

	if !((allUnits inAreaArray [_currentPosition,25,25,0,false]) select {alive _x && side _x == west} isEqualTo []) then {
		//Move to the next patrol point if there's some left.
		if (_patrolIndex + 1 < count _patrolPositions - 1) then {
			_taskDataStore setVariable ["patrolIndex", _patrolIndex + 1];
			["SUCCEEDED", [["patrol_area", _patrolPositions select (_patrolIndex + 1)]]] call _fnc_finishSubtask;
		} else {
			["SUCCEEDED"] call _fnc_finishSubtask;
			["SUCCEEDED"] call _fnc_finishTask;
		};
	};
}];

_taskDataStore setVariable ["FINISH", {
	{
		[_x] call para_s_fnc_ai_obj_finish_objective;
	} forEach (_taskDataStore getVariable "aiObjectives");
}];