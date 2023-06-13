/*
	File: fn_veh_asset_marker_delete.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Deletes the current marker for a spawn point.

	Parameter(s):
		_spawnPoint - Spawn point to delete the vehicle marker from [HashMap]

	Returns: nothing

	Example(s): none
*/

params ["_spawnPoint"];

private _marker = _spawnPoint getOrDefault ["marker", ""];

if (_marker != "") then {
	[_marker] call para_g_fnc_delete_localized_marker;
	_spawnPoint set [_marker, ""];
}; 