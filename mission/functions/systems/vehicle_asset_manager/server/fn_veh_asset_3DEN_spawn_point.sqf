/*
	File: fn_veh_asset_3DEN_spawn_point.sqf
	Author: Savage Game Design
	Public: Yes

	Description:
		Makes a 3DEN entity into a spawn point, using the synchronized objects.

		Workaround for being unable to sync two objects together in 3DEN without at least one being a unit.

		Should only be used in the `init` field in the 3DEN editor.

	Parameter(s):
		_spawnPointSettings - Spawn point config: either the full config as a hashmap, or the config name. [HashMap/String]
		_textureSelection - Selection to apply a the spawn point image texture to. Nil for no texture [NUMBER or STRING]

	Returns:
		Nothing

	Example(s):
		['civilian_cars'] call vn_mf_fnc_veh_asset_3DEN_spawn_point;
*/

params ["_spawnPointSettings", "_textureSelection"];

if (!isServer) exitWith {};

private _synchronizedObjects = synchronizedObjects this;
private _spawnLocationObject = objNull;

private _spawnObjectIndex = _synchronizedObjects findIf {_x isKindOf "Helper_Base_F"};
if (_spawnObjectIndex > -1) then {
	_spawnLocationObject = _synchronizedObjects select _spawnObjectIndex;
} else {
	_spawnLocationObject = this;
};

private _spawnPointObjects = _synchronizedObjects select {!(_x isKindOf "Helper_Base_F")};

[_spawnPointObjects select 0, _spawnPointSettings, _spawnLocationObject, _this param [1]] call vn_mf_fnc_veh_asset_add_spawn_point;

deleteVehicle this;
deleteVehicle _spawnLocationObject;