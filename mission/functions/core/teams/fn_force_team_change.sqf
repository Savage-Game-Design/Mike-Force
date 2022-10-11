/*
	File: fn_force_team_change.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Forces a player to switch to the given team.

	Parameter(s):
		_player - Player to force the team switch on [Object]
		_team - Name of the team [String]

	Returns: nothing

	Example(s):
		[player, "MikeForce"] call vn_mf_fnc_force_team_change
*/

params ["_player", "_team"];

private _playerGroup = _player getVariable ["vn_mf_db_player_group", "FAILED"];
private _playerGroupArray = missionNamespace getVariable [_playerGroup,[]];

["changedTeams", [_player, _team]] call para_g_fnc_event_dispatch;
_player setVariable ["vn_mf_db_player_group", _team, true];

// Remove the player from their original team's group array
_playerGroupArray deleteAt (_playerGroupArray find _player);
missionNamespace setVariable [_playerGroup, _playerGroupArray];
publicVariable _playerGroup;

// add them to the new team
private _nextPlayerTeam = _player getVariable ["vn_mf_db_player_group", "FAILED"];
private _nextPlayerTeamArray = missionNamespace getVariable [_nextPlayerTeam, []];
_nextPlayerTeamArray pushBackUnique _player;

missionNamespace setVariable [_nextPlayerGroup, _nextPlayerGroupArray];
publicVariable _nextPlayerGroup;

[[_team], {
	[] call vn_mf_fnc_task_refresh_tasks_client;
	[] call vn_mf_fnc_tr_overview_team_update;
}] remoteExec ["spawn", _player];

[] remoteExecCall ["vn_mf_fnc_apply_unit_traits", _player];
