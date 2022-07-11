/*
    File: fn_end_mission.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		End mission event.
		[!:info] The return of this function should be ignored.
    
    Parameter(s): none
    
    Returns:
		Script Handle [Script]
    
    Example(s):
		call vn_mf_fnc_end_mission
*/

// turn off scheduler
 vn_mf_monitorScheduler = false;
 vn_mf_runScheduler = false;

[] spawn {
	uiSleep 1;
	// wipe db
	["CLEAR"] call para_s_fnc_profile_db;
	["SAVE"] call para_s_fnc_profile_db;
	"clear db" call BIS_fnc_log;

	uiSleep 1;
	// end mission
	'EveryoneWon' call BIS_fnc_endMissionServer;
	"Game ended!" call BIS_fnc_log;
};
