/*
	File: fn_player_can_enter_vehicle.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Check if the player can enter the vehicle (or static weapon).

	Parameter(s):
	_player - Player that wants to enter [Object]
	_role - Role in the vehicle they want to enter [String]
	_vehicle - Vehicle that the player is entering [Object]

	Returns:
		Can they enter the vehicle? [Boolean]

	Example(s): none
*/


private _fnc_player_is_authorized = {
	params ["_vehicle", "_player"];

	private _teamsVehicleIsLockedTo = _vehicle getVariable ["teamLock", []];
	private _playerGroup = _player getVariable ["vn_mf_db_player_group", "FAILED"];

	if (_teamsVehicleIsLockedTo isEqualTo [] || _playerGroup in _teamsVehicleIsLockedTo) exitWith {
		true
	};

	false
};


params ["_player", "_role", "_vehicle"];

if (_vehicle isKindOf "StaticWeapon") exitWith {
	[_vehicle, _player] call _fnc_player_is_authorized
};

private _isCopilot = (getNumber ([_vehicle, _vehicle unitTurret _player] call BIS_fnc_turretConfig >> "isCopilot") > 0);

// allows passengers into vehicles

if (_role == "driver" || _isCoPilot) exitWith {
	[_vehicle, _player] call _fnc_player_is_authorized
};

true
