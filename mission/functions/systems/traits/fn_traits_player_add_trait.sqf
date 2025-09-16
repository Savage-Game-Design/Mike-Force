/*
    File: fn_traits_player_add_trait.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Adds the trait to the player object. Server local.

    Parameter(s):
		_trait - Trait [String]
        _player - Player object [Object]
    
    Returns: true when executed successfully
    
    Example(s):
        ["engineer", _player] call vn_mf_fnc_traits_player_add_trait;
        ["vn_artillery", _player] call vn_mf_fnc_traits_player_add_trait;
        ["medic", player] call vn_mf_fnc_traits_player_add_trait;
*/

params ["_trait", "_player"];

private _is_vanilla_trait = [_trait] call vn_mf_fnc_traits_trait_is_vanilla;

// Do checks for tutorial for trait
["tookTraining", [_player, _trait]] call para_g_fnc_event_dispatch;

// mark player as already having set a trait
_player setVariable ["vn_mf_dyn_trait_set", _trait];

[_player, [_trait, true, !_is_vanilla_trait]] remoteExecCall ["setUnitTrait", _player];

true
