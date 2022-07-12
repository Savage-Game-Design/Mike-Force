/*
	File: fn_veh_asset_job.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Scheduler job that handles the vehicle asset state subsystem.
		NOTE: Actual respawn will be handled by the "veh_asset_respawner_job" in the scehduler so as to stop multiple vic respawning at the same time

	Parameter(s): none

	Returns: nothing

	Example(s): none
*/

/*
Vehicle states:
["IDLE", _timeIdleBegan, _idleMarker] - Not currently in use
["ACTIVE"] - Vehicle is currently in use
["WRECKED", _positionOfWreck] - Vehicle is wrecked
["REPAIRING", _timeRepairFinishes] - Time vehicle repair began
["RESPAWNING", _timeToRespawnAt]
*/

private _doMarkerUpdate = serverTime > (vn_mf_veh_asset_markerLastUpdate + vn_mf_veh_asset_markerUpdateDelay);
if (_doMarkerUpdate) then {
	vn_mf_veh_asset_markerLastUpdate = serverTime;
};

//This is a separate function, so we can exit early with exitWith.
//This is basically a state machine for every vehicle.
//First it does state transitions, then handles the states.
private _fnc_processVehicle = {
	params ["_id"];
	private _vehicleInfo = [_id] call vn_mf_fnc_veh_asset_get_by_id;
	private _vehicle = _vehicleInfo select struct_veh_asset_info_m_vehicle;
	_vehicleInfo select struct_veh_asset_info_m_respawn_info params ["_respawnType", "_respawnTime", "_positionOverride"];
	_vehicleInfo select struct_veh_asset_info_m_spawn_info params ["_type", "_dir", "_spawnPos", "_vars"];
	private _stateData = _vehicleInfo select struct_veh_asset_info_m_state_data;
	//Need this to be a function, as state can change at various points, and it always needs to be up to date.
	private _fnc_getState = {_vehicleInfo select struct_veh_asset_info_m_state_data};
	private _state = 0;

	if(!alive _vehicle) then {
        [_id] call vn_mf_fnc_veh_asset_unlock_vehicle;
	};

	//Vehicle is dead, and has no respawn type - remove it from the system.
	if (!alive _vehicle && _respawnType == "NONE") exitWith {
		[_id] call vn_mf_fnc_veh_asset_remove_vehicle;
	};

	//Vehicle is dead, and hasn't be transitioned to a "DEAD" state.
	if (!alive _vehicle && !((call _fnc_getState select _state) in ["RESPAWNING", "REPAIRING", "WRECKED"])) then {
		if (_respawnType == "WRECK") exitWith {
			[_id] call vn_mf_fnc_veh_asset_set_wrecked;
		};

		if (_respawnType == "RESPAWN") exitWith {
			[_id, _respawnTime] call vn_mf_fnc_veh_asset_set_respawning;
		};
	};

	if (!canMove _vehicle) then {
		if ((call _fnc_getState select _state) in ["ACTIVE", "IDLE"]) then {
			[_id] call vn_mf_fnc_veh_asset_set_disabled;
		};
	} else {
		if (crew _vehicle findIf {alive _x} > -1) then {
			//No alive crew in vehicle makes it IDLE
			if ((call _fnc_getState select _state) in ["IDLE", "DISABLED"]) then {
				[_id] call vn_mf_fnc_veh_asset_set_active;
			};
		} else {
			//Active if we have crew in
			if ((call _fnc_getState select _state) in ["ACTIVE", "DISABLED"]) then {
				[_id] call vn_mf_fnc_veh_asset_set_idle;
			};
		};
	};

	if ((call _fnc_getState select _state) == "WRECKED") then {
		//If it's wrecked, but the object no longer exists, create a placeholder for it - so we don't make it unretrievable accidentally
		if (isNull _vehicle) then {
			_vehicle = ["vn_wheeled_m54_01_wreck", ASLtoAGL (_stateData select 1)] call para_g_fnc_create_vehicle;
			_vehicleInfo set [struct_veh_asset_info_m_vehicle, _vehicle];

			[_id] call vn_mf_fnc_veh_asset_setup_package_wreck_action;
		};

		if (vn_mf_markers_wreck_recovery findIf {_vehicle inArea _x} > -1) then {
			[_id, _respawnTime] call vn_mf_fnc_veh_asset_set_repairing;
		};

		{
			if ((call _fnc_getState select _state) == "REPAIRING") then { continue }; //don't recover repairing vehicles.

			private _vehicleDistance = _vehicle distance2D _x;
			private _recoveryBuildingPos = getPosWorld _x;

			if (_vehicleDistance <= 20) then
			{
				private _vehicleName = [configFile >> "CfgVehicles" >> _type] call BIS_fnc_displayName;
				private _canRecover = [_x, _respawnTime, _vehicleName] call para_s_fnc_bf_wreck_recovery_availablity_check; //check if recovery building can recover.

				if(_canRecover) then 
				{
					_vehicleInfo set [struct_veh_asset_info_m_respawn_info, [_respawnType, _respawnTime, _recoveryBuildingPos]];
					[_id, _respawnTime] call vn_mf_fnc_veh_asset_set_repairing;
				};
			};
		} forEach para_s_bf_wreck_recovery_buildings;
	};

	//Place a marker if a vehicle has been idle too long
	if ((call _fnc_getState select _state) == "IDLE") then {
		//If vehicle went idle too long ago, and there's no abandoned marker set, and it's too far from respawn
		if (
			serverTime - (call _fnc_getState select 1) > vn_mf_veh_asset_abandonedTimer
			&& _vehicle distance2D _spawnPos > vn_mf_veh_asset_abandonedMinDistance
		) then {
			private _marker = _vehicleInfo select struct_veh_asset_info_m_marker;
			if (_marker == "") then {
				[_id, "IDLE"] call vn_mf_fnc_veh_asset_marker_create;
			};
		};

		if (
			// vehicle isn't locked
			!(_vehicle getVariable ["vn_mf_g_veh_asset_locked", false]) &&
			// we've waited long enough since being idle
			(serverTime - (call _fnc_getState select 1)) > vn_mf_veh_asset_relock_time &&
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
		) then {
			[_id] call vn_mf_fnc_veh_asset_lock_vehicle;
		};
	};

	//Update lock status, if a vehicle was unlocked but left idle

	//Update marker position if it exists, and it's been too long.
	if (_doMarkerUpdate && !((call _fnc_getState select _state) in ["RESPAWNING", "REPAIRING"])) then {
		[_id] call vn_mf_fnc_veh_asset_marker_update_position;
	};

	//Check if a vehicle should be respawned
	if ((call _fnc_getState select _state) in ["RESPAWNING", "REPAIRING"] && {(call _fnc_getState select 1) < serverTime}) then {
		vn_mf_vehicles_to_respawn pushBackUnique _id;
	};
};

{
	[_x] call _fnc_processVehicle;
} forEach veh_asset_vehicle_ids;
