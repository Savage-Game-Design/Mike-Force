/*
    File: fn_veh_asset_set_global_variable.sqf
    Author: Spoffy
    Date: 2023-05-26
    Last Update: 2023-05-26
    Public: No
    
    Description:
        Sets a variable on the spawn point, and synchronises it with the client.
    
    Parameter(s):
        _spawnPoint - Spawn point to set variable on [HashMap]
        _variable - Variable to set [Any hashmap key]
        _value - Value to set variable to [Any]
    
    Returns:
        Nothing
    
    Example(s):
        [_spawnPoint, "currentVehicle", objNull] call vn_mf_fnc_veh_asset_set_global_variable
*/

params ["_spawnPoint", "_variable", "_value"];

_spawnPoint set [_variable, _value];

[_spawnPoint] remoteExec ["vn_mf_fnc_veh_asset_update_spawn_point_data", 0, format ["vn_mf_spawnpoint_%1", _spawnPoint get "id"]];