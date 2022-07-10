/*
	File: fn_veh_asset_set_wrecked.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Marks a vehicle asset as wrecked. Wrecks it if it isn't already.

	Parameter(s):
		_id - Id of vehicle asset [Number]

	Returns: nothing

	Example(s): none
*/

params ["_id"];

private _vehicleInfo = [_id] call vn_mf_fnc_veh_asset_get_by_id;
private _vehicle = _vehicleInfo select struct_veh_asset_info_m_vehicle;

//if it's deleted, not a lot we can do about it, as we have no position! Might as well just set it to repair.
if (isNull _vehicle) exitWith {
	["VN MikeForce: Vehicle %1 was deleted and respawn type is Wreck. Sending to repair", _id] call BIS_fnc_logFormat;
	[_id] call vn_mf_fnc_veh_asset_set_repairing;
};

_vehicleInfo set [struct_veh_asset_info_m_state_data, ["WRECKED", getPosASL _vehicle, getDir _vehicle]];

//Kaboom. We don't want TWO vehicles by accident.
if (alive _vehicle) then {
	_vehicle setDamage 1;
};

[_id] call vn_mf_fnc_veh_asset_setup_package_wreck_action;

[_id, "WRECK"] call vn_mf_fnc_veh_asset_marker_create;

