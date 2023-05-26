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

private _doMarkerUpdate = serverTime > (vn_mf_veh_asset_markerLastUpdate + vn_mf_veh_asset_markerUpdateDelay);
if (_doMarkerUpdate) then {
	vn_mf_veh_asset_markerLastUpdate = serverTime;
};

{
	private _id = _x;
	private _spawnInfo = _y;
	[_spawnInfo, _doMarkerUpdate] call vn_mf_fnc_veh_asset_process_spawn_point;
} forEach vn_mf_veh_asset_spawn_points;
