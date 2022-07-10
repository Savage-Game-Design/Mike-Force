/*
	File: fn_player_on_team.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Checks if a player is on a given team
	
	Parameter(s):
		_player - Player to check [Object]
		_team - Id of team [String]
	
	Returns:
		True if player on the given team, false otherwise.
	
	Example(s):
		[player, "MikeForce"] call vn_mf_fnc_playerInTeam
*/

params ["_player", "_team"];

(_player getVariable ["vn_mf_db_player_group", "FAILED"] == _team);