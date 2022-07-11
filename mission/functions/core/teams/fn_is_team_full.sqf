/*
    File: fn_is_team_full.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
        Checks if a team is full
    
    Parameter(s):
		_team - Name of the team to change to [STRING]
    
    Returns:
	   	Team is full [BOOLEAN]
    
    Example(s):
		["ACAV"] call vn_mf_fnc_is_team_full
*/

params ["_team"];

private _numPlayersOnTeam = count (missionNamespace getVariable [_team, []]);
private _maxTeamPlayers = missionNamespace getVariable ["vn_mf_max_players_" + _team, 99];

_numPlayersOnTeam >= _maxTeamPlayers