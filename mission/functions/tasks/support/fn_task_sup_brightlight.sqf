/*
	File: fn_task_sup_brightlight.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Rescue the stranded aircrew and bring them back to base.
		Uses the state machine task system.

	Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

	Returns: nothing

	Example(s):
		Not directly called.
*/

/*
 * Task Parameters:
 *    posToReturnTo - Position the aircrew need to be escorted to safely.
 * Subtask Parameters:
 * 	  None
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _taskParameters = (_taskDataStore getVariable "taskConfig") >> "parameters";

	//This is a bit of a hack, since there's no good way of knowing who the bright light needs to rescue.
	private _requestingPlayer = _taskDataStore getVariable "supportRequestPlayer";
	private _strandedPlayers = playableUnits select {_x distance2D _requestingPlayer < 50 && side _x == side _requestingPlayer};

	_taskDataStore setVariable ["unitsToRescue", _strandedPlayers];
	_taskDataStore setVariable ["posToReturnTo", getArray (_taskParameters >> "posToReturnTo") call para_g_fnc_parse_pos_config];

	[[["find_aircrew", _taskDataStore getVariable "supportRequestPos"]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["find_aircrew", {
	params ["_taskDataStore"];

	private _validRescueUnits = missionNamespace getVariable "SpikeTeam";
	private _unitsToRescue = _taskDataStore getVariable "unitsToRescue";

	private _isOneDownedAircrewAlive = _unitsToRescue findIf {alive _x} > -1;

	if (!_isOneDownedAircrewAlive) exitWith {
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;
	};

	//This is a bit inefficient, loops (count units SpikeTeam) * (count UnitsToRescue) times.
	//Unlikely to cause much of an issue though, as relatively small numbers.
	private _isPlayerNearStrandedAircrew = _validRescueUnits findIf {private _rescuer = _x; _unitsToRescue findIf {_x distance2D _rescuer < 20} > -1 } > -1;

	if (!_isPlayerNearStrandedAircrew) exitWith {};

	["SUCCEEDED", [["protect_aircrew", _taskDataStore getVariable "posToReturnTo"]]] call _fnc_finishSubtask;
}];

_taskDataStore setVariable ["protect_aircrew", {
	params ["_taskDataStore"];

	private _validRescueUnits = missionNamespace getVariable "SpikeTeam";
	private _unitsToRescue = _taskDataStore getVariable "unitsToRescue";

	private _aliveAircrew = _unitsToRescue select {alive _x};

	private _isOneDownedAircrewAlive = count _aliveAircrew > 0;

	if (!_isOneDownedAircrewAlive) exitWith {
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;
	};

	private _returnPos = _taskDataStore getVariable "posToReturnTo";
	private _aircrewIsSafe = count (_aliveAircrew inAreaArray [_returnPos, 100, 100]) == count (_aliveAircrew);

	if !(_aircrewIsSafe) exitWith {};

	["SUCCEEDED"] call _fnc_finishSubtask;
	["SUCCEEDED"] call _fnc_finishTask;
}];

_taskDataStore setVariable ["FINISH", {
	params ["_taskDataStore"];
}];