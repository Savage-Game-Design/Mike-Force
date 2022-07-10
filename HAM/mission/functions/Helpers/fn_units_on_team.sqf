/*
    File: fn_units_on_team.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Returns an array of all the units on a given team
    
    Parameter(s):
        _this - Team name [String]
    
    Returns:
        Array of units on a team [Array]
    
    Example(s):
        "SpikeTeam" call vn_mf_fnc_units_on_team;
*/

missionNamespace getVariable [_this, []]
