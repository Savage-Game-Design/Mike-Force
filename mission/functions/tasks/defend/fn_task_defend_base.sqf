/*
	File: fn_task_defend_base.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Task to defend an base against an enemy attack.
		Uses the state machine task system.

	Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

	Returns: nothing

	Example(s):
		Not directly called.
*/

/* 
	Requires Task Variables:
		- originZone - Id of zone where attack originates
*/

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	//Required parameters
	private _targetBase = _taskDataStore getVariable "targetBase";
	private _prepTime = _taskDataStore getVariable "prepTime";

	_taskDataStore setVariable ["startTime", serverTime];
	private _attackTime = serverTime + _prepTime;
	_taskDataStore setVariable ["attackTime", _attackTime];

	private _attackPos = getPos _targetBase;
	//Set Z position to 0, to make sure attack is to a point on ground level.
	_attackPos set [2, 0];
	_taskDataStore setVariable ["attackPos", _attackPos];

	private _baseRadius = _targetBase getVariable "para_g_base_radius";
	_taskDataStore setVariable ["attackAreaSize", [_baseRadius, _baseRadius]];

	if (_prepTime > 0) then 
	{
		["BaseAttackPreparing", ["", (_prepTime / 60) toFixed 0]] remoteExec ["para_c_fnc_show_notification", 0];
		["FOB Attack In", _attackTime, true] call vn_mf_fnc_timerOverlay_setGlobalTimer;
	};

	[[
		["prepare_base", _attackPos]
	]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["prepare_base", {
	params ["_taskDataStore"];

	if (_taskDataStore getVariable "attackTime" > serverTime) exitWith {};

	["BaseAttackImminent", []] remoteExec ["para_c_fnc_show_notification", 0];
	[] call vn_mf_fnc_timerOverlay_removeGlobalTimer;

	//Default to X waves.
	private _baseMultiplier = 4;
	//Add a wave for each camp in our origin zone.
	private _infantryMultiplier = _baseMultiplier;

	private _attackObjective = [
		_taskDataStore getVariable "attackPos",
		_taskDataStore getVariable ["attackDifficulty", 2], 
		_infantryMultiplier 
	] call para_s_fnc_ai_obj_request_attack;

	_taskDataStore setVariable ["attackObjective", _attackObjective];

	["SUCCEEDED", [["defend_base", _taskDataStore getVariable "attackPos"]]] call _fnc_finishSubtask;
}];

_taskDataStore setVariable ["defend_base", {
	params ["_taskDataStore"];

	private _attackPos = _taskDataStore getVariable "attackPos";
	private _areaSize = _taskDataStore getVariable "attackAreaSize";
	private _areaDescriptor = [_attackPos, _areaSize select 0, _areaSize select 1, 0, false];

	//Side check - downed players don't count. Nor do players in aircraft. Ground vehicles are fair game.
	private _alivePlayersInArea = 
		allPlayers inAreaArray _areaDescriptor
		select {alive _x && side _x == west && !(vehicle _x isKindOf "Air") && !(_x getVariable ["vn_revive_incapacitated", false])};

	private _aliveEnemyInArea = 
		allUnits inAreaArray _areaDescriptor 
		select {alive _x && side _x == east};

	private _enemyOwnAreaStartTime = _taskDataStore getVariable "enemyOwnAreaStartTime";
	//Enemy hold the area if no living players, and there's at least 1 guy in the area.
	private _enemyHoldArea = count _alivePlayersInArea == 0 && count _aliveEnemyInArea > 0;

	if (_enemyHoldArea && isNil "_enemyOwnAreaStartTime") then {
		_enemyOwnAreaStartTime = serverTime;
		_taskDataStore setVariable ["enemyOwnAreaStartTime", _enemyOwnAreaStartTime];
	};

	//Enemy hold the zone for X seconds, we've failed
	if (_enemyHoldArea && {serverTime - _enemyOwnAreaStartTime > (_taskDataStore getVariable ["failureTime", 30])}) then {
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;
	};

	private _startTime = _taskDataStore getVariable "startTime";

	//Area has been held long enough, or they've killed enough attackers for the AI objective to complete.
	if (serverTime - _startTime > (_taskDataStore getVariable ["holdDuration", 1200]) 
	    || isNull (_taskDataStore getVariable "attackObjective")
	) then {
		_taskDataStore setVariable ["areaDefended", true];
		["SUCCEEDED"] call _fnc_finishSubtask;
	};

}];

_taskDataStore setVariable ["AFTER_STATES_RUN", {
	params ["_taskDataStore"];

	if (   _taskDataStore getVariable ["areaDefended", false] 
	) then {
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	params ["_taskDataStore"];
	[_taskDataStore getVariable "attackObjective"] call para_s_fnc_ai_obj_finish_objective;
}];
