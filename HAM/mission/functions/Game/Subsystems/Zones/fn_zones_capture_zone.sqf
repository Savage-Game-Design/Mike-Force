/*
	File: fn_zones_capture_zone.sqf
	Author: Savage Game Design
	Public: Yes

	Description:
		Marks a zone as captured

	Parameter(s):
		_zone - Zone name [String]

	Returns:
		None

	Example(s):
		["zone_ba_ria"] call vn_mf_fnc_zones_capture_zone;
*/

params ["_zone"];

localNamespace getVariable [_zone, []] set [struct_zone_m_captured, true];

_zone setMarkerColor "ColorGreen";
[_zone, "zone_captured"] call para_c_fnc_zone_marker_add;
