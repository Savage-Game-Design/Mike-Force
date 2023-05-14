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

//TODO - Remove "package wreck for transport" if wreck has it.
//Shouldn't be an issue with our use case... for now.