/*
	File: fn_veh_asset_respawn_job.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Scheduler job that respawns vehicles based on respawn flag in vehicleInfo state data.

	Parameter(s): none

	Returns: nothing

	Example(s): none
*/

if (vn_mf_spawn_points_to_respawn isEqualTo []) exitWith {};

private _spawnPointId = vn_mf_spawn_points_to_respawn deleteAt 0;
private _spawnPoint = vn_mf_veh_asset_spawn_points get _spawnPointId;

if (isNil "_spawnPoint") exitWith {};

[_spawnPoint] spawn vn_mf_fnc_veh_asset_respawn;
