/*
    File: eh_InventoryOpened.sqf
    Author: Savage Game Design
    Public: No

    Description:
	    Inventory Opened Event Handler.

    Parameter(s):
        _unit - Description [DATATYPE, defaults to DEFAULTVALUE]
        _container - Description [DATATYPE, defaults to DEFAULTVALUE]

    Returns: nothing

    Example(s):
	    Not called directly.
*/

params
[
	"_unit",
	"_container"
];

// Initialize armor UI
["init",_this] spawn vn_mf_fnc_armor_calc;
