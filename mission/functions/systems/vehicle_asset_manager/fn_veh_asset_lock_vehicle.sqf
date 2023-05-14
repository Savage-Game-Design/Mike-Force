/*
    File: fn_veh_asset_lock_vehicle.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Locks a vehicle asset

    Parameter(s):
        _vehicle - Vehicle to lock [Object]

    Returns:
        None

    Example(s):
        [cursorObject] call vn_mf_fnc_veh_asset_lock_vehicle
*/

params ["_vehicle"];

//Prevent locking if a player is within 10 (?) metres
if (allPlayers inAreaArray [getPos _vehicle, 10, 10] isNotEqualTo [] || _vehicle getVariable ["vn_mf_g_veh_asset_locked", false]) exitWith {};

[_vehicle, true] remoteExec ["lockInventory", 0];
[_vehicle, "LOCKED"] remoteExec ["setVehicleLock", _vehicle];
_vehicle enableSimulationGlobal false;
// Fix for simulation disabled objects being deadly when walked into.
[_vehicle, [0,0,0]] remoteExec ["setVelocity", _vehicle];
_vehicle setVelocity [0,0,0];
_vehicle setVariable ["vn_mf_g_veh_asset_locked", true, true];
_vehicle setVariable ["vn_mf_g_veh_asset_lock_last_toggled", serverTime];
