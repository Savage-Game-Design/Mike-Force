/*
    File: fn_veh_asset_describe_status.sqf
    Author: Spoffy
    Date: 2023-05-26
    Last Update: 2023-05-26
    Public: No
    
    Description:
        Creates a text description of a spawnpoint's current status.
    
    Parameter(s):
	   	_spawnPointId - ID of the spawnpoint whose status should be described [HashMap]
    
    Returns:
	   	Description of the spawnpoint [String]
    
    Example(s):
		["32"] call vn_mf_fnc_veh_#sset_describe_status;
*/

params ["_spawnPointId"];

private _spawnPoint = vn_mf_veh_asset_spawn_points_client get _spawnPointId;

if (isNil "_spawnPoint") exitWith { "" };

private _vehicle = _spawnPoint getOrDefault ["currentVehicle", objNull];
private _vehicleType = typeOf _vehicle;
private _vehicleName = getText (configFile >> "CfgVehicles" >> _vehicleType >> "displayName");

private _status = _spawnPoint getOrDefault ["status", createHashMap];
private _state = _status getOrDefault ["state", "UNKNOWN"];

private _fnc_getTimeRemaining = {
	private _endTime = _status getOrDefault ["finishesAt", 0];
	private _timeRemaining = (_endTime - serverTime) max 0;
	private _minutes = floor (_timeRemaining / 60);
	private _seconds = floor (_timeRemaining - (_minutes * 60));
	if (_minutes > 0) exitWith {
		format ["%1 minutes", _minutes];
	};
	
	format ["%1 seconds", _seconds];
};

if (_state isEqualTo "IDLE") exitWith {
	format ["%1 is currently deployed and not in use.", _vehicleName]
};

if (_state isEqualTo "REPAIRING") exitWith {
	format ["The vehicle is currently being repaired, and will be finished in %1.", call _fnc_getTimeRemaining];
};

if (_state isEqualTo "RESPAWNING") exitWith {
	format ["The vehicle is currently respawning, and will be finished in %1.", call _fnc_getTimeRemaining];
};

if (_state isEqualTo "WRECKED") exitWith {
	format ["The %1 is currently wrecked. The wreck needs bringing to a wreck recovery point at the main base or a FOB.", _vehicleName];
};

if (_state isEqualTo "DISABLED") exitWith {
	format ["The %1 is currently deployed. However, it's disabled and needs repairs from an engineer.", _vehicleName];
};

if (_state isEqualTo "ACTIVE") exitWith {
	format ["The %1 is currently deployed and in use.", _vehicleName];
};


"The current state of this spawn point is unknown."