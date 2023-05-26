/*
    File: fn_veh_asset_finalise_spawn_point_setup_on_client.sqf
    Author: Spoffy
    Date: 2023-05-26
    Last Update: 2023-05-26
    Public: No
    
    Description:
        Sets up the client side of a spawn point (actions, UI, etc).
    
    Parameter(s):
        _id - ID of the spawn point [String]
        _object - Object to add spawn point status + actions to [Object]
        _settings - Spawn point settings, same as on the server [HashMap]

    Returns:
        Function reached the end [BOOL]
    
    Example(s):
        [parameter] call vn_fnc_myFunction
*/

params ["_id"];

if (isNil "vn_mf_veh_asset_spawn_points_client") then {
    vn_mf_veh_asset_spawn_points_client = createHashMap;
};

vn_mf_veh_asset_spawn_points_client set [_id, createHashMapFromArray [
    
]];

//TODO Setup change vehicle actions
{


} forEach (_settings getOrDefault ['vehicles', []]);

//TODO Setup "return vehicle to spawn" action as zeus

//TODO Setup interaction overlay
_object setVariable ["#para_InteractionOverlay_Data", [
    [_settings get "name"] call para_c_fnc_localize, 
    "", 
    "", // TODO - Respawn
    {[]}, 
    true,
]];

