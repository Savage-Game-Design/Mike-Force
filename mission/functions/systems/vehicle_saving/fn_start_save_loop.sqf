/*
    File: fn_start_save_loop.sqf
    Author: Ridderrasmus
    Public: No

    Description:
	    Starts the main autosave loop for vehicles and crates.

    Parameter(s):
        _minBtwnSaves - The amount of minutes between saves [INT]

    Returns: nothing

    Example(s):
	    [20] call vn_mf_fnc_start_save_loop;
*/

params[
	["_minBtwnSaves", 20]
];

if (isServer) then {

	// Execute save every 20 minutes
	
	[_minBtwnSaves] spawn {
		while {true} do {
			sleep ((_this select 0) * 60);
			[] call vn_mf_fnc_full_save;
		};
	};
	

};