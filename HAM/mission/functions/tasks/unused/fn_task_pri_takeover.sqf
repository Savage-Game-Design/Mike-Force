/*
	File: fn_task_pri_takeover.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Primary task to take over a zone - clearing enemy forces out of it.
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

	private _zonePosition = getMarkerPos (_taskDataStore getVariable "taskMarker");

	//Select a random HQ position for now.
	//Fairly expensive, prone to errors. Should be pre-computed for each zone.
	private _hqPosition = _zonePosition;
	for "_i" from 0 to 10 do {
		private _testPosition = _zonePosition getPos [100, random 360];
		_testPosition = (selectBestPlaces [_testPosition, 200, "-(houses + 10 * waterDepth)", 10, 1]) select 0 select 0;
		if !(_testPosition isFlatEmpty [0, -1, 0.5, 50, 0] isEqualTo []) exitWith {
			_hqPosition = _testPosition + [0];
		};
	};

	{
		_x hideObjectGlobal true;
	} forEach (nearestTerrainObjects [_hqPosition, ["TREE", "BUSH", "SMALL TREE", "ROCK", "ROCKS"], 50, false, true]);

	private _hqObjects = [_hqPosition] call vn_mf_fnc_create_hq_buildings;
	private _objectsToDestroy = _hqObjects select {_x isKindOf "land_vn_pavn_ammo"};

	_taskDataStore setVariable ["buildings", _hqObjects];
	_taskDataStore setVariable ["objectsToDestroy", _objectsToDestroy];

	//Request defense forces
	private _zoneDefendObjective = [[{allPlayers}, 1], _zonePosition] call para_s_fnc_ai_obj_request_defend;
	private _hqDefendObjective = [[{allPlayers}, 1], _hqPosition] call para_s_fnc_ai_obj_request_defend;

	_taskDataStore setVariable ["defendObjective", _zoneDefendObjective];
	_taskDataStore setVariable ["aiObjectives", [_zoneDefendObjective, _hqDefendObjective]];

	[[["defeat_hostile_forces", _zonePosition], ["destroy_hq", _zonePosition]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["defeat_hostile_forces", {
	params ["_taskDataStore"];

	private _zone = (_taskDataStore getVariable "taskMarker");

	private _playersInZone = {alive _x and side _x == west} count (allUnits inAreaArray _zone);
	private _enemyInZone = {alive _x and side _x == east} count (allUnits inAreaArray _zone);

	private _defendObjective = _taskDataStore getVariable "defendObjective";

	private _remainingDefenseUnits = (_defendObjective getVariable "assignedGroups") call para_g_fnc_count_alive_units_in_groups;
	
	if ((_playersInZone * 2) > _remainingDefenseUnits) then {
		_taskDataStore setVariable ["zoneClear", true];
		["SUCCEEDED"] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["destroy_hq", {
	params ["_taskDataStore"];

	private _objectsToDestroy = _taskDataStore getVariable "objectsToDestroy";
	if (_objectsToDestroy select {alive _x} isEqualTo []) then {
		_taskDataStore setVariable ["hqDestroyed", true];
		["SUCCEEDED"] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["AFTER_STATES_RUN", {
	params ["_taskDataStore"];

	if (_taskDataStore getVariable ["zoneClear", false] && _taskDataStore getVariable ["hqDestroyed", false]) then {
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	[_taskDataStore getVariable ["buildings", []]] call para_s_fnc_cleanup_add_items;
	{
		[_x] call para_s_fnc_ai_obj_finish_objective;
	} forEach (_taskDataStore getVariable "aiObjectives");
}];
