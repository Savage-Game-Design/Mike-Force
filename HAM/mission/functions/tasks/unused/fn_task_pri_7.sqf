/*
	File: fn_task_pri_7.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Primary 'Village Meeting'.
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
 *    meetingPos - position for the meeting to occur at.
 *    escortStartPos - position for the escort to begin at.
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _markerPos = getMarkerPos (_taskDataStore getVariable "taskMarker");
	private _meetingPos = _taskDataStore getVariable ["meetingPos", _markerPos];
	private _escortStartPos = _taskDataStore getVariable ["escortStartPos", _markerPos getPos [100, random 360]];

	private _taskId = _taskDataStore getVariable "taskId";

	private _escortee = [_escortStartPos, format ["escortElderTalkedTo_%1", _taskId]] call vn_mf_fnc_spawn_civilian; 
	private _meetingElder = [_meetingPos, format ["meetingElderTalkedTo_%1", _taskId]] call vn_mf_fnc_spawn_civilian; 
	//Don't allow them to be injured until later, so they don't die before players even know where they are.
	_meetingElder allowDamage false;

	_taskDataStore setVariable ["meetingPos", _meetingPos];
	_taskDataStore setVariable ["escortStartPos", _escortStartPos];

	_taskDataStore setVariable ["escortElder", _escortee];
	_taskDataStore setVariable ["meetingElder", _meetingElder];

	[[["meet_elders", _escortStartPos]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["meet_elders", {
	params ["_taskDataStore"];

	private _taskId = _taskDataStore getVariable "taskId";
	private _escorteeTalkedToVar = format ["escortElderTalkedTo_%1", _taskId];
	
	private _escorteeTalkedTo = missionNamespace getVariable [_escorteeTalkedToVar, false];

	if (_escorteeTalkedTo) then {
		private _meetingPos = _taskDataStore getVariable "meetingPos";
		_taskDataStore getVariable "escortElder" setDestination [_meetingPos, "LEADER PLANNED", true];
		["SUCCEEDED", [["escort_elders", _meetingPos]]] call _fnc_finishSubtask;
	}; 
}];

_taskDataStore setVariable ["escort_elders", {
	params ["_taskDataStore"];

	private _escortee = _taskDataStore getVariable "escortElder";
	private _meetingPos = _taskDataStore getVariable "meetingPos";

	if (_escortee inArea [_meetingPos, 20, 20, 0, false] && !(allPlayers inAreaArray [_meetingPos, 20, 20, 0, false] isEqualTo [])) then {
		//Make them retreat here or something?
		["SUCCEEDED", [["defend_meeting", _meetingPos]]] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["defend_meeting", {
	params ["_taskDataStore"];

	private _defendPos = _taskDataStore getVariable "meetingPos";

	if (isNil {_taskDataStore getVariable "units"}) then {
		private _relevantGroups = _taskDataStore getVariable "taskGroups" apply {missionNamespace getVariable [_x, []]};
		private _relevantPlayerCount = (_relevantGroups call para_g_fnc_count_units_in_groups) max 1;
		private _unitCount = if (vn_mf_param_ai_quantity == 0) then { 1 } else { 1 max _relevantPlayerCount * 2 };
		private _squadCount =  ceil (_unitCount / 4);

		private _groups = [];
		private _units = [];

		private _squadComposition = [8] call vn_mf_fnc_squad_standard;

		for "_i" from 1 to _squadCount do {
			private _squad = [_squadComposition, east, _defendPos getPos [300 + random 100, random 360]] call para_g_fnc_create_squad;
			_groups pushBack (_squad # 1);
			_units append (_squad # 0);
		};

		_taskDataStore setVariable ["units", _units];
		_taskDataStore setVariable ["groups", _groups];
	};

	private _units = _taskDataStore getVariable ["units", [objNull]];
	private _groups = _taskDataStore getVariable ["groups", []];
	private _percentAlive = count (_units select {alive _x}) / count _units;

	{
		//If they've got no active waypoint, add a new SAD waypoint
		if (currentWaypoint _x >= (count waypoints _x - 1)) then {
			_x addWaypoint [_defendPos, 20] setWaypointType "SAD";
		};
	} forEach _groups;

	if (_percentAlive < 0.2) then {
		//Make them retreat here or something?
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	[_taskDataStore getVariable ["units", []]] call para_s_fnc_cleanup_add_items;
	[_taskDataStore getVariable ["escortElder", objNull]] call para_s_fnc_cleanup_add_items;
	[_taskDataStore getVariable ["meetingElder", objNull]] call para_s_fnc_cleanup_add_items;
}];