/*
	File: fn_arsenals_init.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Sets up arsenals with Arsenal map markers
		and finds nearby trashcans to initialise when player joins

	Parameter(s): none

	Returns: nothing

	Example(s):
		Not called directly
*/


diag_log "Loading arsenals ...";

private _arsenals = synchronizedObjects (
	allMissionObjects "Logic" select {typeOf _x isEqualTo "vn_module_whitelistedarsenal"}
);

{
	// store an array of nearby trashcans for clients to
	// initialise the 'Clean Up' action on server join
	private _trash_cans = (nearestObjects [_x, [], 10, true]) select {
		typeOf _x isEqualTo "Land_vn_object_trashcan_01"
	};
	_x setVariable ["trashcans", _trash_cans];

	// create map markers for arsenal objects
	_marker = createMarkerLocal [format["vn_mf_arsenal_%1", _forEachIndex], _x];
	_marker setMarkerTextLocal "Arsenal";
	_marker setMarkerTypeLocal "mil_dot";
	_marker setMarkerColorLocal "ColorPink";
	_marker setMarkerAlpha 1;
} forEach _arsenals;

missionNamespace setVariable ["vn_mf_arsenals", _arsenals];
diag_log format ["Loaded %1 arsenals.", _arsenals];
true;