/*
    File: fn_task_sec_destroy_camp.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Destroy camp mission script for Mike Force.
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
 *    None
 * Runtime Parameters:
 *    pos - Position to spawn the camp at.
 */

params ["_dataStore"];

_dataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _spawnPos = _taskDataStore getVariable ["pos", []];
	if (_spawnPos isEqualTo []) then {
		private _zonePos = getMarkerPos (_taskDataStore getVariable "taskMarker");
		_spawnPos = _zonePos getPos [500 + random 200, random 360];
	};

	private _defenseScaling = _taskDataStore getVariable ["defenseScaling", [1, 2]];
	_taskDataStore setVariable ["defenseScaling", _defenseScaling];

	private _buildings = [_spawnPos] call vn_mf_fnc_create_camp_buildings;

	private _objectives = [];

	//30% chance to spawn an ambush instead of a camp.
	if (random 1 < 0.3) then {
		_objectives pushBack (([_spawnPos] + _defenseScaling) call para_s_fnc_ai_obj_request_ambush);
	} else {
		_objectives pushBack (([_spawnPos] + _defenseScaling) call para_s_fnc_ai_obj_request_defend);
	};

	_taskDataStore setVariable ["lastAttackSent", serverTime];
	_taskDataStore setVariable ["campPos", _spawnPos];
	_taskDataStore setVariable ["buildings", _buildings];
	_taskDataStore setVariable ["aiObjectives", _objectives];

	//Add inaccuracy to the marker, to force them to search.
	private _markerPos = _spawnPos getPos [random 40, random 360];
	
	[[["find_and_destroy", _markerPos]]] call _fnc_initialSubtasks;
}];

_dataStore setVariable ["find_and_destroy", {
	params ["_taskDataStore"];

	private _campPos = _taskDataStore getVariable "campPos";
	private _validUnits = allUnits inAreaArray [_campPos, 100, 100, 0, true] select {
		side group _x == east && alive _x && (_x distance2D _campPos) < 100 
	};
	//Max 1 prevents it ever being 0 and causing a divide by 0 error
	private _totalUnits = (_taskDataStore getVariable "defenseScaling") call para_g_fnc_ai_scale_to_player_count;

	//Few units in the area, and at least 1 player.
	if ((count _validUnits / _totalUnits) > 0.3 || {(allPlayers inAreaArray [_campPos, 100, 100] isEqualTo [])}) exitWith {};
	//Destroy the tent.
	if (_taskDataStore getVariable "buildings" findIf {isNull _x || damage _x >= 1} == -1) exitWith {};

	["SUCCEEDED"] call _fnc_finishSubtask;
	["SUCCEEDED"] call _fnc_finishTask;
}];

_dataStore setVariable ["FINISH", {
	params ["_taskDataStore"];

	[_taskDataStore getVariable ["buildings", []]] call para_s_fnc_cleanup_add_items;
	{
		[_x] call para_s_fnc_ai_obj_finish_objective;
	} forEach (_taskDataStore getVariable "aiObjectives");
}];