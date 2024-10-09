/*
    File: fn_inv_get_data.sqf
    Author: Ridderrasmus
    Public: No

    Description:
	    Gets info from an inventory

    Parameter(s):
        _obj - Object to get info from [OBJECT]

    Returns: 
        _data - Array with info [ARRAY]

    Example(s):
	    [MyCargoTruck] call vn_mf_fnc_inv_get_data;
*/

params [
    ["_obj", objNull, [objNull]]
];

_invData = [];


_items = itemCargo _obj;
_mags = magazinesAmmoCargo _obj;
_weapons = weaponsItemsCargo _obj;
_backpacks = backpackCargo _obj;

_initialContainers = everyContainer _obj;
_allContainers = [];

if (count _initialContainers > 0) then {
    {
        _data = [itemCargo (_x select 1), magazinesAmmoCargo (_x select 1), weaponsItemsCargo (_x select 1), backpackCargo (_x select 1)];
        _allContainers pushBack [_x select 0, _data];
    } forEach _initialContainers;
};

_invData = [_items, _mags, _weapons, _backpacks, _allContainers];

_invData