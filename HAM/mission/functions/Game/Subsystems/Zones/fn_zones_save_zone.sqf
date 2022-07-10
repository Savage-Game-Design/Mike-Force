/*
	File: fn_zones_save_zone.sqf
	Author: Savage Game Design
	Public: Yes
	
	Description:
		Saves a zone.
	
	Parameter(s):
		_zoneData - Data of zone to save [ARRAY]
	
	Returns:
		Data saved [ARRAY]
	
	Example(s):
		[localNamespace getVariable "zone_ba_ria"] call vn_mf_fnc_zones_save_zone;
*/

params ["_zoneData"];

private _dataToSave = [
	//Version
	2,
	_zoneData select struct_zone_m_marker,
	_zoneData select struct_zone_m_captured
];

["SET", "zone_data" + (_zoneData select struct_zone_m_marker), _dataToSave] call para_s_fnc_profile_db;

_dataToSave
