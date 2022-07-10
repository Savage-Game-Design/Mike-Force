/*
    File: eh_Put.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Put Event Handler.

    Parameter(s):
		_unit - Player [OBJECT, defaults to DEFAULTVALUE]
		_container - Weaponholder [OBJECT, defaults to DEFAULTVALUE]
		_item - Item class [STRING, defaults to DEFAULTVALUE]

    Returns: nothing

    Example(s):
		Not called directly.
*/
params
[
	"_unit",
	"_container", 
	"_item"
];

// refresh armor calculation for Inventory UI.
["refresh"] call vn_mf_fnc_armor_calc;

// store dropped weaponholders
if !(alive player) then
{
	_weaponholders = player getVariable ["vn_mf_dyn_weaponholders",[]];
	_weaponholders pushBack _container;
	// TODO optimize
	player setVariable ["vn_mf_dyn_weaponholders", _weaponholders, true];
};
