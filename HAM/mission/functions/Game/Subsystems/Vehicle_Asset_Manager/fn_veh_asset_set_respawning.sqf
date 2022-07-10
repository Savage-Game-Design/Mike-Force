/*
	File: fn_veh_asset_set_respawning.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Marks a vehicle asset as respawning.

	Parameter(s):
		_id - Id of vehicle asset [Number]
		_repairTime - When to respawn. Pulled from the info if not  [Number, defaults to 0]

	Returns: nothing

	Example(s): none
*/

params ["_id", "_respawnTime"];

private _vehicleInfo = [_id] call vn_mf_fnc_veh_asset_get_by_id;

if (isNil "_respawnTime") then {
	_respawnTime = _vehicleInfo select struct_veh_asset_info_m_respawn_info select 1;
};

_vehicleInfo set [struct_veh_asset_info_m_state_data, ["RESPAWNING", serverTime + _respawnTime]];

[_id] call vn_mf_fnc_veh_asset_marker_delete;
