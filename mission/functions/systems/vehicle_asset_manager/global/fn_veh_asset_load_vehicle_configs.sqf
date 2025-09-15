/*
	File: fn_veh_asset_load_vehicle_list.sqf
	Author: Spoffy
	Date: 2023-06-10
	Last Update: 2023-06-10
	Public: No
	
	Description:
		Loads the list of all vehicles from config
	
	Parameter(s):
		None
	
	Returns:
		Vehicle info in a few formats [HashMap]
	
	Example(s):
		[] call vn_mf_fnc_veh_asset_load_vehicle_list
*/

private _vehicleList = missionNamespace getVariable "vn_mf_veh_asset_vehicle_configs";

if !(isNil "_vehicleList") exitWith {
	_vehicleList
};

private _config = missionConfigFile >> "gamemode" >> "vehicle_respawn_info" >> "vehicles";
private _vehicleConfigs = "true" configClasses _config;


/*
check class is available in the mission (has the mod containing the vehicle class been loaded?)

example without nickel steel loaded:
21:45:36 "WARN: vn_mf_fnc_veh_asset_load_vehicle_configs: 6 vehicle classnames in 'vehicle_respawn_info' do not exist in 'CfgVehicles' (missing mod?)."
21:45:36 "WARN: vn_mf_fnc_veh_asset_load_vehicle_configs: classnames of vehicles missing in 'CfgVehicles': vnx_b_air_ac119_01_01 / vnx_b_air_ac119_02_01 / vnx_b_air_ac119_02_02 / vnx_b_air_ac119_03_01 / vnx_b_air_ac119_03_02 / vnx_b_air_ac119_04_01"
21:45:36 "INFO: vn_mf_fnc_veh_asset_load_vehicle_configs: 114 valid vehicle classes loaded."

*/

private _missingVehs = _vehicleConfigs select {!isClass (configFile >> "CfgVehicles" >> (configName _x))};
if (count _missingVehs > 0) then {
	// TODO: Simplify `para_g_fnc_log` and switch existing `diag_log format` calls over to it.
	diag_log format [
		"WARN: %1: %2 vehicle classnames in 'vehicle_respawn_info' do not exist in 'CfgVehicles' (missing mod?).",
		_fnc_scriptName,
		count _missingVehs
	];
	diag_log format [
		"WARN: %1: classnames of vehicles missing in 'CfgVehicles': %2",
		_fnc_scriptName,
		_missingVehs apply {configName _x} joinString "/"
	];
};

private _validVehs = _vehicleConfigs - _missingVehs;
diag_log format ["INFO: %1: %2 valid vehicle classes loaded.", _fnc_scriptName, count _validVehs];

private _vehicles = _validVehs apply {
	createHashMapFromArray [
		["classname", configName _x],
		["tags", getArray (_x >> 'tags')]
	]
};

private _vehiclesByTag = createHashMap;

_vehicles select { _x get "tags" isNotEqualTo [] } apply {
	private _vehicle = _x;
	{
		private _vehiclesForTag = _vehiclesByTag getOrDefault [_x, [], true];
		_vehiclesForTag pushBack _vehicle;
	} forEach (_x get "tags");
};

private _result = createHashMapFromArray [
	["vehicles", _vehicles],
	["vehiclesByTag", _vehiclesByTag]
];

missionNamespace setVariable ["vn_mf_veh_asset_vehicle_configs", _result];

_result