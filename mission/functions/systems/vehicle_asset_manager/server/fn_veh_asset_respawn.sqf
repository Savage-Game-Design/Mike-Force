/*
	File: fn_veh_asset_respawn.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Respawns the last spawned vehicle at the given spawnpoint.

	Parameter(s):
		_spawnPoint - Spawn point to respawn [HashMap]

	Returns: nothing

	Example(s): none
*/

params ["_spawnPoint"];

private _respawnType = _spawnPoint get "settings" get "respawnType";
private _respawnTime = _spawnPoint get "settings" get "time";
private _classToSpawn = _spawnPoint getOrDefault ["lastClassSpawned", _spawnpoint get "settings" get "vehicles" select 0];
private _spawnLocation = _spawnPoint getOrDefault ["nextSpawnLocationOverride", _spawnPoint get "spawnLocation"];

if (isNil "_classToSpawn") exitWith {};
if (!isClass (configFile >> "CfgVehicles" >> _classToSpawn)) exitWith {
	diag_log format ["VN MikeForce: [ERROR] Unable to respawn vehicle, class %1 is invalid", _classToSpawn];
};

private _vehicle = objNull;
private _oldVehicle = _spawnPoint getOrDefault ["currentVehicle", objNull];

_oldVehicle enableSimulationGlobal false;
deleteVehicle _oldVehicle;

sleep 1;

isNil { 
    _vehicle = [_classToSpawn, [0,0,1000], [], 0, "CAN_COLLIDE"] call para_g_fnc_create_vehicle;
	_vehicle enableSimulationGlobal false;

	private _position = _spawnLocation get "pos";
	if (_spawnLocation getOrDefault ["searchForEmptySpace", false]) then {
		private _newPosition = _position findEmptyPosition [0, 50, _classToSpawn];
		if (_newPosition isNotEqualTo []) then {
			_position = AGLtoASL _newPosition;
		};
	};

	_vehicle setVelocity [0,0,0];
	_vehicle setDir (_spawnLocation get "dir");
	_vehicle setPosASL _position;
	
	// Location override is only valid for 1 respawn.
	_spawnPoint deleteAt "nextSpawnLocationOverride";
	_vehicle enableSimulationGlobal true;
};

//This restores UAV drivers. Shouldn't need it in VN, but better safe than sorry.
if (getNumber (configfile >> "CfgVehicles" >> _classToSpawn >> "isUAV") > 0 && count crew _vehicle > 0) then {
	createVehicleCrew _vehicle;
};

[_spawnPoint, _vehicle] call vn_mf_fnc_veh_asset_assign_vehicle_to_spawn_point;

