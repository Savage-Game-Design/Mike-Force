/*
	File: fn_veh_asset_set_respawning.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Marks a spawn point as respawning its vehicle.

	Parameter(s):
		_spawnPoint - Spawn point in the process of respawning [HashMap]
		_repairTime - When to respawn. Pulled from the info if not  [Number, defaults to 0]

	Returns: nothing

	Example(s): none
*/

params ["_spawnPoint", "_respawnTime"];

if (isNil "_respawnTime") then {
	_respawnTime = _spawnPoint get "settings" getOrDefault ["time", 0];
};

[_spawnPoint, "status", createHashMapFromArray [
	["state", "RESPAWNING"], 
	["lastChanged", serverTime],
	["finishesAt", serverTime + _respawnTime]
]] call vn_mf_fnc_veh_asset_set_global_variable;

[_spawnPoint] call vn_mf_fnc_veh_asset_marker_delete;
