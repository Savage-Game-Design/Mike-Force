/*
    File: fn_arsenal_trash_cleanup_init.sqf
    Author: Savage Game Design
    Public: Yes

    Description:
        Called to initialise the trashcans on the map near arsenals.

    Parameter(s):
        None

    Returns:
        None

    Example(s):
        call vn_mf_fnc_arsenal_trash_cleanup_init;
*/

private _arsenals = allMapMarkers select {_x find "arsenal" isEqualTo 0};

{
	private _trashCan = missionNamespace getVariable [format["arsenal_cleanup_%1",_forEachIndex], objNull];
	_trashCan addAction
	[
		"Clean Up",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			["arsenalcleanup", [_target]] call para_c_fnc_call_on_server;
		},
		nil,
		1.5,
		true,
		true,
		"",
		"true",
		5,
		false,
		"",
		""
	];
} forEach _arsenals;