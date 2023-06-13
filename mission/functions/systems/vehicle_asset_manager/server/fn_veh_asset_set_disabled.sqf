/*
	File: fn_veh_asset_set_disabled.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Sets a spawn point's vehicle asset to disabled.

	Parameter(s):
		_spawnPoint - Spawn point whose vehicle should be set as disabled [HashMap]

	Returns: nothing

	Example(s): none
*/

params ["_spawnPoint"];

[_spawnPoint, "status", createHashMapFromArray [
	["state", "DISABLED"], 
	["lastChanged", serverTime]
]] call vn_mf_fnc_veh_asset_set_global_variable;

[_spawnPoint, "DISABLED"] call vn_mf_fnc_veh_asset_marker_create;