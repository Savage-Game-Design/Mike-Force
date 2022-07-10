/*
    File: fn_apply_unit_traits.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Sets starting traits.

    Parameter(s): none

    Returns: nothing

    Example(s): none
*/

private _groupID = player getVariable ["vn_mf_db_player_group", "FAILED"];
private _groupConfig = (missionConfigFile >> "gamemode" >> "teams" >> _groupID);
private _groupDefaultTraits = configProperties[(_groupConfig >> "defaultTraits")];
private _vanilla_traits = [ 
    "audibleCoef", 
    "camouflageCoef", 
    "loadCoef", 
    "engineer", 
    "explosiveSpecialist", 
    "medic", 
    "UAVHacker" 
];
{
    private _value = _x call BIS_fnc_getCfgData;
    private _class_name = configName _x;
    if ((typeName _value) isEqualTo "STRING") then {_value = call compile _value};
    player setUnitTrait [_class_name, _value, !(_class_name in _vanilla_traits)];
} forEach _groupDefaultTraits;