/*
    File: fn_admin_arsenal.sqf
    Author: Savage Game Design
    Public: No

    Description:
    Gives admins access to the arsenal

    Parameter(s):
		None

    Returns: nothing

    Example(s): none
*/

#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

waitUntil {!isNil "vn_whitelisted_arsenal_loadouts" && {!isNil "vn_whitelisted_arsenal_parameter"}};


private _equipment = (vn_whitelisted_arsenal_parameter#3);

vn_customarsenalopening = false;
private _vn_mf_arsenalopened_function =
{
        params [["_display",displayNull,[displayNull]]];

        private _is_zeus = !isNull (findDisplay 312);
        private _is_admin = call BIS_fnc_admin >= 2;

        switch true do
        {
                case (!vn_customarsenalopening && {_is_zeus});
                case (!vn_customarsenalopening && {_is_admin}):
                {
                        cutText ["", "BLACK FADED", 0];
                        waitUntil{!(isNull (uinamespace getvariable ["RscDisplayArsenal",displayNull]))};
                        (uinamespace getvariable "RscDisplayArsenal") closeDisplay 2;
                        vn_customarsenalopening = true;
                        [] spawn
                        {

                                [player] call vn_fnc_whitelisted_arsenal_calculate_access;
                                ["Open", [false, vn_whitelisted_arsenal_player_whitelist_object, player]] call bis_fnc_arsenal;
                                waitUntil{!(isNull (uinamespace getvariable ["RscDisplayArsenal",displayNull]))};
                                cutText ["", "BLACK IN", 0.2];
                                vn_customarsenalopening = false;
                                [(uinamespace getvariable "RscDisplayArsenal")] call vn_fnc_whitelisted_arsenal_override;
                        };
                        true
                };
        };
};

if (_equipment in [0,2]) then
{
  [missionnamespace, "arsenalOpened", _vn_mf_arsenalopened_function] call BIS_fnc_addScriptedEventHandler;
};
