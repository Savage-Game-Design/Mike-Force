/*
    File: fn_full_save.sqf
    Author: Ridderrasmus
    Public: No

    Description:
	    Starts saving all vehicles and crates.

    Parameter(s):
		NONE

    Returns: nothing

    Example(s):
	    [] call vn_mf_fnc_full_save;
*/


// Fuck me I need to be better about comments
// Plus the crates save should probably also be structured a bit more like the vehicles for consistency


if (isServer) then {
	["SET", "veh_save_data", []] call para_s_fnc_profile_db;

	// Vehicles
	_vehicleIDList = missionNamespace getVariable ["veh_asset_vehicle_ids", []];
	_allVehicles = [];
	{
		_veh = [_x] call vn_mf_fnc_veh_asset_get_by_id select struct_veh_asset_info_m_vehicle;
		_allVehicles pushBack _veh;
	} forEach _vehicleIDList;

	_vehicles = _allVehicles select {!(_x call vn_mf_fnc_area_check)};


	// Supply crates
	private _supplyDropsConfig = (missionConfigFile >> "gamemode" >> "supplydrops");
	private _crateTypeArray = "true" configClasses _supplyDropsConfig apply {
  		getText (_x >> "className");
	};
	//_crateTypeArray = ["vn_b_ammobox_supply_05", "vn_us_komex_small_02", "vn_b_ammobox_supply_10", "vn_b_ammobox_supply_06", "vn_b_ammobox_supply_02", "vn_b_ammobox_supply_03", "vn_b_ammobox_supply_01"];
	
	_crates = entities [_crateTypeArray, [], false, true];
	_crates = _crates select {!(_x call vn_mf_fnc_area_check)};
	_crates = _crates select {!((_x getVariable ["supply_drop_config", ""]) isEqualTo "")};


	_saveData = [];

	_vehsToSave = [];
	{
		_vehsToSave append [_x call vn_mf_fnc_veh_get_data];
	} forEach _vehicles;

	_saveData pushBack _vehsToSave;

	_cratesToSave = [];
	{ // [Classname, [Pos, Dir], Magazines, Weapons, Items, Config entry] (Currently doesn't support weapon attachments being saved SHHH don't tell the infantry)
		_crateClassName = typeOf _x;
		_crateLoc = [getPos _x, getDir _x];
		_crateMagazines = magazinesAmmoCargo _x;
		_crateWeapons = weaponCargo _x;
		_crateItems = itemCargo _x;
		_crateBackpacks = backpackCargo _x;
		_crateDropConfig = _x getVariable "supply_drop_config";

		_cratesToSave pushBack [_crateClassName, _crateLoc, _crateMagazines, _crateWeapons, _crateItems, _crateBackpacks, _crateDropConfig];
	} forEach _crates;

	_saveData pushBack _cratesToSave;

	

	["SET", "veh_save_data", _saveData] call para_s_fnc_profile_db;
	["SAVE"] call para_s_fnc_profile_db;

	"Save complete" remoteExec ["systemChat", 0];
};