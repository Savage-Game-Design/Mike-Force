/*
    File: fn_veh_asset_update_spawn_point_client.sqf
    Author: Spoffy
    Date: 2023-05-26
    Last Update: 2023-05-26
    Public: No
    
    Description:
        Deletes a spawn point from the client.
    
    Parameter(s):
        _spawnPointId - ID of the spawn point to remove [STRING]
    
    Returns:
	   	Nothing
    
    Example(s):
		["32"] remoteExecCall ["vn_mf_fnc_veh_asset_remove_spawn_point_client", 0];
*/

params ["_spawnPoint"];

vn_mf_veh_asset_spawn_points_client set [_spawnPoint get "id", _spawnPoint];