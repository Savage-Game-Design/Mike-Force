/*
	File: fn_veh_asset_set_repairing.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Marks a spawn point's vehicle as being repaired.

	Parameter(s):
		_spawnPoint - Spawn point of vehicle asset [HashMap]
		_repairTime - Time to repair the vehicle [Number, defaults to 0]

	Returns: nothing

	Example(s): none
*/

params ["_spawnPoint", "_repairTime"];

if (isNil "_repairTime") then {
	_repairTime = _spawnPoint get "settings" getOrDefault ["time", 0];
};

[_spawnPoint, "status", createHashMapFromArray [
	["state", "REPAIRING"], 
	["lastChanged", serverTime],
	["finishesAt", serverTime + _repairTime]
]] call vn_mf_fnc_veh_asset_set_global_variable;

[_spawnPoint] call vn_mf_fnc_veh_asset_marker_delete;

_spawnPoint getOrDefault ["currentVehicle", objNull] hideObjectGlobal true;