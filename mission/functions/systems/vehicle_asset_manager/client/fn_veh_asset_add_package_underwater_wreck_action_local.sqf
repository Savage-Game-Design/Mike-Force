/*
	File: fn_veh_asset_add_package_underwater_wreck_action_local
	Author: Savage Game Design
	Public: No

	Description:
		Adds package underwater wreck action to the player

	Parameter(s):
		_target - Object addAction is to be added to [Object]

	Returns: nothing

	Example(s): Not to be directly called
*/

params ["_target"];

private _actionVariable = format ["veh_asset_package_underwater_wreck_action_%1", netId _target];
private _existingActionId = player getVariable _actionVariable;

if (!isNil "_existingActionId") exitWith {};

private _actionId = player addAction [
	"Package underwater wreck",
	{
		params ["_target", "_caller", "_actionId", "_args"];
		["packageforslingloading", _args] call para_c_fnc_call_on_server;
	},
	[_target],
	1.5,
	false,
	true,
	"",
	"vehicle player isKindOf 'Ship'",
	-1,
	false
];

player setVariable [_actionVariable, _actionId];