/*
    File: fn_task_sec_combat_air_patrol.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Patrol area for enemy aircraft and destroy them task.

    Parameter(s):
		_dataStore - Namespace for storing state machine info [Object]

    Returns: nothing

    Example(s):
        Not directly called.
*/

/*
 * Task Parameters:
 *    None
 * Subtask Parameters:
 *    None
 * Runtime Parameters:
 *    pos - Position through which the hostile aircraft should fly
 */

params ["_dataStore"];

_dataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _taskConfig = _taskDataStore getVariable "taskConfig";
	private _zonePosition = getMarkerPos (_taskDataStore getVariable "taskMarker");

	//This shouldn't be hardcoded. But we're choosing a direction between 270 and 380 degrees to avoid spawning it closer to base than the AO.
	//Only works on Cam Lao Nam as a result.
	//Distance of 1000, because why not
	private _patrolPosition = _taskDataStore getVariable ["pos", _zonePosition getPos [500 + random 500, random 360]];

	_taskDataStore setVariable ["patrolPosition", _patrolPosition];
	
	[[["move_to_area", _patrolPosition]]] call _fnc_initialSubtasks;
}];

_dataStore setVariable ["move_to_area", {
	params ["_taskDataStore"];

	private _patrolPosition = _taskDataStore getVariable "patrolPosition";

	{
		if (_x distance2D _patrolPosition < 500 && vehicle _x != _x) exitWith {
			["SUCCEEDED", [["patrol_area", _patrolPosition]]] call _fnc_finishSubtask;
		};
	} forEach missionNamespace getVariable ["GreenHornets", []]; 
}];

_dataStore setVariable ["patrol_area", {
	params ["_taskDataStore"];

	private _aircraftDestroyed = _taskDataStore getVariable ["aircraftDestroyed", 0];
	private _aircraftEscaped = _taskDataStore getVariable ["aircraftEscaped", 0];
	private _currentAircraft = _taskDataStore getVariable ["currentAircraft", []];
	private _units = _taskDataStore getVariable ["units", []];
	private _patrolPosition = _taskDataStore getVariable "patrolPosition";

	//If we have less than 2 aircraft, create as many as necessary to take us up to 2.
	for "_i" from 1 to (1 - count _currentAircraft) do {
		//This isn't a good way of determining spawn position. It needs to be more realistic, and check if there's friendly units nearby.
		private _spawnPosition = _patrolPosition getPos [1000, ((getMarkerPos "mf_respawn_greenhornets") getDir _patrolPosition) + random 45];
		private _aircraftClass = selectRandom selectRandom [vehicles_nva_planes, vehicles_nva_helis];
		private _spawnInfo = [_spawnPosition, _spawnPosition getDir _patrolPosition, _aircraftClass, east call para_g_fnc_create_group] call BIS_fnc_spawnVehicle;

		_currentAircraft pushBack (_spawnInfo select 0);
		_units append (_spawnInfo select 1);

		//Add waypoints for the aircraft to make it fly through the zone.
		private _group = _spawnInfo select 2;
		private _firstWaypoint = _group addWaypoint [AGLtoASL _patrolPosition, -1];
		_group addWaypoint [AGLtoASL (_patrolPosition getPos [10000, 340 + random 65]), -1];

		_group setCurrentWaypoint _firstWaypoint;
	};


	private _aircraftToRemove = [];
	{
		//If an aircraft has been downed - either because it's dead, or because it crash landed.
		if (!alive _x || getPos _x select 2 < 15) then {
			_aircraftDestroyed =  _aircraftDestroyed + 1;
			_aircraftToRemove pushBack _forEachIndex;
		};

		//If an aircraft has escaped
		if (_x distance2D _patrolPosition > 3000) then {
			_aircraftEscaped = _aircraftEscaped + 1;
			_aircraftToRemove pushBack _forEachIndex;
		};
	} forEach _currentAircraft;

	//Delete aircraft from the current aircraft list, and mark them for cleanup
	{
		private _aircraft = _currentAircraft select _x;
		[_aircraft] call para_s_fnc_cleanup_add_items;
		_currentAircraft deleteAt _x;
	} foreach (reverse _aircraftToRemove);

	_taskDataStore setVariable ["aircraftDestroyed", _aircraftDestroyed];
	_taskDataStore setVariable ["aircraftEscaped", _aircraftEscaped];
	_taskDataStore setVariable ["currentAircraft", _currentAircraft];
	_taskDataStore setVariable ["units", _units];

	if (_aircraftEscaped > 3) then {
		["FAILED"] call _fnc_finishSubtask;
		["FAILED"] call _fnc_finishTask;
	};

	if (_aircraftDestroyed > 0) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_dataStore setVariable ["FINISH", {
	params ["_taskDataStore"];

	[_taskDataStore getVariable ["currentAircraft", []]] call para_s_fnc_cleanup_add_items;
	[_taskDataStore getVariable ["units", []]] call para_s_fnc_cleanup_add_items;
}];