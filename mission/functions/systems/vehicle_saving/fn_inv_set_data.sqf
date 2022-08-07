/*
    File: fn_inv_get_data.sqf
    Author: Ridderrasmus
    Public: No

    Description:
	    Sets iventory of vehicle or crate

    Parameter(s):
		_obj - Object to set inventory of [OBJECT]
        _data - All the data to set inventory to [ARRAY]

    Returns: nothing

    Example(s):
	    [object, blah blah data] call vn_mf_fnc_inv_set_data;
*/

params [
	["_obj", objNull, [objNull]], 
	["_data", [], [[]]]
];

_data params ["_items", "_mags", "_weapons", "_backpacks", "_containers"];



clearMagazineCargo _obj;
clearWeaponCargo _obj;
clearItemCargo _obj;
clearBackpackCargo _obj;

{
	_obj addItemCargoGlobal [_x, 1];
} forEach _items;
{
	_obj addMagazineAmmoCargo [_x select 0, 1, _x select 1];	
} forEach _mags;
{
	_obj addWeaponWithAttachmentsCargoGlobal [_x, 1];
} forEach _weapons;
{
	_obj addBackpackCargoGlobal [_x, 1];
} forEach _backpacks;




// Find the empty containers in the inventory and then for each container data entry add the inventory to the matching container
_emptyContainers = everyContainer _obj;

if (count _emptyContainers > 0) then {
	{
		
		_containerClassName = _x select 0;
		_containerData = _x select 1;

		_emptyContainersEntry = (_emptyContainers select {(_x select 0) == _containerClassName}) select 0;
		_container = _emptyContainersEntry select 1;

		_cargoItems = _containerData select 0;
		_cargoMags = _containerData select 1;
		_cargoWeapons = _containerData select 2;
		_cargoBackpacks = _containerData select 3;


		{
			_container addItemCargoGlobal [_x, 1];
		} forEach _cargoItems;
		{
			_container addMagazineAmmoCargo [_x select 0, 1, _x select 1];	
		} forEach _cargoMags;
		{
			_container addWeaponWithAttachmentsCargoGlobal [_x, 1];
		} forEach _cargoWeapons;
		{
			_container addBackpackCargoGlobal [_x, 1];
		} forEach _cargoBackpacks;

		_emptyContainers = _emptyContainers - _emptyContainersEntry;
	} forEach _containers;
};