/*
    File: fn_traits_db_pop.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Updates the `vn_mf_traits_map` public trait list by popping
        a player from the trait field.

        Global locality.

        WARNING: Final changes to `vn_mf_traits_map` need to be
        broadcast with `publicVariable` by calling code. See the
        example section for more info.
    
    Parameter(s):
		_trait - Trait [String]
        _player - Player object [Object]
    
    Returns: [ARRAY] List of palyer objects that were popped
    
    Example(s): 
        // update vn_mf_traits_map on this client
        ["engineer", _player] call vn_mf_fnc_traits_db_pop;  // returns [_player]

        // another update
        ["medic", _another_player] call vn_mf_fnc_traits_db_pop;  // returns [_another_player]

        // yet another update
        ["medic", _yet_another_player] call vn_mf_fnc_traits_db_pop;  // returns [_yet_another_player]

        // broadcast the changes across all clients
        publicVariable "vn_mf_traits_map";
*/

params ["_trait", "_player"];

private _players_with_selected_trait = [_trait] call vn_mf_fnc_traits_db_get;

private _popped = [];
private _to_remove = [];
{
    if (_player isEqualTo _x) then {
        _popped pushBack _x;
        _to_remove pushBack _forEachIndex;
    };

} forEach _players_with_selected_trait;

{
    _players_with_selected_trait deleteAt _x
} forEach _to_remove;

private _curr = missionNamespace getVariable "vn_mf_traits_map";
_curr set [_trait, _players_with_selected_trait];
missionNamespace setVariable ["vn_mf_traits_map", _curr];

_popped;
