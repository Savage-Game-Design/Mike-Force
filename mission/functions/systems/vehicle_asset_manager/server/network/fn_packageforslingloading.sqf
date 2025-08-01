/*
    File: fn_packageforslingloading.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Remote execution handler for packaging a vehicle asset.
    
    Parameter(s):
        _vehicle - Vehicle asset to package [Object]
    
    Returns: nothing
    
    Example(s):
        ["myVehicle"] call vn_mf_fnc_package_for_slingloading
*/

params ["_vehicle"];

[_vehicle] call vn_mf_fnc_veh_asset_package_wreck;
