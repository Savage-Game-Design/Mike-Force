/*
    File: fn_veh_asset_lock_vehicle.sqf
    Author: Savage Game Design
    Public: No

    Description:
    Locks a vehicle asset

    Parameter(s):
		_id - Id of the vehicle asset [Number]

    Returns:
		None

    Example(s):
		[22] call vn_mf_fnc_veh_asset_lock_vehicle
*/

params ["_id"];

private _vehicle = [_id] call vn_mf_fnc_veh_asset_get_by_id select struct_veh_asset_info_m_vehicle;

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
