/*
    File: fn_veh_asset_remove_spawn_point.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
        Removes a spawn point from the asset manager
    
    Parameter(s):
        _id - Id of the spawn point to remove [STRING]
    
    Returns:
        None
    
    Example(s):
        ["mySpawnPointId"] call vn_mf_fnc_veh_asset_remove_spawn_point;
*/
params ["_id"];

vn_mf_veh_asset_spawn_points deleteAt _id;

[_id] remoteExec ["vn_mf_fnc_veh_asset_remove_spawn_point_client", 0];
// Clear the spawnpoint data update from the JIP queue
remoteExec ["", format ["vn_mf_spawnpoint_%1", _id]];

// TODO Cleanup on the client when the spawnpoint is removed. E.g statuses, actions, etc.

//TODO - Remove "package wreck for transport" if wreck has it.
//Shouldn't be an issue with our use case... for now.