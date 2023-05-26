/*
    File: fn_veh_asset_set_client_variable.sqf
    Author: Spoffy
    Date: 2023-05-26
    Last Update: 2023-05-26
    Public: No
    
    Description:
        Sets a variable on a spawn point object (clientside)
    
    Parameter(s):
        _spawnPointId - ID of the spawnpoint to set the variable on [String]
		_variable - Variable name to set [Any hashmap key]
		_value - Value to set variable to [Any]
    
    Returns:
	   	Nothing
    
    Example(s):
		["32", "currentVehicle", objNull] remoteExecCall ["vn_mf_fnc_veh_asset_set_variable_on_client", 0];
*/

params ["_spawnPointId", "_variable", "_value"];

private _spawnPointInfo = vn_mf_veh_asset_spawn_points_client get _spawnPointId;

if (isNil "_spawnPointInfo") exitWith {};

_spawnPointInfo set [_variable, _value];