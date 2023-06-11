/*
	File: fn_veh_asset_add_spawn_point.sqf
	Author: Savage Game Design
	Public: Yes

	Description:
		Adds a vehicle spawn point to the vehicle asset system.

	Parameter(s):
		_obj - Object to add the vehicle spawning actions to [Object]
		_spawnPointSettings - Spawn point config: either the full config as a hashmap, or the config name. [HashMap/String]
		_spawnLocation - Where to spawn new vehicles, array of [position, direction] [ARRAY]
		_textureSelection - Select to apply an editor preview texture to. Nil for no texture [NUMBER or STRING]

	Returns: 
		Spawn point info [HashMap]

	Example(s): 
		None
*/

if (!isServer) exitWith {};

params ["_obj", "_spawnPointSettings", "_spawnLocation", "_textureSelection"];

if (_obj getVariable ["veh_asset_isSpawnPoint", false]) exitWith {
	diag_log format ["VN MikeForce: [WARNING] Attempting to make object a vehicle spawn point twice: %1 at %2", typeOf _obj, getPos _obj];
};

if (_spawnPointSettings isEqualType "") then {
	_spawnPointSettings = [missionConfigFile >> "gamemode" >> "vehicle_respawn_info" >> "spawn_point_types" >> _spawnPointSettings] call vn_mf_fnc_veh_asset_get_spawn_point_info_from_config;
};

if (_spawnLocation isEqualType objNull) then {
	_spawnLocation = [getPosASL _spawnLocation, getDir _spawnLocation];
};

// This allows this function to be called even if the system isn't initialised yet.
if (isNil "vn_mf_veh_asset_spawn_points") then {
	vn_mf_veh_asset_spawn_points = createHashMap;
};

if (_spawnPointSettings getOrDefault ["respawnType", ""] isEqualTo "") then {
	diag_log format ["VN MikeForce: [WARNING] Spawn point info has no respawn type set, using defaults: %1 at %2", typeOf _obj, getPos _obj];
	_spawnPointSettings set ["respawnType", "RESPAWN"];
};

if (_spawnPointSettings getOrDefault ["time", ""] isEqualTo "") then {
	diag_log format ["VN MikeForce: [WARNING] Spawn point info has no respawn time set, using defaults: %1 at %2", typeOf _obj, getPos _obj];
	_spawnPointSettings set ["time", 10];
};

if !(isNil "_textureSelection" || _spawnPointSettings get "vehicles" isEqualTo []) then {
	private _image = getText (configFile >> "CfgVehicles" >> (_spawnPointSettings get "vehicles" select 0) >> "editorPreview");
	if (_image isNotEqualTo "") then {
		_obj setObjectTextureGlobal [
			_textureSelection,
			_image
		];
	};
};

if (isNil "_spawnLocation") exitWith {
	diag_log format ["VN MikeForce: [ERROR] Unable to create spawn point, no spawn location given: %1 at %2", typeOf _obj, getPos _obj];
};

private _id = [] call vn_mf_fnc_veh_asset_create_spawn_point_id;

// Simultaneously create the spawn point on the client and the server.
// Allows us to set variables on server + client at the same time.
private _spawnPoint = createHashMapFromArray [["id", _id]];

_spawnPoint set ["marker", ""];
_spawnPoint set ["spawnLocation", createHashMapFromArray [
	["pos", _spawnLocation # 0],
	["dir", _spawnLocation # 1],
	["searchForEmptySpace", false]
]];

// Start the spawn point with a random vehicle.
_spawnPoint set ["lastClassSpawned", selectRandom (_spawnPointSettings get "vehicles")];

[_spawnPoint, [
	["object", _obj],
	["settings", _spawnPointSettings],
	["currentVehicle", objNull],
	["status", createHashMapFromArray [
		["state", "IDLE"],
		["lastChanged", serverTime]
	]]
]] call vn_mf_fnc_veh_asset_set_global_variables;
// Spawn point will be setup on the client here, due to set_global_variables.

//lastClassSpawned is a spawn point variable, but shouldn't exist by default.
//nextSpawnLocationOverride is a spawn point variable, but shouldn't exist by default. It has the same structure as "spawnLocation"

_obj setVariable ["veh_asset_spawnPointId", _id, true];
vn_mf_veh_asset_spawn_points set [_spawnPoint get "id", _spawnPoint];

_spawnPoint