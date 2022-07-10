/*
    File: fn_task_sec_destroy_artillery site.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Destroy artillery site mission script for Mike Force.
		Uses the state machine task system.

    Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

    Returns: nothing

    Example(s):
        Not directly called.
*/

vn_mf_mortar_fire_delay = 20;

params ["_dataStore"];

_dataStore setVariable ["buildMortar", {
	params ["_taskDataStore"];

	private _spawnPosition = _taskDataStore getVariable "mortarPosition";

	private _result = [_spawnPosition] call vn_mf_fnc_create_mortar;
	private _createdThings = _result select 0;

	_taskDataStore setVariable ["mortars", _result select 1];
	_taskDataStore getVariable "vehicles" append (_createdThings select 0); 
	_taskDataStore getVariable "units" append (_createdThings select 1); 
	_taskDataStore getVariable "groups" append (_createdThings select 2); 
}];

_dataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _spawnPos = _taskDataStore getVariable ["pos", []];
	if (_spawnPos isEqualTo []) then {
		private _markerPos = getMarkerPos (_taskDataStore getVariable "taskMarker");
		//Find a random position at least X distance away from the zone, but less than Y.
		private _roughSpawnPosition = [[[_markerPos, 500]], [[_markerPos, 300]]] call BIS_fnc_randomPos;

		//Now find the best place to spawn.
		private _spawnPositions = selectBestPlaces [_roughSpawnPosition, 20, "1 - forest - 2 * waterDepth", 20, 1];

		_spawnPos = if (_spawnPositions isEqualTo []) then {_roughSpawnPosition} else {_spawnPositions select 0 select 0};
	};

	//selectBestPlaces returns position2D, so convert to position3D.
	if (count _spawnPos == 2) then {
		_spawnPos pushBack 0;
	};

	_taskDataStore setVariable ["mortarPosition", _spawnPos];

	private _groups = _taskDataStore getVariable "taskGroups" apply {missionNamespace getVariable _x};
	private _unitScaling = [_groups, {_this call para_g_fnc_count_alive_units_in_groups}];

	//Create patrols that guard the AA point
	private _defendObjective = [_spawnPos, 1, 2] call para_s_fnc_ai_obj_request_defend;
	private _objectives = [_defendObjective];

	_taskDataStore setVariable ["aiObjectives", _objectives];
	_taskDataStore setVariable ["units", []];
	_taskDataStore setVariable ["vehicles", []];
	_taskDataStore setVariable ["groups", []];

	//Build the mortar
	call (_taskDataStore getVariable "buildMortar");

	//Add inaccuracy to the marker, to force them to search.
	private _markerPos = _spawnPos getPos [random 70, random 360];
	[[["find_and_destroy", _markerPos]]] call _fnc_initialSubtasks;
}];

_dataStore setVariable ["find_and_destroy", {
	params ["_taskDataStore"];

	private _mortars = _taskDataStore getVariable "mortars";

	private _anyGunsAlive = {alive _x} count _mortars > 0;

	if (!_anyGunsAlive) exitWith {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};

	//Do some mortar fire if we feel like it.
	private _mortarLastFired = _taskDataStore getVariable ["mortarLastFired", 0];
	if (serverTime > _mortarLastFired + vn_mf_mortar_fire_delay && random 1 > 0.3) then {
		private _zone = _taskDataStore getVariable ["taskMarker", ""];
		private _playersInZone = allPlayers inAreaArray _zone;
		if (_playersInZone isEqualTo []) exitWith {};
		private _targetPos = getPos (selectRandom _playersInZone) vectorAdd [random 250 - 125, random 250 - 125, 0];
		{
			_x doArtilleryFire [_targetPos, getArtilleryAmmo _mortars select 0, ceil (1 + random 1)];
		} forEach _mortars;
		_taskDataStore setVariable ["mortarLastFired", serverTime];
	};
}];

_dataStore setVariable ["FINISH", {
	params ["_taskDataStore"];

	[_taskDataStore getVariable ["vehicles", []]] call para_s_fnc_cleanup_add_items;
	[_taskDataStore getVariable ["units", []]] call para_s_fnc_cleanup_add_items;
	{
		[_x] call para_s_fnc_ai_obj_finish_objective;
	} forEach (_taskDataStore getVariable "aiObjectives");
}];