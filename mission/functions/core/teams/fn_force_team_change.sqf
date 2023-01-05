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

// Remove the player from their original team's group array
_playerGroupArray deleteAt (_playerGroupArray find _player);
publicVariable _playerGroup;

// Add the player to the new team's player list.
_player setVariable ["vn_mf_db_player_group", _team, true];
private _nextPlayerTeamArray = missionNamespace getVariable [_team, []];
_nextPlayerTeamArray pushBackUnique _player;
publicVariable _nextPlayerTeam;

[[_team], {
	[] call vn_mf_fnc_task_refresh_tasks_client;
	[] call vn_mf_fnc_tr_overview_team_update;
}] remoteExec ["spawn", _player];

[] remoteExecCall ["vn_mf_fnc_apply_unit_traits", _player];
