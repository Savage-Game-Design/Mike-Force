/*
	File: fn_veh_asset_add_vehicle.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Adds a vehicle to the respawn system.

	Parameter(s):
		_veh - Vehicle in its starting location to add to the repsawn subsystem [Object]
		_id - ID to give the vehicle [Number]
		_respawnType - "RESPAWN" for respawn behaviour, "WRECK" for wreck behaviour [String]
		_time - Time to respawn or time to repair, depending on if type is "RESPAWN" or "WRECK" [Number]

	Returns: nothing

	Example(s): none
*/

if (!isServer) exitWith {};

params ["_veh", "_id", ["_respawnType", ""], ["_time", -1]];

//Make sure our global id array is ready for use
if (isNil "veh_asset_vehicle_ids") then {
	veh_asset_vehicle_ids = [];
};

//Attempt to get parameters if none provided
if (_respawnType ==	"" || _time < 0) then {
	private _config = missionConfigFile >> "gamemode" >> "vehicle_respawn_info" >> typeOf _veh;
	if (isClass (_config)) then {
		_respawnType = getText (_config >> "RespawnType");
		_time = getNumber (_config >> "Time");
	};
};

if (_respawnType == "" || _time < 0) then {
	diag_log format ["VN MikeForce: [WARNING] Vehicle of type '%1' has no respawn config, using defaults", typeOf _veh];
	_respawnType = "NONE";
	_time = 0;
};

//Prevent re-adding the same vehicle. It's a risk if add_vehicle is called from 'init'
if (_id in veh_asset_vehicle_ids) exitWith {};

veh_asset_vehicle_ids pushBack _id;

//Save variables so we can restore them later.
private _initialVariables = [];
{
	_initialVariables pushBack [_x, _veh getVariable _x];
} forEach allVariables _veh;

//Create a new vehicle info struct.
private _vehicleInfo = call struct_veh_asset_info_fnc_create;

//Record info about the respawn position of the vehicle
private _vectorDirUp = [vectorDir _veh, vectorUp _veh];
_vehicleInfo set [
	struct_veh_asset_info_m_spawn_info,
	[typeOf _veh, _vectorDirUp, getPosWorld _veh, _initialVariables]
];

_vehicleInfo set [
	struct_veh_asset_info_m_respawn_info,
	[_respawnType, _time, [0,0,0]]
];

_vehicleInfo set [
	struct_veh_asset_info_m_vehicle,
	_veh
];

missionNamespace setVariable [_id call vn_mf_fnc_veh_asset_key, _vehicleInfo];

[_id, _veh, true] call vn_mf_fnc_veh_asset_init_vehicle;