/*
	File: fn_lock_vehicle_to_teams.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Prevents a vehicle being used by players who aren't on one of the specified teams.
	
	Parameter(s):
	_vehicle - Vehicle to lock [Object]
	_teams - Array of teams to restrict to [String[]]
	
	Returns: nothing
	
	Example(s): none
*/

params ["_vehicle", "_teams"];

_vehicle setVariable ["teamLock", _teams, true];