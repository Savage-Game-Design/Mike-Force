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



if (isServer) then {
	["SET", "veh_save_data", []] call para_s_fnc_profile_db;

	// Find all relevant vehicles
	_vehicleIDList = missionNamespace getVariable ["veh_asset_vehicle_ids", []];
	_allVehicles = [];
	{
		_veh = [_x] call vn_mf_fnc_veh_asset_get_by_id select struct_veh_asset_info_m_vehicle;
		_allVehicles pushBack _veh;
	} forEach _vehicleIDList;

	_vehicles = _allVehicles select {!(_x call vn_mf_fnc_area_check)};


	// Find all relevant supply crates
	private _supplyDropsConfig = (missionConfigFile >> "gamemode" >> "supplydrops");
	private _crateTypeArray = "true" configClasses _supplyDropsConfig apply {
  		getText (_x >> "className");
	};
	//_crateTypeArray = ["vn_b_ammobox_supply_05", "vn_us_komex_small_02", "vn_b_ammobox_supply_10", "vn_b_ammobox_supply_06", "vn_b_ammobox_supply_02", "vn_b_ammobox_supply_03", "vn_b_ammobox_supply_01"];
	
	_crates = entities [_crateTypeArray, [], false, true];
	_crates = _crates select {!(_x call vn_mf_fnc_area_check)};
	_crates = _crates select {!((_x getVariable ["supply_drop_config", ""]) isEqualTo "")};

	// Prepare empty save data variable
	_saveData = [];

	// Go through all vehicles and save them
	_vehsToSave = [];
	{
		_vehData = _x call vn_mf_fnc_veh_get_data;

		_vehsToSave pushBack _vehData;
	} forEach _vehicles;

	_saveData pushBack _vehsToSave;

	// Go through all crates and save them
	_cratesToSave = [];
	{ 
		_crateData [_x] call vn_mf_crate_save;

		_cratesToSave pushBack _crateData;
	} forEach _crates;

	_saveData pushBack _cratesToSave;

	
	// Save the save data
	["SET", "veh_save_data", _saveData] call para_s_fnc_profile_db;
	["SAVE"] call para_s_fnc_profile_db;

	"Save complete" remoteExec ["systemChat", 0];
};