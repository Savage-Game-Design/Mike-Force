/*
    File: fn_adv_revive_params.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Sets advanced revive params

    Parameter(s): none

    Returns: nothing

    Example(s): none
*/


// Toggles

private _headshot_kill = [false, true] select (["revive_headshot_kill", 0] call BIS_fnc_getParamValue);
missionNamespace setVariable ["vn_revive_headshot_kill", _headshot_kill, true];

private _bandage_item_remove = [false, true] select (["revive_remove_bandage_item", 1] call BIS_fnc_getParamValue);
missionNamespace setVariable ["vn_revive_bandage_item_remove", _bandage_item_remove, true];

private _revive_item_remove = [false, true] select (["revive_remove_revive_item", 1] call BIS_fnc_getParamValue);
missionNamespace setVariable ["vn_revive_revive_item_remove", _revive_item_remove, true];

private _revive_requirement = [false, true] select (["revive_revive_requirement", 1] call BIS_fnc_getParamValue);
missionNamespace setVariable ["vn_revive_revive_requirement", _revive_requirement, true];

private _revive_bleedout_affects_actions = [false, true] select (["revive_bleedout_affects_actions", 1] call BIS_fnc_getParamValue);
missionNamespace setVariable ["vn_revive_bleedout_affects_actions", _revive_bleedout_affects_actions, true];

// Real values / selections

private _bleedout_time = ["revive_bleedout_time", 300] call BIS_fnc_getParamValue;
missionNamespace setVariable ["vn_revive_bleedout_time", _bleedout_time, true];

private _withstand_percentage = ["revive_withstand_percentage", 80] call BIS_fnc_getParamValue;
missionNamespace setVariable ["vn_revive_withstand_percentage", _withstand_percentage, true];

private _revive_revive_delay = ["revive_revive_delay", 5] call BIS_fnc_getParamValue;
missionNamespace setVariable ["vn_revive_revive_delay", _revive_revive_delay, true];

private _revive_move_chance = ["revive_move_chance", 75] call BIS_fnc_getParamValue;
missionNamespace setVariable ["vn_revive_move_chance", _revive_move_chance, true];

private _revive_respawn_action_time = ["revive_respawn_action_time", 75] call BIS_fnc_getParamValue;
missionNamespace setVariable ["vn_revive_respawn_action_time", _revive_respawn_action_time, true];

private _revive_icon_distance = ["revive_icon_distance", 50] call BIS_fnc_getParamValue;
missionNamespace setVariable ["vn_revive_icon_distance", _revive_icon_distance, true];

private _medical_items_arr = [
    [],
    ["Medikit","vn_b_item_medikit_01"],
    ["FirstAidKit","vn_o_item_firstaidkit","vn_b_item_firstaidkit", "vn_b_item_medikit_01", "Medikit"]
];

private _bandage_item_arr = _medical_items_arr select (["revive_bandage_item", 2] call BIS_fnc_getParamValue);
missionNamespace setVariable ["vn_revive_bandage_item", _bandage_item_arr, true];

private _revive_item_arr = _medical_items_arr select (["revive_revive_item", 2] call BIS_fnc_getParamValue);
missionNamespace setVariable ["vn_revive_revive_item", _revive_item_arr, true];

// private _headshot_kill = ["revive_headshot_kill", 0] call BIS_fnc_getParamValue;
// private _bleedout_time = ["revive_bleedout_time", 300] call BIS_fnc_getParamValue;
// private _withstand_percentage = ["revive_withstand_percentage", 80] call BIS_fnc_getParamValue;
// private _bandage_item_remove = ["revive_remove_bandage_item", 1] call BIS_fnc_getParamValue;
// private _revive_item_remove = ["revive_remove_revive_item", 1] call BIS_fnc_getParamValue;
// private _revive_requirement = ["revive_revive_requirement", 1] call BIS_fnc_getParamValue;

// missionNamespace setVariable ["vn_revive_headshot_kill",[false,true] select _headshot_kill,true];
// missionNamespace setVariable ["vn_revive_bleedout_time",_bleedout_time,true];
// missionNamespace setVariable ["vn_revive_withstand_percentage",_withstand_percentage,true];
// missionNamespace setVariable ["vn_revive_bandage_item_remove",[false,true] select _bandage_item_remove,true];
// missionNamespace setVariable ["vn_revive_revive_item_remove",[false,true] select _revive_item_remove,true];
// missionNamespace setVariable ["vn_revive_revive_requirement",[false,true] select _revive_requirement,true];
