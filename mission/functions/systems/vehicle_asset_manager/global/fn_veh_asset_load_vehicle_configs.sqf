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
private _vehicles = _vehicleConfigs apply {
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