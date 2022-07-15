/*
	File: fn_veh_asset_package_wreck.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Packages a non-slingloadable wreck into a box for slingloading.

	Parameter(s):
		_id - Id of the wrecked vehicle [Number]

	Returns: nothing

	Example(s): none
*/

params ["_id", ["_trigger", objNull]];

private _vehicleInfo = [_id] call vn_mf_fnc_veh_asset_get_by_id;
private _vehicle = _vehicleInfo select struct_veh_asset_info_m_vehicle;
private _dir = getDir _vehicle;
private _pos = getPos _vehicle;
private _actionsArray = _trigger getVariable ["vn_mf_veh_asset_trigger_action_array", false];
diag_log format ["Package Wreck Trigger: %1, Actions: %2", _trigger, _actionsArray];
deleteVehicle _vehicle;
deleteVehicle _trigger;



//Replace the vehicle with a box
private _box = ["vn_us_komex_medium_01", [0,0,0]] call para_g_fnc_create_vehicle;
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

_vehicleInfo set [struct_veh_asset_info_m_vehicle, _box];
_box setVariable ['vehAssetId', _id];

if (_actionsArray isEqualType []) then {
	{
		private _playerVehicle = _x # 0;
		private _triggerAddAction = _x # 1;
		_playerVehicle removeAction _triggerAddAction;
	} forEach _actionsArray;
};

//Clear out cargo
clearBackpackCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;
clearMagazineCargoGlobal _box;
