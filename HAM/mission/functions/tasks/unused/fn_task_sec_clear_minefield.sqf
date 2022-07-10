/*
    File: fn_task_sec_clear_minefield.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Secondary task to clear an area of mines and traps
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
 *    pos - Position to spawn the minefield at
 *    mineQuantity - Number of mines to spawn
 *    mineRadius - Radius in which to distribute the mines around the pos
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _taskConfig = _taskDataStore getVariable "taskConfig";

	private _zonePos = getMarkerPos (_taskDataStore getVariable "taskMarker");

	private _minefieldCenter = _taskDataStore getVariable ["pos", _zonePos getPos [300 + random 200, random 360]];
	private _mineQuantity = _taskDataStore getVariable ["mineQuantity", 10];
	private _mineRadius = _taskDataStore getVariable ["mineQuantity", 10];

	private _mines = [];

	//Spawn in the mines.
	for "_i" from 1 to _mineQuantity do {
		private _minePosition = _minefieldCenter getPos [random _mineRadius, random 360];

		if !(_minePosition isFlatEmpty [-1, -1, -1, 1, 0, false, objNull] isEqualTo []) then {
			private _mineOptions = selectRandom [jungleTraps, enemyAPMines, enemyATMines];
			private _mineType = selectRandom _mineOptions;

			_mines pushBack ([_mineType, _minePosition, [], 0] call para_g_fnc_create_mine);
		};
	};

	//Spawn in sniper units that'll try to close on the minefield.
	private _groups = [];
	private _units = [];
	private _relevantGroups = _taskDataStore getVariable "taskGroups" apply {missionNamespace getVariable [_x, []]};
	private _relevantPlayerCount = (_relevantGroups call para_g_fnc_count_units_in_groups) max 1;
	private _unitCount = if (vn_mf_param_ai_quantity == 0) then { 1 } else { _relevantPlayerCount * 3 };

	for "_i" from 1 to _unitCount do {
		private _spawnPosition = _minefieldCenter getPos [random 300+200, random 360];
		if (!surfaceIsWater _spawnPosition) then {
			private _group = [east] call para_g_fnc_create_group;
			_groups pushBack _group;
			_units pushBack ([_group, selectRandom units_vc_marksman, _spawnPosition, [], 10, "NONE"] call para_g_fnc_create_unit);

			private _destination = _spawnPosition getPos [((_spawnPosition distance2D _minefieldCenter) - 100), _spawnPosition getDir _minefieldCenter];
			private _waypoint = _group addWaypoint [AGLtoASL _destination, -1];
			_waypoint setWaypointType "SAD";
		};
	};

	_taskDataStore setVariable ["minefieldCenter", _minefieldCenter];
	_taskDataStore setVariable ["mines", _mines];
	_taskDataStore setVariable ["units", _units];
	_taskDataStore setVariable ["groups", _groups];

	private _subtaskPos = _minefieldCenter getPos [random 50, random 360];
	[[["find_minefield", _subtaskPos]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["find_minefield", {
	params ["_taskDataStore"];

	private _minefieldCenter = _taskDataStore getVariable "minefieldCenter";

	private _playerCloseToMinefield = [_minefieldCenter, 50] call vn_mf_fnc_player_within_radius;

	if (!_playerCloseToMinefield) exitWith {};

	["SUCCEEDED", [["disarm_minefield", _minefieldCenter]]] call _fnc_finishSubtask;
}];

_taskDataStore setVariable ["disarm_minefield", {
	params ["_taskDataStore"];

	private _mines = _taskDataStore getVariable "mines";

	if (_mines findIf {mineActive _x} > -1) exitWith {};
	
	["SUCCEEDED"] call _fnc_finishSubtask;
	["SUCCEEDED"] call _fnc_finishTask;
}];

_taskDataStore setVariable ["FINISH", {
	params ["_taskDataStore"];

	[_taskDataStore getVariable ["units", []]] call para_s_fnc_cleanup_add_items;
}];