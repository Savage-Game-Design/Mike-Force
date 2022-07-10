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

//Create the struct we use to store vehicle data.
//Makes it easier to clean up.
[
	"veh_asset_info",
	[
		"vehicle",
		"spawn_info",
		//Default to not respawning
		["respawn_info", {["NONE", 0, [0,0,0]]}],
		//Starts in IDLE state.
		["state_data", {["IDLE", 0]}],
		//No initial marker
		["marker", {""}]
	]
] call para_g_fnc_create_struct;

//Unique identifier for every vehicle registered with the respawn system.
if (isNil "veh_asset_vehicle_ids") then {
	veh_asset_vehicle_ids = [];
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
//Vehicles to respawn var init
vn_mf_vehicles_to_respawn = [];


private _vehiclesToAdd = synchronizedObjects vn_mf_veh_asset_logic;
private _count = 1;
{
	[_x, format ["%1-%2", typeOf _x, _count]] call vn_mf_fnc_veh_asset_add_vehicle;
	_count = _count + 1;
} forEach _vehiclesToAdd;

["vehicle_asset_manager", vn_mf_fnc_veh_asset_job, [], 5] call para_g_fnc_scheduler_add_job;

