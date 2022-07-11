/*
	File: fn_override_crate_contents.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		overrides a crate's contents with the specified crate inventory from a config
	
	Parameter(s):
	_crate - the crate to fill
	_crateClass - the classname of the inventory in the crates.hpp config
	_clear - is this an addition or an overwrite?
	
	Returns: nothing
	
	Example(s):
		[_crate, "AmmoCrate"] call vn_mf_fnc_override_crate_contents
*/
params ["_crate", "_crateConfig", "_clear"];
private _crateConfigData = (missionConfigFile>> "gamemode" >>"crates" >> _crateConfig);
if (!isClass(_crateConfigData)) exitWith{};

if (_clear) then
{
	clearBackpackCargoGlobal _crate;
	clearItemCargoGlobal _crate;
	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;
};
{ _crate addMagazineCargoGlobal _x } forEach getArray(_crateConfigData>> "magazines");
{ _crate addWeaponCargoGlobal _x } forEach getArray(_crateConfigData>> "weapons");
{ _crate addItemCargoGlobal _x } forEach getArray(_crateConfigData>> "items");
{ _crate addBackpackCargoGlobal _x } forEach getArray(_crateConfigData>> "backpacks");
