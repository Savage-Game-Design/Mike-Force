/*
	File: fn_arsenal_trash_cleanup_init.sqf
	Author: Savage Game Design
	Public: Yes

	Description:
		Called to initialise the trashcans on the map near arsenals.

	Parameter(s):
		None

	Returns:
		true when executed successfully, nil on error.

	Example(s):
		call vn_mf_fnc_arsenal_trash_cleanup_init;
*/

diag_log format ["INFO: %1: Loading trash cans ...", _fnc_scriptName];

private _arsenals = missionNamespace getVariable ["vn_mf_arsenals", []];

if (_arsenals isEqualTo []) exitWith {
	diag_log format [
		"WARN: %1: No mike force arsenals initialised, cannot init trash cans.",
		_fnc_scriptName
	];
	nil
};

_arsenals
	apply {
		// find nearby trash can objects (within 10m) and add the clean up action
		(nearestObjects [_x, [], 10, true])
			select {typeOf _x isEqualTo "Land_vn_object_trashcan_01"}
			apply {
				_x addAction [
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
			};
	};

diag_log format ["INFO: %1: Trash cans loaded.", _fnc_scriptName];

true