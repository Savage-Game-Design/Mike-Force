/*
    File: fn_task_sup_transport.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Support task to insert the given group into a location.
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
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _taskConfig = _taskDataStore getVariable "taskConfig";
	private _taskParameters = _taskConfig >> "parameters";


	//The position of the support request is always a pickup location.
	_taskDataStore setVariable ["startPos", _taskDataStore getVariable "supportRequestPos"];
	//Create a smoke shell to mark the location
	"SmokeShellPurple" createVehicle (_taskDataStore getVariable "supportRequestPos");

	//Leaving support for this in, even if it's not used by the main transport support request
	private _destPosConfig = (getArray (_taskParameters >> "destinationPos"));

	if !(_destPosConfig isEqualTo []) then {
		_taskDataStore setVariable ["destinationPos", (_destPosConfig) call para_g_fnc_parse_pos_config];
	};

	_taskDataStore setVariable ["playersToTransport", [_taskDataStore getVariable "supportRequestPlayer"]];

	[[["mount", _taskDataStore getVariable "startPos"]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["mount", {
	params ["_taskDataStore"];

	private _playersToTransport = (_taskDataStore getVariable "playersToTransport") select {alive _x};
	private _playerOne = _playersToTransport select 0;

	//if the first player isn't in a vehicle, we're clearly not all aboard.
	if (vehicle _playerOne isEqualTo _playerOne) exitWith {};
	//Check the driver of the vehicle is from the group fulfilling the task request

	private _driver = driver vehicle _playerOne;
	private _playerOneTeam = _driver getVariable ["vn_mf_db_player_group", "FAILED"];
	if !(_playerOneTeam in (_taskDataStore getVariable "taskGroups")) exitWith {};
	//Don't allow players to issue transport requests to themself
	if (driver vehicle _playerOne == _playerOne) exitWith {};
	//Check all players are aboard
	if (_playersToTransport findIf {vehicle _x != vehicle _playerOne} > -1) exitWith {};

	_taskDataStore setVariable ["driver", _driver];
	_taskDataStore setVariable ["origin", getPos _driver];

	["Support_Transport_AllOnboard"] remoteExec ["para_c_fnc_show_notification", _driver];

	private _nextSubtask = if (_taskDataStore getVariable ["destinationPos", []] isEqualTo []) then {
		["transport"]
	} else {
		["transport", _taskDataStore getVariable "destinationPos"]
	};
	["SUCCEEDED", [_nextSubtask]] call _fnc_finishSubtask;
}];

_taskDataStore setVariable ["transport", {
	params ["_taskDataStore"];

	private _playersToTransport = (_taskDataStore getVariable "playersToTransport") select {alive _x};
	private _driver = _taskDataStore getVariable "driver";

	//if all the players are dead, we failed.
	if (_playersToTransport isEqualTo []) exitWith {
		["Support_Transport_PlayersDead"] remoteExec ["para_c_fnc_show_notification", _driver];
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;
	};

	private _allPlayersDisembarked = _playersToTransport findIf {vehicle _x != _x} == -1;

	private _destination = _taskDataStore getVariable ["destinationPos", []];

	if (_allPlayersDisembarked) then {
		//Calculate the RP Reward based on distance
		private _RPRewardPerKM = getNumber (missionConfigFile >> "gamemode" >> "tasks" >> "support_transport" >> "parameters" >> "RankPointsPerKM");
		private _RPReward = ceil (((getPos _driver distance2D (_taskDataStore getVariable "origin")) / 1000) * _RPRewardPerKM);

		if (_destination isEqualTo []) exitWith {
			if (_driver distance2D (_taskDataStore getVariable "origin") > 100) then {
				["SUCCEEDED"] call _fnc_finishSubtask;
				["SUCCEEDED", _RPReward] call _fnc_finishTask;
				//The player won't have the task assigned, so we can't guarantee they'll get a task notification
				["Support_Transport_Complete"] remoteExec ["para_c_fnc_show_notification", _driver];
			} else {
				["Support_Transport_TooClose"] remoteExec ["para_c_fnc_show_notification", _driver];
				["CANCELED", [["mount", getPos _driver]]] call _fnc_finishSubtask;
			};
		};

		if (count (_playersToTransport inAreaArray [_taskDataStore getVariable "destinationPos", 200, 200]) == count _playersToTransport) exitWith {
			["SUCCEEDED"] call _fnc_finishSubtask;
			["SUCCEEDED", _RPReward] call _fnc_finishTask;
			//The player won't have the task assigned, so we can't guarantee they'll get a task notification
			["Support_Transport_Complete"] remoteExec ["para_c_fnc_show_notification", _driver];
		};

		["Support_Transport_WrongLocation"] remoteExec ["para_c_fnc_show_notification", _driver];
		["CANCELED", [["mount", getPos _driver]]] call _fnc_finishSubtask;
	};
}];

_taskDataStore setVariable ["FINISH", {
}];