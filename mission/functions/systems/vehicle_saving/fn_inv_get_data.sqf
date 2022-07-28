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

{
    _container = _x select 0;
    _containerItems = [_x select 1] call vn_mf_fnc_inv_get_data;

    _allContainers pushBack [_container, _containerItems];
} forEach _initialContainers;

_invData = [_items, _mags, _weapons, _backpacks, _allContainers];

return _invData;