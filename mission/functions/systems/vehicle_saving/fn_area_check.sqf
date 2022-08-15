/*
    File: fn_area_check.sqf
    Author: Ridderrasmus
    Public: No

    Description:
	    Checks whether the object is in a main base area.

    Parameter(s):
        _obj - The object to check [OBJ]

    Returns: 
		true - The object is in a main base area.
		false - The object is not in a main base area.

    Example(s):
	    [TheBiggestTank] call vn_mf_fnc_area_check;
*/

params["_obj"];
private _inArea = false;

_inarea = vn_mf_markers_blocked_areas findIf {_obj inArea _x} > -1;

_inArea