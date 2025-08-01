/*
    File: fn_veh_asset_handle_change_vehicle_request.sqf
    Author: Spoffy
    Date: 2023-06-11
    Last Update: 2023-06-11
    Public: No
    
    Description:
        REHandler function, that handles a request from the player to change a spawn point's vehicle.
    
    Parameter(s):
        _spawnPointId - ID of the spawn point to change the vehicle on [STRING]
		_vehicleClass - Class of vehicle to change to [STRING]
    
    Returns:
	   	Nothing
    
    Example(s):
		["change_spawn_point_vehicle", ["1", "vn_m151a1"]] call para_c_fnc_call_on_server
*/

params ["_spawnPointId", "_vehicleClass"];

private	_spawnPoint = vn_mf_veh_asset_spawn_points get _spawnPointId;

if (isNil "_spawnPoint") exitWith {};

[_spawnPoint, _vehicleClass] call vn_mf_fnc_veh_asset_change_vehicle;