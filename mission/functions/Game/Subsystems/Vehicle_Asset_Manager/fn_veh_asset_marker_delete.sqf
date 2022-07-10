/*
	File: fn_veh_asset_marker_delete.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Deletes the current marker for a vehicle.

	Parameter(s):
		_id - Id of the vehicle asset [Number]

	Returns: nothing

	Example(s): none
*/

params ["_id"];

private _vehicleInfo = [_id] call vn_mf_fnc_veh_asset_get_by_id;
private _marker = _vehicleInfo select struct_veh_asset_info_m_marker;

if (_marker != "") then {
	[_marker] call para_g_fnc_delete_localized_marker;
	_vehicleInfo set [struct_veh_asset_info_m_marker, ""];
}; 