/*
    File: fn_add_save_load_actions.sqf
    Author: Ridderrasmus
    Public: No

    Description:
	    This function adds save and load actions 
		to the object given as the parameter.

    Parameter(s):
        _obj - The object to add the save and load actions to [OBJ]

    Returns: nothing

    Example(s):
	    [flagpole] call vn_mf_fnc_add_save_load_actions;
*/

params ["_obj"];

{
	if (!hasInterface) exitWith {};
	_startLoad = _obj addAction ["Start load", {
			[] remoteExec ["vn_mf_fnc_full_load", 2];
			player removeAction _this select 2;
	}];

	_obj addAction ["Save vehicles and crates", {
		[] remoteExec ["vn_mf_fnc_full_save", 2];
	}];
} remoteExec ["call", 0, true];