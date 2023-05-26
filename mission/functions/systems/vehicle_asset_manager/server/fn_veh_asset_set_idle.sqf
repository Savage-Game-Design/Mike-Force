/*
	File: fn_veh_asset_set_idle.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Sets a spawn point's vehicle status to idle.

	Parameter(s):
		_spawnPoint - Spawn point whose status should be set to idle [Object]

	Returns: nothing

	Example(s): none
*/

params ["_spawnPoint"];

_spawnPoint set ["status", createHashMapFromArray [
	["state", "IDLE"], 
	["lastChanged", serverTime]
]];

[_spawnPoint] call vn_mf_fnc_veh_asset_marker_delete;