/*
    File: fn_packageforslingloading.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Remote execution handler for packaging a vehicle asset.
    
    Parameter(s):
		_id - Id of the vehicle asset to package [String]
    
    Returns: nothing
    
    Example(s):
		["myVehicle"] call vn_mf_fnc_package_for_slingloading
*/

params ["_id", "_trigger"];

[_id, _trigger] call vn_mf_fnc_veh_asset_package_wreck;
