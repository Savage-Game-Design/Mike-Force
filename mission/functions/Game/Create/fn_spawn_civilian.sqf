/*
	File: fn_spawn_civilian.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Spawns Civilian and sets holdAction
	
	Parameter(s):
		_pos - Spawn position of object [Position3D]
		_varname - Variable name used to track this task [String]
		_class - Class of civilian to spawn [String, defaults to "vn_c_men_20"]
		_saystart - Have action target speak [String, defaults to "vc2"]
		_saycomplete - Class of civilian to spawn [String, defaults to "us114]
	
	Returns:
		Civilian [Object]
	
	Example(s):
		[(getMarkerPos 'civ_2'),'vn_mf_task_civ_2'] call vn_mf_fnc_spawn_civilian;
*/

params [
	"_pos",					// 0: ARRAY - spawn position of object
	"_varname",				// 1: STRING - variable name used to track this task
	["_class","vn_c_men_20"],		// 2: STRING - Class of civilian to spawn (optional)
	["_saystart","vc2"],			// 3: STRING - have action target speak (optional)
	["_saycomplete", "us114"]		// 4: STRING - Class of civilian to spawn (optional)
];

// spawn simple agent
_agent = createAgent [_class, _pos, [], 0, "NONE"];

_agent setVariable ["sideAtCreation", civilian, true];

// set variable to true and player talk back to civ
_completed = compile ("params ['_target', '_caller', '_action_id', '_arguments']; _arguments params ['_varname','_saycomplete','']; missionNamespace setVariable [_varname,true,true]; _caller say _saycomplete;");
_start = compile ("params ['_target', '_caller', '_action_id', '_arguments']; _arguments params ['','','_saystart']; _target say _saystart;");

// hold action
[
	_agent,											// Object the action is attached to
	"Talk to Civilian",										// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 6",						// Condition for the action to be shown
	"_caller distance _target < 6",						// Condition for the action to progress
	_start,													// Code executed when action starts
	{},													// Code executed on every progress tick
	_completed,									// Code executed on completion
	{},													// Code executed on interrupted
	[_varname,_saycomplete,_saystart],													// Arguments passed to the scripts as _this select 3
	5,													// Action duration [s]
	100,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
] remoteExec ["BIS_fnc_holdActionAdd", 0];	// MP compatible implementation

_agent
