/*
	File: fn_player_markers_subsystem_init.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
	    Initialises the player marker subsystem. This subsystem puts markers on each player on the map, as appropriate.
	    This subsystem runs *locally*, and should run once on each client.
	
	Parameter(s): none
	
	Returns: nothing
	
	Example(s):
	    call vn_mf_fnc_player_marker_subsystem_init
*/

vn_mf_player_markers = [];
vn_mf_player_markers_manned_vehicles = [];
vn_mf_player_markers_vehicle_markers = [];

vn_mf_player_markers_marker_management_loop = [] spawn {
	while {isNil "abortMarkerManagement"} do {
		call vn_mf_fnc_player_markers_job;
		uisleep 2;
	};
};
vn_mf_player_markers_eachFrame_handler = addMissionEventHandler ["EachFrame", vn_mf_fnc_player_markers_update_positions];