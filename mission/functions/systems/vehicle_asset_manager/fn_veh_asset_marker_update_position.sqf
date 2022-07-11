/*
	File: fn_veh_asset_marker_update_position.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Updates the position of an existing marker.

	Parameter(s):
		_id - Id of the vehicle asset [Number]

	Returns: nothing

	Example(s): none
*/


params ["_id", "_type"];

private _vehicleInfo = [_id] call vn_mf_fnc_veh_asset_get_by_id;
private _marker = _vehicleInfo select struct_veh_asset_info_m_marker;
if (_marker == "") exitWith {};

private _vehicle = _vehicleInfo select struct_veh_asset_info_m_vehicle;

[
	[_marker, _vehicle],
	{
		params ["_markerName", "_vehicle"];
		_markerName setMarkerPosLocal getPos _vehicle;
	}
] remoteExec ["call", 0, _marker];