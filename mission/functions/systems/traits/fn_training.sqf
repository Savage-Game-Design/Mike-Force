/*
    File: fn_training.sqf
    Author: Savage Game Design
    Public: No

    Description:
	    Enables/disables training.

    Parameter(s):
        _ - not used [STRING]
        _trait - trait name [STRING]

    Returns: nothing

    Example(s):
	    ["","engineer"] call vn_mf_fnc_training;
*/

params
[
	"",			// 0 : STRING - not used but passed from menu
	"_trait" 		// 1 : STRING - trait name
];

private _traits = ((missionConfigFile >> "gamemode" >> "traits")) call BIS_fnc_getCfgSubClasses;

private _index = _traits find _trait;

if (_index != -1) then
{
	["settrait", [_trait,_agent]] call para_c_fnc_call_on_server;
};
