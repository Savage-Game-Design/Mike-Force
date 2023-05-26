/*
    File: fn_veh_asset_update_spawn_point_data.sqf
    Author: Spoffy
    Date: 2023-05-26
    Last Update: 2023-05-26
    Public: No
    
    Description:
        Updates the hashmap for a specific spawn point.
        Allows the server to essentially 'publicVariable' a specific spawn point.
    
    Parameter(s):
        _spawnPoint - Spawnpoint to update [HashMap]
    
    Returns:
	   	Nothing
    
    Example(s):
		[_spawnPoint] remoteExecCall ["vn_mf_fnc_veh_asset_update_spawn_point_data", 0, format ["vn_mf_spawnpoint_%1", _spawnPoint get "id"]];
*/

params ["_spawnPoint"];

private _id = _spawnPoint get "id";

if (isNil "vn_mf_veh_asset_spawn_points_client") then {
	vn_mf_veh_asset_spawn_points_client = createHashMap;
};

private _shouldInitialise = !(_id in vn_mf_veh_asset_spawn_points_client);

vn_mf_veh_asset_spawn_points_client set [_id, _spawnPoint];

if (_shouldInitialise) then {
    [_spawnPoint] call vn_mf_fnc_veh_asset_finalise_spawn_point_setup_on_client;
};