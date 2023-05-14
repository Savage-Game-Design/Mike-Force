/*
    File: fn_veh_asset_unlock_vehicle.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Unlocks a locked vehicle asset
    
    Parameter(s):
        _vehicle - Vehicle to unlock [Object]
    
    Returns:
        None
    
    Example(s):
        [22] call vn_mf_fnc_veh_asset_unlock_vehicle
*/

params ["_vehicle"];

if !(_vehicle getVariable ["vn_mf_g_veh_asset_locked", false]) exitWith {};

[_vehicle, false] remoteExec ["lockInventory", 0];
[_vehicle, "UNLOCKED"] remoteExec ["setVehicleLock", _vehicle];
_vehicle enableSimulationGlobal true;
_vehicle setVariable ["vn_mf_g_veh_asset_locked", false, true];
_vehicle setVariable ["vn_mf_g_veh_asset_lock_last_toggled", serverTime];
