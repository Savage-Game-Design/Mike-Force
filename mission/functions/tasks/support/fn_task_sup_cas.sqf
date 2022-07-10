/*
    File: fn_task_sup_cas.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Provide close air support against enemies in the target area.
		Uses the state machine task system.

    Parameter(s):
		_taskDataStore - Namespace for storing task info [Object]

    Returns: nothing

    Example(s):
        Not directly called.
*/

/*
 * Example Usage:
 *    Shouldn't be called directly.
 *
 * Task Parameters:
 *    None
 * Subtask Parameters:
 * 	  None
 */

//Create the global kill tracker we need. Do it here to ensure it exists before the mission is run.
if (isNil "vn_mf_task_sup_cas_killedHandler") then {
	//Track how many missions we have running simultaneously, so we know when we can tidy up.
	vn_mf_task_sup_cas_missionsRunning = 0;

	//Track kills made. We can then handle it in the main mission check, rather than doing any complex logic in unscheduled code
	//This is an optimisation, to avoid running checks if a kill counts as fulilling the CAS mission in unscheduled code.
	vn_mf_task_sup_cas_killTracker = [];

	//Keep it minimal, to avoid impacting framerate.
	vn_mf_task_sup_cas_killedHandler = addMissionEventHandler ["EntityKilled", {
		vn_mf_task_sup_cas_killTracker pushBack _this;
	}];
};

params ["_taskDataStore"];

_taskDataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _taskConfig = _taskDataStore getVariable "taskConfig";
	private _taskParameters = _taskConfig >> "parameters";

	vn_mf_task_sup_cas_missionsRunning = vn_mf_task_sup_cas_missionsRunning + 1;

	private _targetPos = _taskDataStore getVariable "supportRequestPos";

	[[["destroy_targets", _targetPos]]] call _fnc_initialSubtasks;
}];

_taskDataStore setVariable ["destroy_targets", {
	params ["_taskDataStore"];

	private _targetPos = _taskDataStore getVariable "supportRequestPos";
	// All players in groups the support task was sent to can complete it.
	private _playersWhichCanComplete = flatten ((_taskDataStore getVariable "taskGroups") apply {missionNamespace getVariable [_x, []]});

	//Filter out entries missing a 'dead unit' or a 'instigator'
	//We prune out bodies that no longer exist to keep the list short, as much as anything.
	vn_mf_task_sup_cas_killTracker = vn_mf_task_sup_cas_killTracker select {!isNull (_x select 0) && !isNull (_x select 2)};

	{
		_x params ["_killed", "_killer", "_instigator"];

		private _instigatorTeam = _instigator getVariable ["vn_mf_db_player_group", "FAILED"];
		private _instigatorOnValidTeam = _instigatorTeam in (_taskDataStore getVariable "taskGroups");

		//Mission complete once we kill a target in the area.
		//We can be sure instigator isn't null here, nor killed, thanks to the earlier filter.
		if (_instigatorOnValidTeam && {_killed distance2D _targetPos < 200}) exitWith {
			["SUCCEEDED"] call _fnc_finishSubtask;
			["SUCCEEDED"] call _fnc_finishTask;
		};
	} forEach vn_mf_task_sup_cas_killTracker;

	if (allUnits select {side _x == east} inAreaArray [_targetPos, 100, 100, 0, false] isEqualTo []) exitWith {
		["CANCELED"] call _fnc_finishSubtask;
		["CANCELED"] call _fnc_finishTask;
	};
}];

_taskDataStore setVariable ["FINISH", {
	vn_mf_task_sup_cas_missionsRunning = vn_mf_task_sup_cas_missionsRunning - 1;

	//If no missions running, tidy up the resources we're using.
	if (vn_mf_task_sup_cas_missionsRunning == 0) then {
		vn_mf_task_sup_cas_killTracker = [];
		removeMissionEventHandler ["EntityKilled", vn_mf_task_sup_cas_killedHandler];
		//Nil this out, so we know to start back up again next mission.
		vn_mf_task_sup_cas_killedHandler = nil;

	};
}];