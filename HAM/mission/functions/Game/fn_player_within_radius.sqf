/*
	File: fn_player_within_radius.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Tests if a player is within a given radius of a position.
		Implement as a function, so we can optimise it easily later.
	
	Parameter(s):
		_pos - Center position [Position]
		_radius - Radius [Number]
	
	Returns:
		True if a player is within the given radius [Boolean]
	
	Example(s):
		[[0,0,0], 100] call vn_mf_fnc_player_within_radius
*/

params ["_pos", "_radius"];

(playableUnits findIf {_x distance2D _pos < _radius} > -1)