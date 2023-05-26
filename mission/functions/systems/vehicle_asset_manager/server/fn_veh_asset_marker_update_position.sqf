/*
	File: fn_veh_asset_marker_update_position.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Updates the position of an existing marker.

	Parameter(s):
		_spawnPoint - Spawn point whose marker should be updated [HashMap]

	Returns: nothing

	Example(s): none
*/

params ["_spawnPoint"];

private _marker = _spawnPoint getOrDefault ["marker", ""];
if (_marker == "") exitWith {};

private _vehicle = _spawnPoint getOrDefault ["currentVehicle", objNull];

[
	[_marker, _vehicle],
	{
		params ["_markerName", "_vehicle"];
		_markerName setMarkerPosLocal getPos _vehicle;
	}
] remoteExec ["call", 0, _marker];