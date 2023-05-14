/*
	File: fn_veh_asset_setup_package_wreck_action.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Prepares a wreck to be loaded into a crate.

	Parameter(s):
		_vehicle - Vehicle to add action to [Object]

	Returns: nothing

	Example(s): none
*/

params ["_vehicle"];

[
	[_vehicle],
	"vn_mf_fnc_veh_asset_setup_package_wreck_action_local",
	0,
	_vehicle
] call para_s_fnc_remoteExec_jip_obj_stacked;
