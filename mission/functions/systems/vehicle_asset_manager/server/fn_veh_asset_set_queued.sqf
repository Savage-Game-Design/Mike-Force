/*
	File: fn_veh_asset_set_queued.sqf
	Author: Savage Game Design
	Public: No
	Description:
		Marks the spawn point into queued satus -- we're going to be respawning the vehicle shortly.
	Parameter(s):
		_spawnPoint - Spawn point whose vehicle should be set as queued [HashMap]
	Returns: nothing
	Example(s): none
*/

params ["_spawnPoint"];

[_spawnPoint, "status", createHashMapFromArray [
	["state", "QUEUED"], 
	["finishesAt", serverTime + 2 +  count vn_mf_spawn_points_to_respawn],
	["lastChanged", serverTime]
]] call vn_mf_fnc_veh_asset_set_global_variable;

[_spawnPoint] call vn_mf_fnc_veh_asset_marker_delete;