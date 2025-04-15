/*
	File: fn_arsenals_init.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Sets up arsenals with Arsenal map markers
		and finds nearby trashcans to initialise when player joins

	Parameter(s): none

	Returns:
		true when executed successfully

	Example(s):
		call vn_mf_fnc_arsenals_init;
*/


diag_log format ["INFO: %1: Loading arsenals ...", _fnc_scriptName];

// can be multiple WL arsenal modules in the mission
// also possible to sync different module instances to the same arsenal object
private _wlModules = allMissionObjects "Logic" select {typeOf _x isEqualTo "vn_module_whitelistedarsenal"};
private _arsenals = flatten (_wlModules apply {synchronizedObjects _x});
_arsenals = _arsenals arrayIntersect _arsenals;

{
	// create map markers for arsenal objects
	_marker = createMarkerLocal [format["vn_mf_arsenal_%1", _forEachIndex], _x];
	_marker setMarkerTextLocal "Arsenal";
	_marker setMarkerTypeLocal "mil_dot";
	_marker setMarkerColorLocal "ColorPink";
	_marker setMarkerAlpha 1;
} forEach _arsenals;

missionNamespace setVariable ["vn_mf_arsenals", _arsenals];
diag_log format ["INFO: %1: Loaded %2 arsenals.", _fnc_scriptName, count _arsenals];
true;