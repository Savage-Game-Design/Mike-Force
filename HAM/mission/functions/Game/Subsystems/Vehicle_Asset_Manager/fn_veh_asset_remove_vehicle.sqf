/*
    File: fn_veh_asset_remove_vehicle.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
		Removes a vehicle from the asset manager
    
    Parameter(s):
		_id - Id of the vehicle to remove [STRING]
    
    Returns:
		None
    
    Example(s):
		["myVehicleId"] call vn_mf_fnc_veh_asset_remove_vehicle;
*/
params ["_id"];

veh_asset_vehicle_ids deleteAt (veh_asset_vehicle_ids find _id);
missionNamespace setVariable [_id call vn_mf_fnc_veh_asset_key, nil];

//TODO - Remove "package wreck for transport" if wreck has it.
//Shouldn't be an issue with our use case... for now.