/*
	File: fn_save_time_elapsed.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		calculates saves and broadcasts total game time elapsed
	
	Parameter(s):
		call vn_mf_fnc_save_time_elapsed;
	
	Returns:
		calculate and return total game time [Number]
	
	Example(s): none
*/

private _ticktime = diag_ticktime;

// init time elapsed counter
if (isNil "vn_mf_lastticktime") then
{
	vn_mf_lastticktime = _ticktime;
};

// get current time
(["GET", "game_time", 0] call para_s_fnc_profile_db) params ["","_savedtime"];

// increment by time elapsed since last activation
private _elapsedtime = _ticktime - vn_mf_lastticktime;

(["SET", "game_time", (_savedtime + _elapsedtime)] call para_s_fnc_profile_db) params ["","_savedtime"];

// broadcast total time elapsed -	update
missionNamespace setVariable ["para_g_totalgametime", _savedtime];
publicVariable "para_g_totalgametime";

// do ttl check on db
["TTLCHECK"] call para_s_fnc_profile_db;
// force db save periodically
["SAVE"] call para_s_fnc_profile_db;

// update internal counter
vn_mf_lastticktime = _ticktime;

_savedtime
