/*
	File: fn_veh_asset_add_spawn_point_client.sqf
	Author: Savage Game Design
	Public: Yes

	Description:
		Adds a vehicle spawn point to the client. 
		Doesn't perform any setup, just registers a spawn point with that ID.

	Parameter(s):
		_id - Spawn point ID to create spawn point with [String]

	Returns: 
		Spawn point info [HashMap]

	Example(s): 
		None
*/

params ["_spawnPointId"];

if (isNil "vn_mf_veh_asset_spawn_points_client") then {
	vn_mf_veh_asset_spawn_points_client = createHashMap;
};

vn_mf_veh_asset_spawn_points_client set [_spawnPointId, createHashMap];