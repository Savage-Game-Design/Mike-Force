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

if (vn_mf_vehicles_to_respawn isEqualTo []) exitWith {};

private _vehicle = vn_mf_vehicles_to_respawn deleteAt 0;
[_vehicle] spawn vn_mf_fnc_veh_asset_respawn;
