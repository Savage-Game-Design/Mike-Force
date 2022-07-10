/*
	File: fn_zone_create_assets_for_completed_zone.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Creates the parts of a zone that only exist when it's completed, such as the supply officer.

	Parameter(s): none

	Returns: nothing

	Example(s): none
*/

params ["_zone"];

["Creating assets for completed zone: %1", _zone] call BIS_fnc_logFormat;

/*
private _supplyOfficerMarker = format ["supply_officer_%1", _zone];
if !(markerShape _supplyOfficerMarker == "") then {
	[_supplyOfficerMarker] call vn_mf_fnc_create_supply_officer;
};
*/