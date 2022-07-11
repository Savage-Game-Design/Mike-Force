/*
    File: fn_tr_overview_team_update.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Spawned by the Server.
		Updates the ctrl in the TaskRoster with the correct emblem/sign.
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s):
		[] remoteExec ["vn_mf_fnc_tr_overview_team_update", _playerObj];
*/

if!(remoteExecutedOwner isEqualTo 2) exitWith {systemchat str ["Team Update: Not send by Server! - OwnerID:", remoteExecutedOwner]};

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"

_stopTime = diag_tickTime + 2;
waitUntil	{
				!isNull VN_DISP_TR_TASKROSTER OR
				(diag_tickTime > _stopTime)
			};
if(diag_tickTime > _stopTime)exitWith{ systemchat str ["Team Update: TIMEOUT "]; };

VN_TR_USERNAME_CTRL ctrlSetText profileName;

_groupID = player getVariable ["vn_mf_db_player_group", "FAILED"];

// systemchat str ["team Update - _groupID: ",_groupID];
vn_tr_groupID = _groupID;

private _groupConfig = (missionConfigFile >> "gamemode" >> "teams" >> _groupID);
private _groupNameFull = getText(_groupConfig >> "name");
private _groupIcon = getText(_groupConfig >> "icon");
private _groupName = getText(_groupConfig >> "shortname");
VN_TR_TEAMNAME_CTRL ctrlSetText _groupNameFull;
VN_TR_TEAMLOGO_CTRL ctrlSetText _groupIcon;


_groupNameBold = format["<t align='center' font='tt2020base_vn_bold'>%1</t>", _groupName];
VN_TR_MAININFO_TXT_TOP_CTRL ctrlSetStructuredText parsetext format[localize "STR_vn_mf_taskRoster_Main_teamWelcome", _groupNameBold];
VN_TR_MAININFO_IMG_CTRL ctrlSetText _groupIcon;

call vn_mf_fnc_tr_missions_fill;
