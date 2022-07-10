/*
	File: fn_player_markers_update_positions.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
	    Updates the positions of all player markers.
	
	Parameter(s): none
	
	Returns: nothing
	
	Example(s):
	    call vn_mf_fnc_player_markers_update_positions
*/

{
	private _unitMarker = format ["player_marker_%1", getPlayerUID _x];
	_unitMarker setMarkerPosLocal getPos _x;
} forEach allPlayers;

{
	private _vehicleMarker = format ["player_marker_vehicle_%1", netId _x];
	_vehicleMarker setMarkerPosLocal getPos _x;
} forEach vn_mf_player_markers_manned_vehicles;