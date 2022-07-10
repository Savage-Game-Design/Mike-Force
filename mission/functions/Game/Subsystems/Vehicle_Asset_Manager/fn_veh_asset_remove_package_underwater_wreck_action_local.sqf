/*
	File: fn_veh_asset_remove_package_underwater_wreck_action_local.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Removes the package underwater wreck action from the player

	Parameter(s):
		_id - Vehicle asset ID

	Returns: nothing

	Example(s): Not to be directly called
*/

params ["_id"];

private _actionVariable = format ["veh_asset_package_underwater_wreck_action_%1", _id];
private _actionId = player getVariable _actionVariable;

if (isNil "_actionId") exitWith {};

player removeAction _actionId;
player setVariable [_actionVariable, nil];