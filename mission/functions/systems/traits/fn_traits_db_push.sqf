/*
    File: fn_traits_db_push.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Updates the `vn_mf_traits_map` public trait list by pushing
        a player into the trait's array.

        Global locality.

        WARNING: Final changes to `vn_mf_traits_map` need to be
        broadcast with `publicVariable` by calling code. See the
        example section for more info.
    
    Parameter(s):
		_trait - Trait [String]
        _player - Player object [Object]
    
    Returns: true when executed successfully
    
    Example(s): 
        // update vn_mf_traits_map on this client
        ["engineer", _player] call vn_mf_fnc_traits_db_push;

        // another update
        ["medic", _another_player] call vn_mf_fnc_traits_db_push;

        // yet another update
        ["medic", _yet_another_player] call vn_mf_fnc_traits_db_push;

        // broadcast the changes across all clients
        publicVariable "vn_mf_traits_map";
*/

params ["_trait", "_player"];

private _players_with_selected_trait = [_trait] call vn_mf_fnc_traits_db_get;
_players_with_selected_trait pushBackUnique _player;

private _curr = missionNamespace getVariable "vn_mf_traits_map";
_curr set [_trait, _players_with_selected_trait];
missionNamespace setVariable ["vn_mf_traits_map", _curr];

true;
