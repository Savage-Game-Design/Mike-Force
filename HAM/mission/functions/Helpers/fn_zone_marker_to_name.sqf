/*
	File: fn_zone_marker_to_name.sqf
	Author: Savage Game Design
	Public: Yes

	Description:
		Finds and returns the name of a zone from the stringtable.

	Parameter(s):
		_markerName - Marker ID of the marker to retrieve the name for [String]

	Returns: _zoneName [String]

	Example(s):
		["zone_hue"] call vn_mf_fnc_zone_marker_to_name;
*/

params ["_markerName"];

private _stringtableKey = format ["STR_vn_mf_%1", _markerName];
localize _stringtableKey;
