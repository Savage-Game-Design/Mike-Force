/*
    File: fn_veh_asset_set_global_variables.sqf
    Author: Spoffy
    Date: 2023-05-26
    Last Update: 2023-05-26
    Public: No
    
    Description:
        Sets multiple variable on the spawn point, and synchronises it with the client in a more efficient way than individually setting them.
    
    Parameter(s):
        _spawnPoint - Spawn point to set variable on [HashMap]
        _variableValuePairs - Array of 2 element arrays, each containing a variable name and value [Array]

    Returns:
        Nothing
    
    Example(s):
        [_spawnPoint, [["currentVehicle", objNull], ["status", "Gone fishing"]]] call vn_mf_fnc_veh_asset_set_global_variables;
*/

params ["_spawnPoint", "_variableValuePairs"];

private _map = createHashMapFromArray _variableValuePairs;

_spawnPoint merge [_map, true];

[_spawnPoint] remoteExec ["vn_mf_fnc_veh_asset_update_spawn_point_data", 0, format ["vn_mf_spawnpoint_%1", _spawnPoint get "id"]];