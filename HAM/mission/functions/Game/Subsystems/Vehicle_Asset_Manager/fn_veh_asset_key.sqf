/*
    File: fn_veh_asset_key.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
		Produces the key used to store a vehicle with the given id.
    
    Parameter(s):
		_id - Vehicle id [STRING]
    
    Returns:
		Key associated with that vehicle [STRING]
    
    Example(s):
		["myId"] call vn_mf_fnc_veh_asset_key
*/
params ["_id"];

format ["veh_asset_vehicle_info_%1", _id]