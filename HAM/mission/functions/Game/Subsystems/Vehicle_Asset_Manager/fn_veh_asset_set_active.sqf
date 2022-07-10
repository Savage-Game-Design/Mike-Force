/*
	File: fn_veh_asset_set_active.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Marks a vehicle asset as being in active use.

	Parameter(s):
		_id - Id of vehicle asset [Number]

	Returns: nothing

	Example(s): none
*/

params ["_id"];

[_id] call vn_mf_fnc_veh_asset_get_by_id set [struct_veh_asset_info_m_state_data, ["ACTIVE"]];
[_id] call vn_mf_fnc_veh_asset_marker_delete;