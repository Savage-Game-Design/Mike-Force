/*
    File: zone_marker_hostile_zone_info.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Internal use. Updates the zone marker hashMap with hostile zone info

    Parameter(s):
        _marker - Zone marker [STRING, defaults to nil]

    Returns:
        Information about the zone [TEXT]

    Example(s):
        ["zone_locationName"] call vn_mf_fnc_zone_marker_hostile_zone_info;
*/
params ["_marker"];

private _typeStart = (_marker find "_") + 1;
// If no type starter display the raw marker variable. Check for 0 because we've added 1 to the find call.
if (_typeStart == 0) exitWith {_marker};

private _type = _marker select [0, _typeStart];

// If this somehow gets called on a marker that isin't a zone display the raw marker variable
if (_type != "zone_") exitWith {_marker};

// Split to allow for spaces
private _zoneName = _marker splitString "_";
// Trim marker type
_zoneName deleteAt 0;
// Check if spaces are required
private _splitCheck = count _zoneName;
// If spaces are requried, add them, else convert ARRAY to STRING to allow data to be pushed to show info function
if (_splitCheck > 1) then {
  _zoneName = _zoneName joinString " ";
} else {
  _zoneName = _zoneName select 0;
};
// Capitalize name
private _zoneName = toUpper _zoneName;
// Define info to show
private _info = [
    _zoneName
];
_info
