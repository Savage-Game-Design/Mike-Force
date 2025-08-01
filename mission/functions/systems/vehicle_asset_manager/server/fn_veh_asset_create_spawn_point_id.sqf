/*
    File: fn_veh_asset_create_spawn_point_id.sqf
    Author: Spoffy
    Date: 2023-05-08
    Last Update: 2023-05-08
    Public: No
    
    Description:
		Generates a new ID for a new spawn point
    
    Parameter(s):
	   	None
    
    Returns:
	   	Unique ID for the spawn point [String]
    
    Example(s):
		[] call vn_mf_fnc_veh_asset_create_spawn_point_id;
*/

if (isNil "veh_asset_spawn_point_counter") then {
	veh_asset_spawn_point_counter = 0;
};

veh_asset_spawn_point_counter = veh_asset_spawn_point_counter +	1;

format ["%1", veh_asset_spawn_point_counter]
