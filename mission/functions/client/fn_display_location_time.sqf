/*
    File: fn_display_location_time.sqf
    Author: Savage Game Design
    Public: No

    Description:
	    Displays location and gametime.

    Parameter(s): none

    Returns: nothing

    Example(s):
	    call vn_mf_fnc_display_location_time;
*/

private _nearestLocations = nearestLocations [getPos player, ["Hill", "StrongpointArea", "NameVillage", "NameCity", "NameCityCapital"], 500];
if (_nearestLocations isEqualTo []) exitWith {};
private _nearestLocation = text (_nearestLocations select 0);
private _gametime = [para_g_totalgametime, "HH:MM"] call BIS_fnc_secondsToString;
[parseText format["<t font='tt2020base_vn' size='1.6'>%1</t><br /><t font='tt2020base_vn' size='1.0'>%2</t>",_nearestLocation,_gametime], true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;
