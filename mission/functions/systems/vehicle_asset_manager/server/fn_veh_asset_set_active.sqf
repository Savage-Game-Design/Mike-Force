/*
	File: fn_veh_asset_set_active.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Marks a spawn point's vehicle as being in active use.

	Parameter(s):
		_spawnPoint - Spawn point whose vehicle should be set as active [HashMap]

	Returns: nothing

	Example(s): none
*/

params ["_spawnPoint"];

[_spawnPoint, "status", createHashMapFromArray [
	["state", "ACTIVE"], 
	["lastChanged", serverTime]
]] call vn_mf_fnc_veh_asset_set_global_variable;

[_spawnPoint] call vn_mf_fnc_veh_asset_marker_delete;