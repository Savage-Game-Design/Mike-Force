/*
	File: fn_task_pri_capture.sqf
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

	private _zone = _taskDataStore getVariable "taskMarker";
	private _zonePosition = getMarkerPos _zone;

	//TODO - Add event handler to SiteDestroyed
	private _hqs = (missionNamespace getVariable ["sites_hq", []]) inAreaArray _zone;
	private _hqPosition = if (count _hqs > 0) then {getPos (_hqs # 0)} else {_zonePosition};

	private _defendObj = [_hqPosition, 3, 2] call para_s_fnc_ai_obj_request_defend;

	_taskDataStore setVariable ["hqDefendObjective", _defendObj];
	_taskDataStore setVariable ["aiObjectives", [_defendObj]];

	[[["hold_hq", _hqPosition], ["destroy_sites", _zonePosition], ["destroy_enemy_supplies", _hqPosition]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["hold_hq", {
	params ["_taskDataStore"];

	private _aiRemaining = _taskDataStore getVariable "hqDefendObjective" getVariable ["reinforcements_remaining", 0];

	if (_aiRemaining < 0.8) exitWith
	{
		_taskDataStore setVariable ["hq_held", true];
		["SUCCEEDED"] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["destroy_sites", {
	params ["_taskDataStore"];

	private _zone = (_taskDataStore getVariable "taskMarker");
	private _rawSizes = markerSize (_taskDataStore getVariable "taskMarker");
	private _sizes = _rawSizes apply {abs _x};
	private _sizeMax = selectMax _sizes;

	private _numberOfSites = count (missionNamespace getVariable ["sites",[]] inAreaArray [markerPos _zone, _sizeMax, _sizeMax]);

	if (_numberOfSites == 0) exitWith
	{
		_taskDataStore setVariable ["sites_destroyed", true];
		["SUCCEEDED"] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["destroy_enemy_supplies", {
	params ["_taskDataStore"];

	private _zone = (_taskDataStore getVariable "taskMarker");
	private _hqs = (missionNamespace getVariable ["sites_hq", []]) inAreaArray _zone;

	if (_hqs select {!isNull _x} isEqualTo []) then {
		_taskDataStore setVariable ["suppliesDestroyed", true];
		["SUCCEEDED"] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["AFTER_STATES_RUN", {
	params ["_taskDataStore"];

	if (
		_taskDataStore getVariable ["hq_held", false]
		&& _taskDataStore getVariable ["suppliesDestroyed", false]
		&& _taskDataStore getVariable ["sites_destroyed", false]
	) then {
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	_taskDataStore getVariable "aiObjectives" apply {[_x] call para_s_fnc_ai_obj_finish_objective};
}];
