/*
    File: fn_traits_db_prune.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Updates the `vn_mf_traits_map` public trait list by pruning
        disconnected players or non player objects

        Global locality.

        WARNING: Final changes to `vn_mf_traits_map` need to be
        broadcast with `publicVariable` by calling code. See the
        example section for more info.

    Parameter(s):
        _trait - Trait [String]

    Returns: true when executed successfully

    Example(s):
        // update vn_mf_traits_map on this client
        ["engineer"] call vn_mf_fnc_traits_db_prune;

        // another update
        ["medic"] call vn_mf_fnc_traits_db_prune;

        // yet another update
        ["vn_artillery"] call vn_mf_fnc_traits_db_prune;

        // broadcast the changes across all clients
        publicVariable "vn_mf_traits_map";
*/

params ["_trait"];

private _players_with_selected_trait = [_trait] call vn_mf_fnc_traits_db_get;

private _to_remove = [];
{
    if (isNull _x || !isPlayer _x) then {
        _to_remove pushBack _forEachIndex;
    };

} forEach _players_with_selected_trait;

{
    _players_with_selected_trait deleteAt _x
} forEach _to_remove;

private _curr = missionNamespace getVariable "vn_mf_traits_map";
_curr set [_trait, _players_with_selected_trait];
missionNamespace setVariable ["vn_mf_traits_map", _curr];

true