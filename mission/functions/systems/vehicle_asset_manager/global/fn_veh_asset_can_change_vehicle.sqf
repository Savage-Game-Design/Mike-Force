/*
    File: fn_veh_asset_can_change_vehicle.sqf
    Author: Spoffy
    Date: 2023-06-05
    Last Update: 2023-06-05
    Public: No
    
    Description:
        Checks if the vehicle associated with a spawn point can be changed.
    
    Parameter(s):
	   	_spawnPoint - Spawn point to check [HashMap]
    
    Returns:
		True if the vehicle can be swapped for another, false otherwise [Boolean]
    
    Example(s):
		[_spawnPoint] call vn_mf_fnc_veh_asset_can_change_vehicle;
*/

params ["_spawnPoint"];

// Vehicle must be in one of these states (e.g, no respawning or repairing)
if !((_spawnPoint get "status" get "state") in ["ACTIVE", "IDLE", "DISABLED"]) exitWith { false };

private _vehicle = _spawnPoint getOrDefault ["currentVehicle", objNull];
private _spawnPos = _spawnPoint get "spawnLocation" get "pos";

// Can't be too far from the spawn point
if (getPosASL _vehicle distance2D _spawnPos > vn_mf_veh_asset_vehicle_change_max_distance) exitWith { false };

// Can't have an alive player in the vehicle
if (crew _vehicle findIf {alive _x && isPlayer _x} > -1) exitWith { false };

true
