/*
    File: fn_crate_load.sqf
    Author: Ridderrasmus
    Public: No

    Description:
	    Loads the saved information about a crate.
		Don't manually use this. Is intended for use 
		with the full load function.

    Parameter(s):
        _crateData - Data known about the crate [ARRAY]

    Returns: nothing

    Example(s):
	    [["vn_somecrate_here", [[X, Y, Z], Dir], [Inventory data], configEntry]] call vn_mf_fnc_crate_load;
*/

params ["_crateData"];

// _crateData looks like this = [Classname, [Pos, Dir], Inventory data, Config entry]


_crateData params ["_className", "_loc", "_inv", "_config"];

_crate = createVehicle [_className, [0,0,0], [], 1, "NONE"];


_crate setPos (_loc select 0);
_crate setDir (_loc select 1);


[_crate, _inv] call vn_mf_fnc_inv_set_data;

[_crate, false] call para_s_fnc_allow_damage_persistent;


_crate setVariable ["supply_drop_config", _config, true];
_crate setMass ((getMass _crate) min 2500);
