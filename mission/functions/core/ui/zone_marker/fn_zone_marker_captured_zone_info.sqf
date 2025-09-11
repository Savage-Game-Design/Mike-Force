/*
    File: zone_marker_captured_zone_info.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Internal use. Updates the zone marker hashMap with captured zone info

    Parameter(s):
        _marker - Zone marker [STRING, defaults to nil]

    Returns:
        Information about the zone [TEXT]

    Example(s):
        ["zone_locationName"] call vn_mf_fnc_zone_marker_captured_zone_info;
*/
params ["_marker"];
//returns the string table entry
[format ["%1 [Captured]", [_marker] call vn_mf_fnc_zone_marker_to_name]]
