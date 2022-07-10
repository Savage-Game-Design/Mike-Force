/*
    File: fn_task_sec_spike_wiretap.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Secondary task to perform a wiretap on a road. Designed to play as a full mini-mission.
		Uses the state machine task system.
    
    Parameter(s):
        _dataStore - Data store to write the state machine states to. Should be the same as _taskDataStore
    
    Returns:
        None
    
    Example(s):
        [parameter] call vn_fnc_myFunction
*/

#define RTB_LOCATION (getMarkerPos "mf_respawn_spiketeam")

params ["_dataStore"];

_dataStore setVariable ["INIT", {
	params ["_taskDataStore"];

	private _wiretapPos = getMarkerPos "mission_wiretap_1_pole";
	private _pole =	vn_mf_mission_wiretap_1_pole;

	_taskDataStore setVariable ["aaPos", getMarkerPos "mission_wiretap_1_AA"];
	_taskDataStore setVariable ["wiretapPos", _wiretapPos];
	_taskDataStore setVariable ["pole", _pole];
	_taskDataStore setVariable ["playersOnMission", []];
	_taskDataStore setVariable ["aiObjectives", []];

	//Spawn AA - use task so we get the AA marker on the map.
	//Only show it to Spike Team
	private _task = ["secondary_st2", "", [["pos", _taskDataStore getVariable "aaPos"]], "", ["SpikeTeam"]] call vn_mf_fnc_task_create;
	_taskDataStore setVariable ["AATask", _task];

	diag_log "Initialising";
	//Add some randomness, because it looks better if the marker moves once 'enter_ao' is done.
	[[["enter_ao", _wiretapPos getPos [random 200, random 360]]]] call _fnc_initialSubtasks;
}];

_dataStore setVariable ["BEFORE_STATES_RUN", {
	params ["_taskDataStore"];

	private _wiretapPos = _taskDataStore getVariable "wiretapPos";
	private _playersInArea = allPlayers inAreaArray [_wiretapPos, 1000, 1000, 0, false];
	private _validPlayers = _playersInArea select {vehicle _x isEqualTo _x && _x getVariable ["vn_mf_db_player_group", "FAILED"] == "SpikeTeam"};
	private _playersOnMission = _taskDataStore getVariable "playersOnMission";

	{
		_playersOnMission pushBackUnique _x;
	} forEach _validPlayers;

	if (count _playersOnMission > 0) then {
		private _someoneIsAlive = _playersOnMission findIf {alive _x} > -1;
		if (!_someoneIsAlive) then {
			["FAILED"] call _fnc_finishTask;
		};
	};
}];

_dataStore setVariable ["enter_ao", {
	params ["_taskDataStore"];

	if !(_taskDataStore getVariable "playersOnMission" isEqualTo []) exitWith {
		["SUCCEEDED", [["start_wiretap", _taskDataStore getVariable "wiretapPos"]]] call _fnc_finishSubtask;
	};	
}];

_dataStore setVariable ["start_wiretap", {
	params ["_taskDataStore"];

	private _aiObjectives = _taskDataStore getVariable "aiObjectives";
	private _pole = _taskDataStore getVariable "pole";


	//Spawn patrol AI objective if none exists.
	if (_aiObjectives isEqualTo []) then {
		//Scary number of AI - these missions are meant to be tough. Also, these AI are meant to be avoided.
		_aiObjectives pushBack (["roads", [getPos _pole, 100], 3, 1] call para_s_fnc_ai_obj_request_patrols);
	};

	//Add wiretap action to the telephone pole.
	if (_taskDataStore getVariable ["wiretapActionId", ""] == "") then {
		private _id = [ 
			_pole,
			"@STR_vn_mf_start_wiretap",
			"\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_loadDevice_ca.paa",
			"\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_loadDevice_ca.paa", 
			"true",
			"true",
			{},
			{
				params ["_target", "_caller", "_actionId", "_args"];
				(_args # 0) setVariable ["wiretapPlaced", true];
			},
			{},
			[_taskDataStore],
			5,
			1000,
			true,
			false,
			false
		] call para_s_fnc_net_action_hold_add;
		_taskDataStore setVariable ["wiretapActionId", _id];
	};

	if (_taskDataStore getVariable ["wiretapPlaced", false]) then {
		//Increase harass intensity, send them as frequently as possible, last for 20 minutes (approximation).
		{
			_x getVariable "harassDifficultyEvents" pushBack [1, 0, serverTime + 1200];
		} forEach (_taskDataStore getVariable ["playersOnMission", []]);
		["SUCCEEDED", [["RTB", RTB_LOCATION]]] call _fnc_finishSubtask;
	};
}];

_dataStore setVariable ["RTB", {
	params ["_taskDataStore"];

	private _playersOnMission = _taskDataStore getVariable "playersOnMission";
	//Find players that are registerd to this task, alive, near to the RTB location, and dismounted.
	private _returnedToBase = _playersOnMission inAreaArray [RTB_LOCATION, 500, 500, 0, false] findIf {alive _x && vehicle _x == _x} > -1;

	if (_returnedToBase) then {
		["SUCCEEDED"] call _fnc_finishTask;
	};
}];

_dataStore setVariable ["FINISH", {
	params ["_taskDataStore"];

	private _aaTask = _taskDataStore getVariable ["aaTask", locationNull];
	if !([_aaTask] call vn_mf_fnc_task_is_completed) then {
		[_aaTask, "CANCELED"] call vn_mf_fnc_task_complete;
	};

	/*
	[_taskDataStore getVariable ["buildings", []]] call para_s_fnc_cleanup_add_items;
	*/
	{
		[_x] call para_s_fnc_ai_obj_finish_objective;
	} forEach (_taskDataStore getVariable "aiObjectives");
}];