/*
	File: fn_veh_asset_add_unlock_action.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Adds an action that unlocks a vehicle that's in simulation disabled mode.
	
	Parameter(s):
		_vehicle - Vehicle to add unlock action to [Object]

	Returns: nothing

	Example(s): none
*/

params ["_vehicle"];

[
	_vehicle,
	"Unlock vehicle",
	{
		params ["_target", "_caller", "_id", "_args"];
		[_target] call vn_mf_fnc_veh_asset_unlock_vehicle;
	},
	[],
	1.5,
	false,
	true,
	"",
	"_originalTarget getVariable ['vn_mf_g_veh_asset_locked', false]",
	10,
	false
] call para_s_fnc_net_action_add;