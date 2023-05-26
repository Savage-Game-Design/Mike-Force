/*
	File: fn_veh_asset_assign_vehicle_to_spawn_point.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Assigns a vehicle to the given spawn point

	Parameter(s):
		_spawnPoint - Spawn point the vehicle is assigned to [HashMap]
		_vehicle - Vehicle to initialise [Object]

	Returns: nothing

	Example(s): none
*/

params ["_spawnPoint", "_vehicle"];

_vehicle setVariable ["veh_asset_spawnPointId", _spawnPoint get "id", true];
_spawnPoint set ["lastClassSpawned", typeOf _vehicle];
[_spawnPoint, "currentVehicle", _vehicle] call vn_mf_fnc_veh_asset_set_global_variable;

[_vehicle] call vn_mf_fnc_veh_asset_add_unlock_action;
[_spawnPoint] call vn_mf_fnc_veh_asset_set_idle;

_vehicle addEventHandler ["RopeAttach", {[_this # 2] call vn_mf_fnc_veh_asset_unlock_vehicle}];

//Handle vehicle team locking
private _lockTeamArr = [];
private _lockTeamConfig = missionConfigFile >> "gamemode" >> "vehicle_lock_info" >> typeOf _vehicle;
if (isClass (_lockTeamConfig)) then {
	private _lockTeam = getText (_lockTeamConfig >> "lockTeam");
	if !(_lockTeam == "Unlocked") then {
		_lockTeamArr pushBack _lockTeam;
	};
};

[_vehicle, _lockTeamArr] call vn_mf_fnc_lock_vehicle_to_teams;
