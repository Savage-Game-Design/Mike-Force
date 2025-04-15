/*
    File: fn_traits_player_remove_trait.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Removes the trait from the player object. Server local.
    
    Parameter(s):
		_trait - Trait [String]
        _player - Player object [Object]
    
    Returns: true when executed successfully
    
    Example(s):
        ["engineer", _player] call vn_mf_fnc_traits_player_remove_trait;
        ["vn_artillery", _player] call vn_mf_fnc_traits_player_remove_trait;
        ["medic", player] call vn_mf_fnc_traits_player_remove_trait;
*/

params ["_trait", "_player"];

private _is_vanilla_trait = [_trait] call vn_mf_fnc_traits_trait_is_vanilla;

// set trait to false
[_player, [_trait, false, !_is_vanilla_trait]] remoteExecCall ["setUnitTrait", _player];
_player setVariable ["vn_mf_dyn_trait_set", ""];

true
