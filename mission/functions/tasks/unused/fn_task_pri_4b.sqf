/*
	File: fn_task_pri_4b.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Primary 'Kill the Tax Collector'.
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
 *    pos - Position to spawn the tax collector at.
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _spawnPos = _taskDataStore getVariable ["pos", getMarkerPos (_taskDataStore getVariable "taskMarker")];

	private _relevantGroups = _taskDataStore getVariable "taskGroups" apply {missionNamespace getVariable [_x, []]};
	private _relevantPlayerCount = (_relevantGroups call para_g_fnc_count_units_in_groups) max 1;
	private _unitCount = if (vn_mf_param_ai_quantity == 0) then { 1 } else { _relevantPlayerCount * 1 };
	private _squadComposition = [_unitCount] call vn_mf_fnc_squad_standard;
	private _result = [_squadComposition, east, _spawnPos] call para_g_fnc_create_squad;

	private _taxCollector = [
		_result # 1, 
		selectRandom getArray (missionConfigFile >> "gamemode" >> "units" >> "east" >> "vc_local_officers"),
		_spawnPos,
		[],
		5,
		"NONE"
	] call para_g_fnc_create_unit;

	(_result select 0) pushBack _taxCollector;

	_taskDataStore setVariable ["units", (_result select 0)];
	_taskDataStore setVariable ["taxCollector", _taxCollector];

	[[["kill_tax_collector", _spawnPos getPos [50 + random 100, random 360]]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["kill_tax_collector", {
	params ["_taskDataStore"];

	if !(alive (_taskDataStore getVariable ["taxCollector", objNull])) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	[_taskDataStore getVariable ["units", objNull]] call para_s_fnc_cleanup_add_items;
}];