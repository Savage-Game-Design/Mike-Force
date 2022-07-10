/*
    File: fn_task_sec_destroy_mortar.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Destroy Mortar Task.

    Parameter(s):
		_dataStore - Namespace for storing state machine info. [Object]

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
 *    pos - Position to spawn the mortar and defenses at.
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

	private _markerPosition = getMarkerPos (_taskDataStore getVariable "taskMarker");

	private _spawnPosition = _taskDataStore getVariable ["pos", []];

	if (_spawnPosition isEqualTo []) then {
		//Find a random position at least X distance away from the zone, but less than Y.
		private _roughSpawnPosition = [[[_markerPosition, 500]], [[_markerPosition, 300]]] call BIS_fnc_randomPos;

		//Now find the best place to spawn.
		private _spawnPositions = selectBestPlaces [_roughSpawnPosition, 20, "1 - forest - 2 * waterDepth", 20, 1];

		_spawnPosition = if (_spawnPositions isEqualTo []) then {_roughSpawnPosition} else {_spawnPositions select 0 select 0};
	};

	//selectBestPlaces returns position2D, so convert to position3D.
	if (count _spawnPosition == 2) then {
		_spawnPosition pushBack 0;
	};

	_taskDataStore setVariable ["mortarPosition", _spawnPosition];

	private _groups = _taskDataStore getVariable "taskGroups" apply {missionNamespace getVariable _x};
	private _unitScaling = [_groups, {_this call para_g_fnc_count_alive_units_in_groups}];

	//Create patrols that guard the AA point
	private _patrolObjective = [[_unitScaling, 1], _spawnPosition] call para_s_fnc_ai_obj_request_defend;

	_taskDataStore setVariable ["aiObjectives", [_patrolObjective]];
	_taskDataStore setVariable ["units", []];
	_taskDataStore setVariable ["vehicles", []];
	_taskDataStore setVariable ["groups", []];

	//Do we need a build phase?
	private _buildTime = _taskDataStore getVariable ["buildTime", 0];
	if (_buildTime > 0) then {
		_taskDataStore setVariable ["mortarBuildCompleteTime", diag_tickTime + _buildTime];

		//Spawn in our 'construction' crate + defenses
		private _buildCrate = [aa_emplacement_build_crate, _spawnPosition] call para_g_fnc_create_vehicle;
		//Set damage to 0.8, to allow low-ish power explosives destroy it
		_buildCrate setDamage 0.8;
		_taskDataStore setVariable ["buildCrate", _buildCrate];

		[[["preparing_mortar", _spawnPosition]]] call _fnc_initialSubtasks;
	} else {
		//Build the mortar
		call (_taskDataStore getVariable "buildMortar");
		[[["destroy_mortar", _spawnPosition]]] call _fnc_initialSubtasks;
	};

}];


_dataStore setVariable ["preparing_mortar", {
	params ["_taskDataStore"];

	private _buildCrate = _taskDataStore getVariable "buildCrate";

	if (!alive _buildCrate) exitWith {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};

	if (diag_tickTime < (_taskDataStore getVariable "mortarBuildCompleteTime")) exitWith {};

	//Stop this subtask running, we failed. Now, onto destroy!
	["FAILED"] call _fnc_finishSubtask;

	//Delete the build crate
	deleteVehicle (_taskDataStore getVariable "buildCrate");

	//Build the mortar
	call (_taskDataStore getVariable "buildMortar");

	[[["destroy_mortar", _taskDataStore getVariable "mortarPosition"]]] call _fnc_initialSubtasks;
}];

_dataStore setVariable ["destroy_mortar", {
	params ["_taskDataStore"];

	private _mortars = _taskDataStore getVariable "mortars";

	private _anyGunsAlive = {alive _x} count _mortars > 0;

	if (([[_taskDataStore getVariable "mortarPosition", 50, 50]] call vn_mf_fnc_check_enemy_units_alive) || !_anyGunsAlive) exitWith {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};

	diag_log "Preparing to fire mortar";
	//Do some mortar fire if we feel like it.
	private _mortarLastFired = _taskDataStore getVariable ["mortarLastFired", 0];
	if (serverTime > _mortarLastFired + vn_mf_mortar_fire_delay && random 1 > 0.3) then {
		diag_log "Firing mortar";
		private _zone = _taskDataStore getVariable ["taskMarker", ""];
		private _playersInZone = allPlayers inAreaArray _zone;
		if (_playersInZone isEqualTo []) exitWith {};
		private _targetPos = getPos (selectRandom _playersInZone) vectorAdd [random 250 - 125, random 250 - 125, 0];
		diag_log format ["Firing mortar at %1", _targetPos];
		{
			diag_log "Firing now!";
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