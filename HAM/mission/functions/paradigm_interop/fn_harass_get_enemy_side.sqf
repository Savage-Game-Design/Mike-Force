/*
	File: fn_harass_get_enemy_side.sqf
		Author: Savage Game Design
		Public: No
		
	Description:
		Called from paradigm.
		Retrieves the side that should be used for a squad attacking a unit.
		
	Parameter(s):
		_side - Side of the unit that's being attacked [SIDE]
		_pos - Position of the unit that's being attacked [POS]
		
	Returns:
		Side the attackers should be on [SIDE]
		
	Example(s):
		N/A
*/
params ["_side", "_pos"];

//Naive implementation of this, as MF is entirely west, this is just for debugging purposes.
[east, independent, west, sideUnknown] select ([west, east, independent, civilian] find _side);