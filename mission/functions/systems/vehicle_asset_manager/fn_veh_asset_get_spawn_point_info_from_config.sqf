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

_spawnPointInfo set ["respawnType", getText (_config >> "respawnType")];
_spawnPointInfo set ["time", getNumber (_config >> "time")];
_spawnPointInfo set ["vehicles", "true" configClasses (_config >> "vehicles") apply {configName _x}];

_spawnPointInfo