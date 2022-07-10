/*
	File: fn_task_pri_expand.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Primary task to defend a zone against an enemy attack, and clear out nearby entrenchments.
		Uses the state machine task system.

	Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

	Returns: nothing

	Example(s):
		Not directly called.
*/

vn_mf_primary_expand_failDelay = 30;
vn_mf_primary_expand_holdDuration = 1200;

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _zonePosition = getMarkerPos (_taskDataStore getVariable "taskMarker");

	//Required parameter
	private _totalInfantryMultiplier = _taskDataStore getVariable "totalInfantryMultiplier";

	_taskDataStore setVariable ["startTime", serverTime];

	private _attackObjective = [[{count allPlayers}, 1], _totalInfantryMultiplier, _zonePosition] call para_s_fnc_ai_obj_request_attack;
	_taskDataStore setVariable ["attackObjective", _attackObjective];

	[[
		["defend_zone", _zonePosition]
	]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["defend_zone", {
	params ["_taskDataStore"];

	private _zone = (_taskDataStore getVariable "taskMarker");

	//Side check - downed players don't count. Nor do players in aircraft. Ground vehicles are fair game.
	private _alivePlayersInZone = allPlayers inAreaArray _zone select {alive _x && side _x == west && !(vehicle _x isKindOf "Air")};
	private _aliveEnemyInZone = allUnits inAreaArray _zone select {alive _x && side _x == east};

	private _enemyOwnZoneStartTime = _taskDataStore getVariable "enemyOwnZoneStartTime";
	//Enemy hold the zone if no living players, and there's at least 1 guy in the zone.
	private _enemyHoldZone = count _alivePlayersInZone == 0 && count _aliveEnemyInZone > 0;

	if (_enemyHoldZone && isNil "_enemyOwnZoneStartTime") then {
		_enemyOwnZoneStartTime = serverTime;
		_taskDataStore setVariable ["enemyOwnZoneStartTime", _enemyOwnZoneStartTime];
	};

	//Enemy hold the zone for X seconds, we've failed
	if (_enemyHoldZone && {serverTime - _enemyOwnZoneStartTime > vn_mf_primary_expand_failDelay}) then {
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;
	};

	private _startTime = _taskDataStore getVariable "startTime";

	//Zone has been held long enough, or they've killed enough attackers for the AI objective to complete.
	if (serverTime - _startTime > vn_mf_primary_expand_holdDuration 
	    || isNull (_taskDataStore getVariable "attackObjective")
	) then {
		_taskDataStore setVariable ["zoneDefended", true];
		["SUCCEEDED"] call _fnc_finishSubtask;
	};

}];

_taskDataStore setVariable ["AFTER_STATES_RUN", {
	params ["_taskDataStore"];

	if (   _taskDataStore getVariable ["zoneDefended", false] 
	) then {
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	params ["_taskDataStore"];
	[_taskDataStore getVariable "attackObjective"] call para_s_fnc_ai_obj_finish_objective;
}];
