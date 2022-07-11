/*
    File: fn_tr_selectTeam.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Called by ctrl, to update the Team-Selection dialog Informations (Text/Icon).
		Get's all needed informations from gamemode config.
    
    Parameter(s):
		_team - Team config name [String]
    
    Returns: nothing
    
    Example(s):
		[] remoteExec ["vn_mf_fnc_tr_overview_team_update", _playerObj];
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"

params ["_team"];

if ([_team] call vn_mf_fnc_is_team_full) exitWith {
	[
		[
			"STR_vn_mf_notification_title_team_full",
			"STR_vn_mf_notification_desc_team_full"
		]
	] call para_c_fnc_postNotification;
};

vn_tr_groupID = _team;
private _groupConfig = (missionConfigFile >> "gamemode" >> "teams" >> _team);
private _groupNameFull = getText(_groupConfig >> "name");
private _groupIcon = getText(_groupConfig >> "icon");
private _groupName = getText(_groupConfig >> "shortname");

// _display = uinamespace getvariable ["vn_tr_disp_selectTeam", DisplayNull];
//set standard Missionname (Briefing Text)
VN_TR_SELECTTEAM_TEAM_NAME_CTRL ctrlSetStructuredText parsetext _groupNameFull;
//Img on the lext side
VN_TR_SELECTTEAM_TEAM_LOGO_CTRL ctrlSetText _groupIcon;

private _playerCount = count (missionNamespace getVariable [_team, []]);

VN_TR_SELECTTEAM_TEAM_PLAYERCOUNT_CTRL ctrlSetStructuredText parsetext format["Active Players: %1", _playerCount];


//DISABLED, can easily be re-enabled, if we want to change the text on the left side too.
/*
_text = composeText ["The Viet Cong controls this province.", lineBreak, "Your Mobile Strike Force must take control of the populace and destroy the Viet Cong"];
VN_TR_SELECTTEAM_TEAM_DESC_CTRL ctrlSetStructuredText _text;

_text = composeText [
						"Capture and hold all zones in this province.",
						lineBreak,
						lineBreak,
						"Each team has unique tasks which help capture a zone.",
						lineBreak,
						lineBreak,
						"Request Support from the other teams to help achieve your goals.",
						lineBreak,
						lineBreak,
						"Complete tasks to gain rank, improved weapons, equipment and vehicles.",
						lineBreak,
						lineBreak,
						"Working together as a unified force will secure the province more quickly.",
						lineBreak,
						lineBreak,
						"Good luck out there, you're going to need it!"];
VN_TR_SELECTTEAM_TEAM_TEXT_CTRL ctrlSetStructuredText _text;
*/


















