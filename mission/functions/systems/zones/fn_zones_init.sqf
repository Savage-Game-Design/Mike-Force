/*
	File: fn_zone_init.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Loads and initialize zones.

	Parameter(s): none

	Returns: nothing

	Example(s):
		call vn_mf_fnc_zones_init;
*/

["Loading zone progress"] call BIS_fnc_log;

///////////////////
// Config Values //
///////////////////
mf_s_zone_garrison_size = 40;

//Minimum time before another attack can be launched, in seconds.
mf_s_max_attack_quantity = 1;
mf_s_min_attack_delay = 30 * 60;

mf_s_attack_base_prep_time = 300;
mf_s_attack_base_fail_delay = 30;
mf_s_attack_base_hold_duration = 900;
mf_s_attack_base_priority = 2;

mf_s_ongoing_attacks = [];
mf_s_last_attack = serverTime;

//All zone info
mf_s_zones = [];
//All zone names
mf_s_zone_markers = [];

[
	"zone",
	[
		"marker",
		["captured", {false}]
	]
] call para_g_fnc_create_struct;

{
	private _zoneData = [_x] call vn_mf_fnc_zones_load_zone;

	if (_zoneData select struct_zone_m_captured) then
	{
		_x setMarkerColor "ColorGreen";
		[_x, "zone_captured"] call para_c_fnc_zone_marker_add;
	}
	else
	{
		_x setMarkerColor "ColorRed";
		[_x, "zone_hostile"] call para_c_fnc_zone_marker_add;
	};

	mf_s_zones pushBack _zoneData;
	mf_s_zone_markers pushBack _x;
	localNamespace setVariable [_x, _zoneData];
} forEach vn_mf_markers_zones;

["Loading zone data"] call BIS_fnc_log;

vn_mf_completedZones = ["GET", "completed_zones", []] call para_s_fnc_profile_db select 1; publicVariable "vn_mf_completedZones";

["zone_manager", vn_mf_fnc_zones_manager_job, [], 30] call para_g_fnc_scheduler_add_job;

["Zone initialisation complete"] call BIS_fnc_log;
