/*
    File: eh_SeatSwitchedMan.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Fires on the 'SeatSwitchedMan' event on the client
    
    Parameter(s):
		_unit1 - Unit switching seat [Object]
		_unit2 - Unit with which unit1 is switching seat [Object]
		_vehicle - Vehicle where switching seats is taking place [Object]
    
    Returns: nothing
    
    Example(s): none
*/

params ["_unit1", "_unit2", "_vehicle"];

private _role = assignedVehicleRole _unit1 select 0;

if !([_unit1, _role, _vehicle] call vn_mf_fnc_player_can_enter_vehicle) then {
	//Try to move them to safety - we don't want people falling out of helicopters if we can avoid it!
	moveOut _unit1;
	if !(_unit1 moveInCargo _vehicle) then {
		if !(_unit1 moveInGunner _vehicle) then {
			if !(_unit1 moveInCommander _vehicle) then {
				moveOut _vehicle;
				//Maybe we should teleport them to the ground here? Or give them a parachute?
			};
		};
	};
	["VehicleLockedToTeam"] remoteExec ["para_c_fnc_show_notification", _unit1];
};
