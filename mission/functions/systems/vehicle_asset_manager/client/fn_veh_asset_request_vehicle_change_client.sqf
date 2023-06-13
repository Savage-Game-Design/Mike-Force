/*
    File: fn_veh_asset_request_vehicle_change_client.sqf
    Author: Spoffy
    Date: 2023-06-11
    Last Update: 2023-06-11
    Public: No
    
    Description:
        Requests to the change the vehicle on a given spawn point.
    
    Parameter(s):
        _spawnPointId - ID of the spawn point [STRING]
		_class - Class of the vehicle to change to [STRING]
    
    Returns:
		Nothing
    
    Example(s):
		["1", "vn_m151a1_mg_01"] call vn_mf_fnc_veh_asset_request_vehicle_change_client
*/

params ["_spawnPointId", "_class"];

private _spawnPoint = vn_mf_veh_asset_spawn_points_client get _spawnPointId;

if (isNil "_spawnPoint") exitWith { "" };

private _canChange = [_spawnPoint] call vn_mf_fnc_veh_asset_can_change_vehicle;

if (!_canChange) exitWith {
	[
		[
			"Cannot change vehicle",
			"Make sure the vehicle is idle, near to the spawn point and has no players in",
			"\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa",
			[0, 0, 0],
			[1, 0.3, 0.2]
		] 
	] call para_c_fnc_postNotification;
};

["change_spawn_point_vehicle", [_spawnPointId, _class]] call para_c_fnc_call_on_server;

