/*
    File: fn_detect_missing_arsenal_magazines.sqf
    Author: Savage Game Design
    Public: Yes

    Description:
		Scans the arsenal config and looks for weapons that have no configured magazines.

    Parameter(s): none

    Returns: nothing

    Example(s):
		[] call vn_mf_fnc_detect_missing_arsenal_magazines
*/

private _arsenalConfig = missionConfigFile >> "vn_whitelisted_arsenal_loadouts" >> "vn_mikeforce";
private _arsenalWeaponClasses = getArray (_arsenalConfig >> "weapons") apply {_x # 0};
private _arsenalMagClasses = getArray (_arsenalConfig >> "magazines") apply {_x # 0};

private _weaponMagazines = createHashMap;

private _fnc_allMagazinesForWeapon = {
	params ["_weaponClass"];

	private _immediateMagazines = getArray (configFile >> "CfgWeapons" >> _x >> "magazines");
	private _wellMagazines = flatten (
		getArray (configFile >> "CfgWeapons" >> _x >> "magazineWell") apply {
			flatten (configProperties [configFile >> "CfgMagazineWells" >> _x, "isArray _x"] apply {getArray _x})
		}
	);

	_immediateMagazines + _wellMagazines;
};

private _fnc_weaponHasMagazinesInArsenal = {
	params ["_weaponClass"];
	private _magazines = _weaponClass call _fnc_allMagazinesForWeapon;

	count _magazines > 0 && count (_magazines arrayIntersect _arsenalMagClasses) > 0
};

_arsenalWeaponClasses select {!(_x call _fnc_weaponHasMagazinesInArsenal)}