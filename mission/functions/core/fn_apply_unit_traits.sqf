/*
    File: fn_apply_unit_traits.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Configures player traits.

        Client local.

        Usually called by fn_force_team_change.sqf when player team is changed:
        * server joins
        * player respawn
        * task roster team selection.

    Parameter(s): none

    Returns: nothing

    Example(s): none
*/

private _groupID = player getVariable ["vn_mf_db_player_group", "FAILED"];
private _groupConfig = (missionConfigFile >> "gamemode" >> "teams" >> _groupID);
private _groupDefaultTraits = configProperties[(_groupConfig >> "defaultTraits")];

/*
remove Mike Force traits related to training roles from player
both on player object and in public k-v store

stops the case where a player switches teams, keeping a role
they shouldn't have access to on that team -- e.g. Spike Team engineer.

also stops the case where the role is not highlighted as selected in the
wheel menu, but click on the role Removed the role from the player.
*/
private _vn_mf_traits = keys (missionNamespace getVariable "vn_mf_traits_map");
_vn_mf_traits apply {
    [_x, player] call vn_mf_fnc_traits_player_remove_trait;
    [_x, player] call vn_mf_fnc_traits_db_pop;
};

// add default traits from teams.hpp to the player with the appropriate values
{
    private _value = _x call BIS_fnc_getCfgData;
    private _class_name = configName _x;
    private _is_vanilla_trait = [_class_name] call vn_mf_fnc_traits_trait_is_vanilla;
    if ((typeName _value) isEqualTo "STRING") then {_value = call compile _value};
    player setUnitTrait [_class_name, _value, !_is_vanilla_trait];

    // add player to public k-v store if the trait is for a Mike force
    // assignable training/role and its configured value is "true"
    if ((typeName _value) isEqualTo "BOOLEAN" && {_value && (_class_name in _vn_mf_traits)}) then {
        [_class_name, player] call vn_mf_fnc_traits_db_push;
    };

} forEach _groupDefaultTraits;

// broadcast traits k-v store updates to all clients
// see systems/traits/fn_settrait.sqf and systems/traits/fn_traits_db_push.sqf
// for more details
publicVariable "vn_mf_traits_map";
