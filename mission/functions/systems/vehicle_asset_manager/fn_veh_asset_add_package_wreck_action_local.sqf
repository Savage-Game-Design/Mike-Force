/*
	File: fn_veh_asset_add_package_wreck_action_local.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Handles adding a "package for slingloading" action to the local player, when appropriate, for a specific vehicle.


	Parameter(s):
		_id - Id of vehicle asset [Number]
		_target - Object addAction is to be added to [Object]

	Returns: nothing

	Example(s): none
*/

params ["_id", "_target"];

["AddPackageWreck", [player, []]] call para_g_fnc_event_dispatch;

_target addAction [
	"Package wreck for transport",
	{
		params ["_target", "_caller", "_actionId", "_args"];
		["packageforslingloading", _args] call para_c_fnc_call_on_server;
	},
	[_id, _trigger],
	1.5,
	false,
	true,
	"",
	"true",
	10,
	false
];