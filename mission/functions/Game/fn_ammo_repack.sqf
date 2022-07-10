/*
	File: fn_ammo_repack.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Simple Ammo repack

	Parameter(s): none
	
	Returns: nothing
	
	Example(s):
		call vn_mf_fnc_ammo_repack;
*/

private ["_interactedItem","_item","_magazineSize","_magazineSizeMax","_magazinesAmmoFull"];

_item = "";
_interactedItem = uiNamespace getVariable ["vn_mf_interacted_item",[]];
if !(_interactedItem isEqualTo []) then {
	_item = _interactedItem select 1;
};
_magazineSizeMax = getNumber (configfile >> "CfgMagazines" >> _item >> "count");
// allow repack for all magazines with greater than 1 bullet
if (_magazineSizeMax > 1) then
{
	_magazineSize = 0;
	_magazinesAmmoFull = magazinesAmmoFull player;
	{
		if (_item isEqualTo (_x select 0)) then
	{
			if (!(_x select 2)) then
		{
				_magazineSize = _magazineSize + (_x select 1);
			};
		};
	} forEach _magazinesAmmoFull;

	// remove all
	player removeMagazines _item;

	// Add full magazines back to player
	for "_i" from 1 to floor (_magazineSize / _magazineSizeMax) do
	{
		player addMagazine [_item, _magazineSizeMax];
	};
	// Add last non full magazine
	if ((_magazineSize % _magazineSizeMax) > 0) then
	{
		player addMagazine [_item, floor (_magazineSize % _magazineSizeMax)];
	};
	hint "Ammo Repacked";
};
