/*
    File: fn_veh_asset_set_client_variables.sqf
    Author: Spoffy
    Date: 2023-05-26
    Last Update: 2023-05-26
    Public: No
    
    Description:
        Sets multiple variables on a spawn point object (clientside)
    
    Parameter(s):
        _spawnPointId - ID of the spawnpoint to set the variable on [String]
        _map - HashMap to merge into the spawn point info [HashMap]
    
    Returns:
	   	Nothing
    
    Example(s):
		["32", createHashMapFromArray [["A", 1]]] remoteExecCall ["vn_mf_fnc_veh_asset_set_variables_on_client", 0];
*/

params ["_spawnPointId", "_map"];

private _spawnPointInfo = vn_mf_veh_asset_spawn_points_client get _spawnPointId;

if (isNil "_spawnPointInfo") exitWith {};

_spawnPointInfo merge [_map, true];