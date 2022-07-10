/*
	File: fn_stats_init.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Initialises stats handling

	Parameter(s): none

	Returns: nothing

	Example(s):
		[] call vn_mf_fnc_stats_init
*/

// setup player health stats tracking
private _stats_cfg = (missionConfigFile >> "gamemode" >> "stats");
private _hungerLossWhole = ["hunger_loss_rate", 5] call BIS_fnc_getParamValue;
private _thirstLossWhole = ["thirst_loss_rate", 10] call BIS_fnc_getParamValue;
private _hungerLossPercent = _hungerLossWhole / 1000;
private _thirstLossPercent = _thirstLossWhole / 1000;
_health_config =
[
	(["difficulty", "hunger_loss_factor", 1] call para_g_fnc_get_gamemode_value),
	(["difficulty", "thirst_loss_factor", 1] call para_g_fnc_get_gamemode_value),
	_hungerLossPercent,
	_thirstLossPercent,
	getNumber(_stats_cfg >> "hunger" >> "min"),
	getNumber(_stats_cfg >> "thirst" >> "min"),
	getNumber(_stats_cfg >> "hunger" >> "max"),
	getNumber(_stats_cfg >> "thirst" >> "max"),
	getArray(_stats_cfg >> "attributes" >> "hunger"),
	getArray(_stats_cfg >> "attributes" >> "thirst")
];

["player_health_stats",compile (str _health_config + " call vn_mf_fnc_player_health_stats"), [], 10] call para_g_fnc_scheduler_add_job;

["taskCompleted", [{
	params ["_handlerParams", "_eventParams"];
	_eventParams params ["_taskDataStore"];

	private _taskType = _taskDataStore getVariable ["taskCategory", ""];

	{
		_group_units = missionNamespace getVariable [_x, []];
		if !(_group_units isEqualTo []) then
		{
			if (_taskType == "PRI") then {
				[_group_units, "taskscomplete", 1] call vn_mf_fnc_change_player_stat;
			};
			if (_taskType == "SEC") then {
				[_group_units, "teamtaskscomplete", 1] call vn_mf_fnc_change_player_stat;
			};
			if (_taskType == "SUP") then {
				[_group_units, "supporttaskscomplete", 1] call vn_mf_fnc_change_player_stat;
			};
		};
	} forEach (_taskDataStore getVariable ["taskGroups", []]);
}, []]] call para_g_fnc_event_add_handler;

["zoneCompleted", [{
	params ["_handlerParams", "_eventParams"];
	_eventParams params ["_zone"];

	[allPlayers, "zonescaptured", 1] call vn_mf_fnc_change_player_stat;

}, []]] call para_g_fnc_event_add_handler;
