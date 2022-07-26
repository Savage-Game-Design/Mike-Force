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
	    [["vn_somecrate_here", [[X, Y, Z], Dir], [Magazines], [Weapons], [Items], configEntry]] call vn_mf_fnc_crate_load;
*/

params ["_crateData"];

// _crateData looks like this = [Classname, [Pos, Dir], Magazines, Weapons, Items, Config entry]
// Yet again don't tell infantry that weapon accessories aren't saved yet


_crateData params ["_className", "_loc", "_mags", "_weapons", "_items", "_backpacks", "_config"];
_crate = createVehicle [_className, [0,0,0], [], 1, "NONE"];
_crate setPos (_loc select 0);
_crate setDir (_loc select 1);

{
	_crate addMagazineAmmoCargo [_x select 0, 1, _x select 1];	
} forEach _mags;
{
	_crate addWeaponCargo [_x, 1];
} forEach _weapons;
{
	_crate addItemCargo [_x, 1];
} forEach _items;
{
	_crate addBackpackCargo [_x, 1];
} forEach _backpacks;
_crate setVariable ["supply_drop_config", _config, true];
_crate setMass ((getMass _crate) min 2500);
