/*
	File: fn_veh_asset_set_wrecked.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Marks a vehicle asset as wrecked. Wrecks it if it isn't already.

	Parameter(s):
		__spawnPoint - Spawn point whose vehicle should be set as wrecked [HashMap]

	Returns: nothing

	Example(s): none
*/

params ["_spawnPoint"];

private _vehicle = _spawnPoint getOrDefault ["currentVehicle", objNull];

//if it's deleted, not a lot we can do about it, as we have no position! Might as well just set it to repair.
if (isNull _vehicle) exitWith {
	["VN MikeForce: Vehicle for spawn point %1 was deleted and respawn type is Wreck. Sending to repair", _spawnPoint get "id"] call BIS_fnc_logFormat;
	[_spawnPoint] call vn_mf_fnc_veh_asset_set_repairing;
};

[_spawnPoint, "status", createHashMapFromArray [
	["state", "WRECKED"], 
	["lastChanged", serverTime],
	["posASL", getPosASL _vehicle],
	["dir", getDir _vehicle]
]] call vn_mf_fnc_veh_asset_set_global_variable;

//Kaboom. We don't want TWO vehicles by accident.
if (alive _vehicle) then {
	_vehicle setDamage 1;
};

[_vehicle] call vn_mf_fnc_veh_asset_setup_package_wreck_action;

[_spawnPoint, "WRECK"] call vn_mf_fnc_veh_asset_marker_create;

