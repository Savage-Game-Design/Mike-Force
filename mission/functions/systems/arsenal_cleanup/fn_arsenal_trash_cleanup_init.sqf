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


private _arsenals = missionNamespace getVariable ["vn_mf_arsenals", []];

if (count _arsenals isEqualTo 0) exitWith {
	diag_log format ["WARN: %1: No arsenals initialised, cannot setup trashcan cleanup addAction."];
	nil;
};

_arsenals
	apply {
		// consider a 'trash can' to be any non WLA module objects synchronized to the arsenal object
		// (mission makers can then use other classes if they want to)
		(synchronizedObjects _x)
			select {typeOf _x isNotEqualTo "vn_module_whitelistedarsenal"}
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

true;