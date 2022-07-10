/*
    File: eh_GetInMan.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Fires on the 'GetInMan' event on the client
    
    Parameter(s):
		_unit - Unit the event handler is assigned to [Object]
		_role - Can be either "driver", "gunner" or "cargo" [String]
		_vehicle - Vehicle the unit entered [Object]
		_turret - Turret path [Array]
    
    Returns: nothing
    
    Example(s): none
*/

params ["_unit", "_role", "_vehicle", "_turret"];


if !([_unit, _role, _vehicle] call vn_mf_fnc_player_can_enter_vehicle) then {
	moveOut _unit;
	["VehicleLockedToTeam"] remoteExec ["para_c_fnc_show_notification", _unit];
};