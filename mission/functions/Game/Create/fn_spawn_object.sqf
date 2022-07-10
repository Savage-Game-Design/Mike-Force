/*
	File: fn_spawn_object.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Spawns object and loads related data.

	Parameter(s): none
	
	Returns: nothing
	
	Example(s):
		[_class, [["zone_ba_ria"], ["water"]] ,_configname] call vn_mf_fnc_spawn_object;
*/

//code
params ["_class", ["_randompos",[]], ["_configname",""]];

_pos = _randompos;
if !(_randompos isEqualTo []) then
{
	_pos = _randompos call BIS_fnc_randomPos;
};

_object = createVehicle [_class, _pos, [], 0, "NONE"];

missionNamespace setVariable [_configname, _object];
_object setVehicleVarName _configname;

_object
