/*
	File: fn_veh_asset_package_wreck.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Packages a non-slingloadable wreck into a box for slingloading.

	Parameter(s):
		_vehicle - Vehicle to package [Object]

	Returns: nothing

	Example(s): none
*/

params ["_vehicle"];

private _spawnPointId = _vehicle getVariable "veh_asset_spawnPointId";
if (isNil "_spawnPointId") exitWith {};

private _spawnPoint = vn_mf_veh_asset_spawn_points get _spawnPointId;
if (isNil "_spawnPoint") exitWith {};

private _dir = getDir _vehicle;
private _pos = getPos _vehicle;

// Swap out the vehicle for a box before deleting the original vehicle.
private _box = ["vn_us_komex_medium_01", [0,0,0]] call para_g_fnc_create_vehicle;
_box setVariable ["veh_asset_spawnPointId", _spawnPointId, true];
[_spawnPoint, "currentVehicle", _box] call vn_mf_fnc_veh_asset_set_global_variable;
deleteVehicle _vehicle;

// Move the box to the vehicle's old position
_box setDir _dir;

if (_pos # 2 < 0) then {
	_pos = [_pos # 0, _pos # 1, 0.1];
};

private _emptyPos = _pos findEmptyPosition [0, 50, "vn_us_komex_medium_01"];

if (count _emptyPos == 0) then {
	_emptyPos = _pos isFlatEmpty [75, -1, -1, 1, -1];
	if (count _emptyPos == 0) then {
		_box setPos _pos;
	} else {
		_box setPos _emptyPos;
	};
} else {
	_box setPos _emptyPos;
};

_box allowDamage false;
_box setMass 2500; // temporary fix for the inability to lift this with AFM
_box setVelocity [0,0,0];

//Need to persist allowDamage on locality changes.
//Slingloaded items are very prone to locality changes.
[_box, false] call para_s_fnc_allow_damage_persistent;
//Clear out cargo
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
