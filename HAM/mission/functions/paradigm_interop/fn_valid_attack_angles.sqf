/*
	File: fn_valid_attack_angles.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Calculate valid angles to spawn in at when attacking a point.
		It tries to avoid attacking from/through the airbase, as it doesn't make sense
	
	Parameter(s):
		_pos - Position to attack [Position]
	
	Returns: nothing
	
	Example(s): none
*/

params ["_position"];

private _airbasePos = getMarkerPos "mf_respawn_greenhornets";
private _directionToAirbase = (_position getDir _airbasePos) + (-60 + random 120);

private _lerpFactor = ((_position distance2D _airbasePos) / 2500) min 1;
private _deviation = [0, 135, _lerpFactor] call BIS_fnc_lerp;

[_directionToAirbase - _deviation, _directionToAirbase + _deviation]