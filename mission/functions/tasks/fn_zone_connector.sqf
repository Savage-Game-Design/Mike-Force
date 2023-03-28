/*
	File: fn_zone_connector.sqf
	Author: Savage Game Design
	Public: No

	Description:
		A task created by a dead zone to allow the players to trigger the next zone.

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
 * 	  None
 * Runtime Parameters:
 *    newZone - Name of the marker of the zone to unlock
 *    position - Position to spawn the task marker
 */

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _position = _taskDataStore getVariable ["pos", getMarkerPos (_taskDataStore getVariable "newZone")];
	_taskDataStore setVariable ["pos", _position];

	[[["build_checkpoint", _position]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["build_checkpoint", {
	params ["_taskDataStore"];


	//If another connector has told us to abort, we abort.
	if (
		_taskDataStore getVariable ["abortConnector", false] 
	    || (_taskDataStore getVariable "newZone") in keys mf_s_dir_activeZones
		|| (_taskDatastore getVariable "newZone") in vn_mf_completedZones
	)
	exitWith {
		["CANCELED"] call _fnc_finishSubtask;
		["CANCELED"] call _fnc_finishTask;
	};

	private _targetPosition = _taskDataStore getVariable "pos";

	//Check if they've made a decision by building a checkpoint.
	if (para_buildings_towers inAreaArray [_targetPosition, 200, 200, 0, false] findIf {alive _x} > -1) then {
		["SUCCEEDED"] call _fnc_finishSubtask;
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	params ["_taskDataStore"];

	//We don't cancel the other connector tasks if we're not connector succeeding.
	if (_taskDataStore getVariable "stateMachineResult" != "SUCCEEDED") exitWith {};

	//Cancel other connectors if we have enough zones active.
	//Not entirely happy with how we're cancelling the task.
	//Maybe cancelling should be built into the state machine framework?
	if (count keys mf_s_dir_activeZones + 1 >= vn_mf_targetNumberOfActiveZones) then {
		private _otherRelatedConnectors = 
			vn_mf_tasks 
			select {_x select 1 getVariable "taskClass" == "zone_connector"};

		{
			private _store = _x select 1;
			_store setVariable ["abortConnector", true];
		} forEach _otherRelatedConnectors
	};
	
	//Protection from a race condition, where two or more connectors might be in the 'FINISH' state at the same time
	//Without this check, it would make multiple zones active, which might go over our limit.
	if (count keys mf_s_dir_activeZones < vn_mf_targetNumberOfActiveZones) then {
		(_taskDataStore getVariable "newZone") call vn_mf_fnc_zones_make_zone_active;
	};

}];