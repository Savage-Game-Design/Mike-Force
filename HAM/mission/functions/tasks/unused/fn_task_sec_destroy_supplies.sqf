/*
    File: fn_task_sec_destroy_supplies.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Destroy supply crates task. Uses the state machine task system.
		Requires the players destroy X supply crates. Destroying a crate escalates the attacks on the players.
    
    Parameter(s):
        _dataStore - Data store to write each state to.
    
    Returns:
        None
    
    Example(s):
		["task_class", "", [["pos", [0,0,0]]]] calll vn_mf_fnc_task_create
*/

//Don't bother with a variable, as the number needs hardcoding in the config too.
//But this at least eliminates some magic constants.
#define CRATE_QUANTITY 3

params ["_dataStore"];

_dataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _spawnPos = _taskDataStore getVariable ["pos", []];
	//Put the zone check inside here, to allow usage without a zone assigned.
	if (_spawnPos isEqualTo []) then {
		private _zonePos = getMarkerPos (_taskDataStore getVariable "taskMarker");
		_spawnPos = _zonePos getPos [500 + random 200, random 360];
	};

	private _cratePositions = [];
	for "_i" from 1 to CRATE_QUANTITY do {
		private _cratePos = _spawnPos getPos [50 + random 50, random 360];
		//No water spawns, please - it makes the mission impossible to finish.
		if !(surfaceIsWater _cratePos) then {
			_cratePositions pushBack _cratePos;
		};
	};

	private _crates = _cratePositions apply {[pavn_ammo_crate, _x] call para_g_fnc_create_vehicle};
	//Make them easier to destroy
	{_x setDamage 0.8} forEach _crates;

	private _groups = _taskDataStore getVariable "taskGroups" apply {missionNamespace getVariable _x};
	private _unitScaling = [_groups, {_this call para_g_fnc_count_alive_units_in_groups}];
	//Low AI count, as we'll be launching attacks at the players, and spawning this squad X times over.

	private _objectives = _cratePositions apply {[[_unitScaling, 0.2], _x] call para_s_fnc_ai_obj_request_defend};

	_taskDataStore setVariable ["areaCenter", _spawnPos];
	_taskDataStore setVariable ["crates", _crates];
	_taskDataStore setVariable ["aiObjectives", _objectives];

	//Add inaccuracy to the marker, to force them to search.
	private _markerPos = [[[_spawnPos, 100]]] call BIS_fnc_randomPos;

	//Calculate which subtasks we need. Since some crates may not spawn, we need to do this dynamically.
	private _subtasks = [];
	for "_i" from 0 to (count _cratePositions - 1) do {
		_subtasks pushBack [format ["destroy_crate_%1", _i], _markerPos];
	};
	
	[_subtasks] call _fnc_initialSubtasks;
}];

_dataStore setVariable ["destroyCrateSubtask", {
	params ["_taskDataStore", "_crate"];

	if !(alive _crate) exitWith {
		private _areaCenter = _taskDataStore getVariable "areaCenter";

		//Increase count of destroyed crates.
		private _destroyedCratesCount = _taskDataStore getVariable ["destroyedCratesCount", 0];
		_taskDataStore setVariable ["destroyedCratesCount", _destroyedCratesCount + 1];
		//Count players in area
		private _playersInArea = playableUnits inAreaArray [_areaCenter, 150, 150, 0];
		//ATTACK! THEY DESTROYED OUR CRATE!
		private _attackObjective = [[count _playersInArea, 1], 2, _areaCenter] call para_s_fnc_ai_obj_request_attack;
		//We allocated an objective, need to add it to the list to make sure it's cleaned up
		_taskDataStore getVariable "aiObjectives" pushBack _attackObjective;

		["SUCCEEDED"] call _fnc_finishSubtask;

		if (_destroyedCratesCount + 1 >= count (_taskDataStore getVariable "crates")) then {
			["SUCCEEDED"] call _fnc_finishTask;
		};
	};
}];

_dataStore setVariable ["destroy_crate_0", {
	params ["_taskDataStore"];

	private _fnc_destroyCrateSubtask = _taskDataStore getVariable "destroyCrateSubtask";
	[_taskDataStore, _taskDataStore getVariable "crates" select 0] call _fnc_destroyCrateSubtask;
}];

_dataStore setVariable ["destroy_crate_1", {
	params ["_taskDataStore"];

	private _fnc_destroyCrateSubtask = _taskDataStore getVariable "destroyCrateSubtask";
	[_taskDataStore, _taskDataStore getVariable "crates" select 1] call _fnc_destroyCrateSubtask;
}];

_dataStore setVariable ["destroy_crate_2", {
	params ["_taskDataStore"];

	private _fnc_destroyCrateSubtask = _taskDataStore getVariable "destroyCrateSubtask";
	[_taskDataStore, _taskDataStore getVariable "crates" select 2] call _fnc_destroyCrateSubtask;
}];

_dataStore setVariable ["FINISH", {
	params ["_taskDataStore"];

	[_taskDataStore getVariable ["crates", []]] call para_s_fnc_cleanup_add_items;
	{
		[_x] call para_s_fnc_ai_obj_finish_objective;
	} forEach (_taskDataStore getVariable "aiObjectives");
}];
