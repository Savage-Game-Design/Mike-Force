/*
	File: fn_veh_asset_set_idle.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Sets a vehicle asset to idle.

	Parameter(s):
		_id - Id of vehicle asset [Number]

	Returns: nothing

	Example(s): none
*/

params ["_id"];

private _vehicle = [_id] call vn_mf_fnc_veh_asset_get_by_id;
_vehicle set [struct_veh_asset_info_m_state_data, ["IDLE", serverTime]];

[_id] call vn_mf_fnc_veh_asset_marker_delete;