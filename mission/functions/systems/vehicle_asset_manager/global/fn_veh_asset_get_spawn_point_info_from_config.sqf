/*
    File: fn_veh_asset_get_spawn_point_info_from_config.sqf
    Author: Spoffy
    Date: 2023-05-08
    Last Update: 2023-05-08
    Public: No
    
    Description:
	   	Retrieves spawn point settings from a config file.
    
    Parameter(s):
        _config - Config entry for the spawn point [Config]
    
    Returns:
	   	Spawn point info [HashMap]
    
    Example(s):
		[missionConfigFile >> "SpawnPointConfigs" >> "mySpawnPoint"] call vn_mf_fnc_veh_asset_get_spawn_point_info_from_config;
*/

params ["_config"];

private _spawnPointInfo = createHashMap;

_spawnPointInfo set ["name", getText (_config >> "name")];
_spawnPointInfo set ["respawnType", getText (_config >> "respawnType")];
_spawnPointInfo set ["time", getNumber (_config >> "time")];

private _vehicleConfigs = [] call vn_mf_fnc_veh_asset_load_vehicle_configs;
private _vehicles = [];
private _categories = [];

private _categoryConfigs = "true" configClasses (_config >> "categories");
{
    private _categoryConfig = _x;
    private _category = createHashMap;
    _categories pushBack _category;
    _category set ["name", getText (_categoryConfig >> "name")];
    _category set ["icon", getText (_categoryConfig >> "icon")];
    _category set ["include", getArray (_categoryConfig >> "include")];
    _category set ["exclude", getArray (_categoryConfig >> "exclude")];

    private _categoryVehicles = [];

    {
        private _requiredTags = _x;
        if !(_requiredTags isEqualType []) then {
            _requiredTags = [_requiredTags];
        };

        private _firstTag = _requiredTags # 0;
        private _possibleVehicles = (_vehicleConfigs get "vehiclesByTag" getOrDefault [_firstTag, []]);
        private _validVehicles = _possibleVehicles select { (_requiredTags - (_x get "tags")) isEqualTo [] };
        _categoryVehicles pushBack _validVehicles;
    } forEach (_category get "include");

    // Faster than using append or pushBack
    _categoryVehicles = flatten _categoryVehicles;

    {
        private _excludeTags = _x;
        if !(_excludeTags isEqualType []) then {
            _excludeTags = [_excludeTags];
        };

        _categoryVehicles = _categoryVehicles select {(_excludeTags - (_x get "tags")) isNotEqualTo []};
    } forEach (_category get "exclude");

    private _categoryVehicleClasses = _categoryVehicles apply {_x get "classname"};

    _category set ["vehicles", _categoryVehicles];
    _vehicles append (_categoryVehicleClasses);
} forEach _categoryConfigs;

_spawnPointInfo set ["categories", _categories];
_spawnPointInfo set ["vehicles", keys (_vehicles createHashMapFromArray [])];

_spawnPointInfo