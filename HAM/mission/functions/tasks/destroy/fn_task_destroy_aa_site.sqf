/*
    File: fn_task_sec_destroy_camp.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Destroy camp mission script for Mike Force.
		Uses the state machine task system.

    Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

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
 *    pos - Position to spawn the camp at.
 */

params ["_dataStore"];

_dataStore setVariable ["buildEmplacement", {
	params ["_taskDataStore"];

	private _spawnPosition = _taskDataStore getVariable "aaPosition";

	private _aaType = _taskDataStore getVariable ["aaType", "heavy"];
	private _result = [_spawnPosition, _aaType] call vn_mf_fnc_create_aa_emplacement;
	private _createdThings = _result select 0;

	//Create an AA warning marker.
	private _markerPos = _spawnPosition getPos [200 + random 100, random 360];
	private _aaZoneMarker = createMarker [format ["AA_zone_%1", _taskDataStore getVariable "taskId"], _markerPos];
	_aaZoneMarker setMarkerSize [1000, 1000];
	_aaZoneMarker setMarkerShape "ELLIPSE";
	_aaZoneMarker setMarkerBrush "DiagGrid";
	_aaZoneMarker setMarkerColor "ColorRed";
	_aaZoneMarker setMarkerAlpha 0.5;

	private _aaMarker = createMarker [format ["AA_%1", _taskDataStore getVariable "taskId"], _markerPos];
	_aaMarker setMarkerType "o_antiair";
	_aaMarker setMarkerAlpha 0.5;


	_taskDataStore setVariable ["markers", [_aaZoneMarker, _aaMarker]];
	_taskDataStore setVariable ["aaGuns", _result select 1];
	_taskDataStore getVariable "vehicles" append (_createdThings select 0); 
	_taskDataStore getVariable "units" append (_createdThings select 1); 
	_taskDataStore getVariable "groups" append (_createdThings select 2); 
}];

_dataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _spawnPos = _taskDataStore getVariable ["pos", []];
	if (_spawnPos isEqualTo []) then {
		//Only load marker if needed.
		private _markerPosition = getMarkerPos (_taskDataStore getVariable "taskMarker");

		//Find a random position at least X distance away from the zone, but less than Y.
		private _roughSpawnPosition = [[[_markerPosition, 500]], [[_markerPosition, 300]]] call BIS_fnc_randomPos;

		//Now find the best place to spawn.
		private _spawnPositions = selectBestPlaces [_roughSpawnPosition, 20, "1 - (0.5 - forest) * (0.5 - forest) - waterDepth", 20, 1];

		_spawnPos = if (_spawnPositions isEqualTo []) then {_roughSpawnPosition} else {_spawnPositions select 0 select 0};
	};

	//selectBestPlaces returns position2D, so convert to position3D.
	if (count _spawnPos == 2) then {
		_spawnPos pushBack 0;
	};

	_taskDataStore setVariable ["aaPosition", _spawnPos];

	//Create patrols that guard the AA point
	private _defendObjective = [_spawnPos, 1, 2] call para_s_fnc_ai_obj_request_defend;

	_taskDataStore setVariable ["aiObjectives", [_defendObjective]];
	_taskDataStore setVariable ["units", []];
	_taskDataStore setVariable ["vehicles", []];
	_taskDataStore setVariable ["groups", []];

	call (_taskDataStore getVariable "buildEmplacement");

	//Add inaccuracy to the marker, to force them to search.
	private _markerPos = _spawnPos getPos [random 70, random 360];
	
	[[["find_and_destroy", _markerPos]]] call _fnc_initialSubtasks;
}];

_dataStore setVariable ["find_and_destroy", {
	params ["_taskDataStore"];

	private _anyGunsAlive = {alive _x} count (_taskDataStore getVariable "aaGuns") > 0;

	if (_anyGunsAlive) exitWith {};

	["SUCCEEDED"] call _fnc_finishSubtask;
	["SUCCEEDED"] call _fnc_finishTask;
}];

_dataStore setVariable ["FINISH", {
	params ["_taskDataStore"];

	//Delete the AA warning marker
	{
		deleteMarker _x;
	} forEach (_taskDataStore getVariable "markers");

	[_taskDataStore getVariable ["vehicles", []]] call para_s_fnc_cleanup_add_items;
	[_taskDataStore getVariable ["units", []]] call para_s_fnc_cleanup_add_items;
	{
		[_x] call para_s_fnc_ai_obj_finish_objective;
	} forEach (_taskDataStore getVariable "aiObjectives");
}];