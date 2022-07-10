/*
	File: fn_veh_asset_setup_package_wreck_action.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Prepares a wreck to be loaded into a crate.

	Parameter(s):
		_id - Id of vehicle asset [Number]

	Returns: nothing

	Example(s): none
*/

params ["_id"];

private _vehicle = [_id] call vn_mf_fnc_veh_asset_get_by_id select struct_veh_asset_info_m_vehicle;

[
	[_id, _vehicle],
	"vn_mf_fnc_veh_asset_setup_package_wreck_action_local",
	0,
	_vehicle
] call para_s_fnc_remoteExec_jip_obj_stacked;
