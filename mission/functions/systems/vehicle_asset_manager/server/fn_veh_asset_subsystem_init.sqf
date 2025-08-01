/*
	File: fn_veh_asset_subsystem_init.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Initialises the dynamic content subsystem.

	Parameter(s): none

	Returns: nothing

	Example(s): none
*/
params [["_lockIdleVehicleMarkers", []]];

// Map from unique ID to a hashmap describing the spawn point.
// Avoid double-init, as can be initialised by adding a spawn point in the `init` box in 3DEN.
if (isNil "vn_mf_veh_asset_spawn_points") then {
	vn_mf_veh_asset_spawn_points = createHashMap;
};

//Vehicles are marked as abandoned after 5 minutes.
vn_mf_veh_asset_abandonedTimer = 300;
//Vehicles must be X distance from spawn to be marked as abandoned
vn_mf_veh_asset_abandonedMinDistance = 20;
//Marker positions are updated every X seconds
vn_mf_veh_asset_markerUpdateDelay = 60;
vn_mf_veh_asset_markerLastUpdate = 0;
//Lock all vehicles that go idle
vn_mf_veh_asset_lock_all_idle_vehicles = true;
//Vehicles that go idle in one of these areas are locked (simulation disabled)
vn_mf_veh_asset_lock_idle_vehicle_markers = _lockIdleVehicleMarkers;
//Time to re-lock a vehicle
vn_mf_veh_asset_relock_time = 30;
//The maximum distance from the spawn point at which a vehicle can be changed for another vehicle type.
vn_mf_veh_asset_vehicle_change_max_distance = 10;
publicVariable "vn_mf_veh_asset_vehicle_change_max_distance";
//Vehicles to respawn var init
vn_mf_spawn_points_to_respawn = [];

["vehicle_asset_manager", vn_mf_fnc_veh_asset_job, [], 5] call para_g_fnc_scheduler_add_job;