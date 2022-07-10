/*
	File: fn_check_enemy_units_alive.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
    	Checks if enemy are alive within area

	Parameter(s):
    	marker name, location, trigger or [center, a, b, angle, isRectangle, c] [String|Array]
	
	Returns:
    	True if no enemy left alive in area [Boolean]

	Example(s):
    	['marker_7'] call vn_mf_fnc_check_enemy_units_alive;
*/

params [
	"_marker" // 0: STRING or ARRAY - marker name, location, trigger or [center, a, b, angle, isRectangle, c]
];
(allUnits inAreaArray _marker) select {alive _x && side _x == east} isEqualTo []
