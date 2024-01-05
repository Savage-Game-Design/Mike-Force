/*
    File: fn_crate_load.sqf
    Author: Ridderrasmus
    Public: No

    Description:
	    Saves information about a crate

    Parameter(s):
        _crate - Crate to save [OBJECT]

    Returns: 
		    _crateData - Data known about the crate [ARRAY]

    Example(s):
	    [crate] call vn_mf_fnc_crate_save;
*/

params ["_crate"];

// _crateData looks like this = [Classname, [Pos, Dir], Inventory data, Config entry]


_crateClassName = typeOf _crate;
_crateLoc = [getPos _crate, getDir _crate];

_crateInv = [_crate] call vn_mf_fnc_inv_get_data;

_crateDropConfig = _crate getVariable "supply_drop_config";
_crate setMass ((getMass _crate) min 2500);

_crateData = [_crateClassName, _crateLoc, _crateInv, _crateDropConfig];

_crateData