/*
    File: fn_veh_asset_change_vehicle.sqf
    Author: Spoffy
    Date: 2023-06-05
    Last Update: 2023-06-05
    Public: No
    
    Description:
	   	Changes the vehicle on the given spawn point for another valid vehicle.
    
    Parameter(s):
        _spawnPoint - Spawn point to change the vehicle of [HashMap]
		_vehicleClass - Class of vehicle to spawn. Must be present in the spawn point config [String]
    
    Returns:
		The newly created vehicle, or nil if a vehicle can't be created [Object]
    
    Example(s):
		[_spawnpoint] call vn_mf_fnc_veh_asset_change_vehicle;
*/

params ["_spawnPoint", "_vehicleClass"];

private _canChange = [_spawnPoint] call vn_mf_fnc_veh_asset_can_change_vehicle;

if !(_canChange) exitWith {};
if !(_vehicleClass in (_spawnPoint get "settings" get "vehicles")) exitWith {
    ["ERROR", "Attempted to spawn invalid vehicle %1 from spawn point %2", _vehicleClass, _spawnPoint get "settings" get "name"] call para_g_fnc_log;
};

_spawnPoint set ["lastClassSpawned", _vehicleClass];

// Delete it here so the player gets instant feedback, rather than waiting for the respawn job to trigger.
private _oldVehicle = _spawnPoint getOrDefault ["currentVehicle", objNull];
deleteVehicle _oldVehicle;

[_spawnPoint, 0] call vn_mf_fnc_veh_asset_set_respawning;

