/*
	File: fn_veh_asset_add_unlock_action.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Adds an action that unlocks a vehicle that's in simulation disabled mode.
	
	Parameter(s):
		_id - Id of vehicle asset [Number]

	Returns: nothing

	Example(s): none
*/

params ["_id"];

private _vehicle = [_id] call vn_mf_fnc_veh_asset_get_by_id select struct_veh_asset_info_m_vehicle;

[
	_vehicle,
	"Unlock vehicle",
	{
		params ["_target", "_caller", "_id", "_args"];
		[_args select 0] call vn_mf_fnc_veh_asset_unlock_vehicle;
	},
	[_id],
	1.5,
	false,
	true,
	"",
	"_originalTarget getVariable ['vn_mf_g_veh_asset_locked', false]",
	10,
	false
] call para_s_fnc_net_action_add;