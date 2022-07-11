/*
    File: fn_changeteam.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Changes team.
		[!:warning] The `_player` variable is passsed from the parent scope!
		[!:warning] This function should not be called directly!
    
    Parameter(s):
		_group - Not used [Group]
    
    Returns: nothing
    
    Example(s): none
*/

params ["_group"];

[_player, _group] call vn_mf_fnc_change_team;