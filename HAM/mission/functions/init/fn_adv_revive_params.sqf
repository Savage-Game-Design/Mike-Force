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

private _headshot_kill = ["headshot_kill", 0] call BIS_fnc_getParamValue;
private _bleedout_time = ["bleedout_time", 300] call BIS_fnc_getParamValue;
private _withstand_percentage = ["withstand_percentage", 80] call BIS_fnc_getParamValue;
private _bandage_item_remove = ["remove_bandage_item", 1] call BIS_fnc_getParamValue;
private _revive_item_remove = ["remove_revive_item", 1] call BIS_fnc_getParamValue;
private _revive_requirement = ["revive_requirement", 1] call BIS_fnc_getParamValue;

missionNamespace setVariable ["vn_revive_headshot_kill",[false,true] select _headshot_kill,true];
missionNamespace setVariable ["vn_revive_bleedout_time",_bleedout_time,true];
missionNamespace setVariable ["vn_revive_withstand_percentage",_withstand_percentage,true];
missionNamespace setVariable ["vn_revive_bandage_item_remove",[false,true] select _bandage_item_remove,true];
missionNamespace setVariable ["vn_revive_revive_item_remove",[false,true] select _revive_item_remove,true];
missionNamespace setVariable ["vn_revive_revive_requirement",[false,true] select _revive_requirement,true];
