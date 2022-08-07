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

_startLoad = _obj addAction ["Start load", {
	if (isServer) then {
		[] call vn_mf_fnc_full_load;
		[player, _this select 2] remoteExec ["removeAction", 0, true];
	};
}];

_obj addAction ["Save vehicles and crates", {
	[] call vn_mf_fnc_full_save;
}];