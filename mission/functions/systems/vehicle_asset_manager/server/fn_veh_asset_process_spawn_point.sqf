/*
    File: fn_veh_asset_process_spawn_point.sqf
    Author: Spoffy
    Date: 2023-05-14
    Last Update: 2023-05-14
    Public: No
    
    Description:
        Updates a spawn point, handling any state changes, marker updates, etc.

		Should be run periodically. By default is executed from fn_veh_asset_job.sqf
    
    Parameter(s):
        _spawnPoint - Spawn point to update [HashMap]
		_doMarkerUpdate - Should the vehicle's marker be updated [Boolean]
    
    Returns:
	   	Nothing
    
    Example(s):
		[_spawnPoint] call vn_mf_fnc_veh_asset_process_spawn_point;
*/

/*
Vehicle states:
["IDLE", _timeIdleBegan, _idleMarker] - Not currently in use
["ACTIVE"] - Vehicle is currently in use
["WRECKED", _positionOfWreck] - Vehicle is wrecked
["REPAIRING", _timeRepairFinishes] - Time vehicle repair began
["RESPAWNING", _timeToRespawnAt]
*/

//This is a separate function, so we can exit early with exitWith.
//This is basically a state machine for every vehicle.
//First it does state transitions, then handles the states.
params ["_spawnPoint", "_doMarkerUpdate"];

private _vehicle = _spawnPoint getOrDefault ["currentVehicle", objNull];
private _settings = _spawnPoint get "settings";
private _respawnType = _settings get "respawnType";

if(!alive _vehicle) then {
	[_vehicle] call vn_mf_fnc_veh_asset_unlock_vehicle;
};

//Vehicle is dead, and hasn't be transitioned to a "DEAD" state.
if (!alive _vehicle && !((_spawnPoint get "status" get "state") in ["RESPAWNING", "REPAIRING", "WRECKED"])) then {
	if (_respawnType == "WRECK") exitWith {
		[_spawnPoint] call vn_mf_fnc_veh_asset_set_wrecked;
	};

	if (_respawnType == "RESPAWN") exitWith {
		[_spawnPoint, _settings get "time"] call vn_mf_fnc_veh_asset_set_respawning;
	};
};

if (!canMove _vehicle) then {
	if ((_spawnPoint get "status" get "state") in ["ACTIVE", "IDLE"]) then {
		[_spawnPoint] call vn_mf_fnc_veh_asset_set_disabled;
	};
} else {
	if (crew _vehicle findIf {alive _x} > -1) then {
		//Active if we have crew in
		if ((_spawnPoint get "status" get "state") in ["IDLE", "DISABLED"]) then {
			[_spawnPoint] call vn_mf_fnc_veh_asset_set_active;
		};
	} else {
		//No alive crew in vehicle makes it IDLE
		if ((_spawnPoint get "status" get "state") in ["ACTIVE", "DISABLED"]) then {
			[_spawnPoint] call vn_mf_fnc_veh_asset_set_idle;
		};
	};
};

if ((_spawnPoint get "status" get "state") == "WRECKED") then {
	//If it's wrecked, but the object no longer exists, create a placeholder for it - so we don't make it unretrievable accidentally
	if (isNull _vehicle) then {
		// TODO - make this use the actual wreck if possible
		_vehicle = ["vn_wheeled_m54_01_wreck", ASLtoAGL (_spawnPoint get "status" get "posASL")] call para_g_fnc_create_vehicle;
		_vehicle setVariable ["veh_asset_spawnPointId", _spawnPoint get "id", true];
		[_spawnPoint, "currentVehicle", _vehicle] call vn_mf_fnc_veh_asset_set_global_variable;

		[_vehicle] call vn_mf_fnc_veh_asset_setup_package_wreck_action;
	};

	if (vn_mf_markers_wreck_recovery findIf {_vehicle inArea _x} > -1) exitWith {
		[_spawnPoint, _settings get "time"] call vn_mf_fnc_veh_asset_set_repairing;
	};

	// Only check this if we're still in the wreckeed state
	{
		private _vehicleDistance = _vehicle distance2D _x;
		private _recoveryBuildingPos = getPosASL _x;
		private _recoveryBuildingDir = getDir _x;

		if (_vehicleDistance <= 20) then
		{
			private _vehicleClass =_spawnPoint getOrDefault ["lastClassSpawned", _spawnpoint get "settings" get "vehicles" select 0];
			private _vehicleName = [configFile >> "CfgVehicles" >> _vehicleClass] call BIS_fnc_displayName;
			private _canRecover = [_x, _settings get "time", _vehicleName] call para_s_fnc_bf_wreck_recovery_availablity_check; //check if recovery building can recover.

			if(_canRecover) then 
			{
				_spawnPoint set ["nextSpawnLocationOverride", createHashMapFromArray [
					["pos", _recoveryBuildingPos],
					["dir", _recoveryBuildingDir],
					["searchForEmptySpace", true]
				]];
				[_spawnPoint, _settings get "time"] call vn_mf_fnc_veh_asset_set_repairing;
			};
		};
	} forEach para_s_bf_wreck_recovery_buildings;
};

//Place a marker if a vehicle has been idle too long
if ((_spawnPoint get "status" get "state") == "IDLE") then {
	private _timeSpentIdle = serverTime - (_spawnPoint get "status" get "lastChanged");
	//If vehicle went idle too long ago, and there's no abandoned marker set, and it's too far from respawn
	if (
		_timeSpentIdle > vn_mf_veh_asset_abandonedTimer
		&& _vehicle distance2D (_spawnPoint get "spawnLocation" get "pos") > vn_mf_veh_asset_abandonedMinDistance
	) then {
		if (_spawnPoint get "marker" == "") then {
			[_spawnPoint, "IDLE"] call vn_mf_fnc_veh_asset_marker_create;
		};
	};

	if (
		// vehicle isn't locked
		!(_vehicle getVariable ["vn_mf_g_veh_asset_locked", false]) &&
		// we've waited long enough since being idle
		_timeSpentIdle > vn_mf_veh_asset_relock_time &&
		{
			// we haven't just toggled the vehicle lock
			(serverTime - (_vehicle getVariable ["vn_mf_g_veh_asset_lock_last_toggled", 0])) > vn_mf_veh_asset_relock_time &&
			// we're near to a surface
			getPosATL _vehicle select 2 < 2 &&
			// have zero velocity
			vectorMagnitude velocity _vehicle < 1 &&
			//check that the vic is not slingloaded
			isNull ropeAttachedTo _vehicle &&
			// no crew
			crew _vehicle isEqualTo [] &&
			// vehicle is alive
			alive _vehicle &&
			// vehicle is in a valid place to lock
			{
				vn_mf_veh_asset_lock_all_idle_vehicles ||
				{ vn_mf_veh_asset_lock_idle_vehicle_markers findIf {_vehicle inArea _x} > -1 }
			}
		}
	) then {
		[_vehicle] call vn_mf_fnc_veh_asset_lock_vehicle;
	};
};

//Update marker position if it exists, and it's been too long.
if (_doMarkerUpdate && !((_spawnPoint get "status" get "state") in ["RESPAWNING", "REPAIRING"])) then {
	[_spawnPoint] call vn_mf_fnc_veh_asset_marker_update_position;
};

//Check if a vehicle should be respawned
if (
	(_spawnPoint get "status" get "state") in ["RESPAWNING", "REPAIRING"] && 
	{(_spawnPoint get "status" getOrDefault ["finishesAt", 0]) < serverTime}
) then {
	vn_mf_spawn_points_to_respawn pushBackUnique (_spawnPoint get "id");
};