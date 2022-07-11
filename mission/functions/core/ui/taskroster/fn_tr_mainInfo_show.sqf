/*
    File: fn_tr_mainInfo_show.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Loads up and sets the text in the Main Information Window (Teamlogo, short description).
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/
    
disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"

VN_TR_MAININFO_CTRL ctrlShow true;

private _groupID = player getVariable ["vn_mf_db_player_group", "FAILED"];
private _groupConfig = (missionConfigFile >> "gamemode" >> "teams" >> _groupID);
private _groupNameFull = getText(_groupConfig >> "name");
private _groupIcon = getText(_groupConfig >> "icon");
private _groupName = getText(_groupConfig >> "shortname");
VN_TR_MAININFO_IMG_CTRL ctrlSetText _groupIcon;
_groupNameBold = format["<t align='center' font='tt2020base_vn_bold'>%1</t>", _groupName];
VN_TR_MAININFO_TXT_TOP_CTRL ctrlSetStructuredText parsetext format[localize "STR_vn_mf_taskRoster_Main_teamWelcome", _groupNameBold];

//new
//--- Add role descriptions
_text = switch _groupID do {
	case "MikeForce":{"STR_vn_mf_taskRoster_Main_MikeForceDescription"};
	case "SpikeTeam":{"STR_vn_mf_taskRoster_Main_SpikeTeamDescription"};
	case "GreenHornets":{"STR_vn_mf_taskRoster_Main_GreenHornetsTeamDescription"};
	case "ACAV":{"STR_vn_mf_taskRoster_Main_ArmouredCavalryDescription"};
	default {""};
};

VN_TR_MAININFO_TXT_MID_CTRL ctrlSetStructuredText parseText format [localize _text, format ["<img size='5' color='#FFFFFF' image='%1'/>", _groupIcon]];
VN_TR_MAININFO_TXT_MID_CTRL ctrlSetPositionH (ctrlTextHeight VN_TR_MAININFO_TXT_MID_CTRL);
VN_TR_MAININFO_TXT_MID_CTRL ctrlCommit 0;

private _traitConfigs = "true" configClasses (missionConfigFile >> "gamemode" >> "traits");

//--- Delete old controls
((allControls VN_DISP_TR_TASKROSTER) select {ctrlParentControlsGroup _x == VN_TR_MAININFO_GRP_ROLES_CTRL}) apply {ctrlDelete _x};
//--- Top seperator
private _seperator = VN_DISP_TR_TASKROSTER ctrlCreate ["vn_mf_RscText", -1, VN_TR_MAININFO_GRP_ROLES_CTRL];
_seperator ctrlSetPosition [0, 0, UIW(15), pixelH];
_seperator ctrlCommit 0;
_seperator ctrlSetBackgroundColor [0,0,0,1];
_tgH = pixelH + UIH(0.1); // keep track of the y position in the controls group for the next row

{
	private _traitConfig = _x;
	private _traitName = configName _x;
	private _addH = 0; // find the highest h value of any text control
	private _nCtrls = []; // store newly created controls
	//--- Row group
	private _ctrlSingleRoleGroup = VN_DISP_TR_TASKROSTER ctrlCreate ["vn_mf_RscControlsGroupNoScrollbarHV", -1, VN_TR_MAININFO_GRP_ROLES_CTRL];
	_nCtrls pushBack _ctrlSingleRoleGroup;
	_ctrlSingleRoleGroup ctrlSetPosition [0, _tgH, UIW(15), UIH(1)];
	_ctrlSingleRoleGroup ctrlCommit 0;
	//--- Role icon, column 1
	private _ctrlRoleName = VN_DISP_TR_TASKROSTER ctrlCreate ["vn_mf_RscPicture",-1,_ctrlSingleRoleGroup];
	_ctrlRoleName ctrlSetPosition [0, 0, UIW(1.5), UIH(1.5)];
	_ctrlRoleName ctrlCommit 0;
	_ctrlRoleName ctrlSetText getText (_traitConfig >> "icon");
	_ctrlRoleName ctrlSetTooltip (getText (_traitConfig >> "text") call para_c_fnc_localize);
	_ctrlRoleName ctrlSetTextColor [0,0,0,0.8];
	//--- Tasks, column 2
	private _ctrlRoleTasks = VN_DISP_TR_TASKROSTER ctrlCreate ["vn_mf_RscStructuredText",-1,_ctrlSingleRoleGroup];
	_nCtrls pushBack _ctrlRoleTasks;
	_ctrlRoleTasks ctrlSetPosition [UIW(3), 0, UIW(6.5), UIH(1)];
	_ctrlRoleTasks ctrlCommit 0;
	private _roleTasks = switch _traitName do {
		case "medic":{localize "STR_vn_mf_taskRoster_Main_medicTasks"};
		case "engineer":{localize "STR_vn_mf_taskRoster_Main_engineerTasks"};
		case "explosiveSpecialist":{localize "STR_vn_mf_taskRoster_Main_explosive_specialistTasks"};
		case "radioOperator": { localize "STR_vn_mf_radioOperatorTasks" };
		default {""};
	};
	_ctrlRoleTasks ctrlSetStructuredText parseText format ["<t size='0.75'>%1</t>",_roleTasks];
	_addH = _addH max ctrlTextHeight _ctrlRoleTasks;
	//--- Player list, column 3
	private _ctrlListPlayers = VN_DISP_TR_TASKROSTER ctrlCreate ["vn_mf_RscStructuredText", -1, _ctrlSingleRoleGroup];
	_nCtrls pushBack _ctrlListPlayers;
	_ctrlListPlayers ctrlSetPosition [UIW(9.5), 0, UIW(5.5), UIH(1)];
	_ctrlListPlayers ctrlCommit 0;
	private _t = [];
	//--- Find the roles of the players
	private _pGroupName = player getVariable ["vn_mf_db_player_group", "FAILED"];
	private _pGroup = missionNamespace getVariable [_pGroupName, []];
	private _t = _pGroup select {_x getUnitTrait _traitName};
	_t = _t apply {name _x};
	if (count _t == 0) then {_t = ["-"]};
	_ctrlListPlayers ctrlSetStructuredText parseText format ["<t size='0.75'>%1</t>", (_t joinString ", ")];
	_addH = _addH max ctrlTextHeight _ctrlListPlayers;
	_addH = _addH max UIH(1.5);
	_nCtrls apply {
		_x ctrlSetPositionH _addH;
		_x ctrlCommit 0;
	};
	_tgH = _tgH + _addH + UIH(0.1);
	//--- Seperator between roles
	_seperator = VN_DISP_TR_TASKROSTER ctrlCreate ["RscText", -1, VN_TR_MAININFO_GRP_ROLES_CTRL];
	_seperator ctrlSetPosition [0, _tgH, UIW(15), pixelH];
	_seperator ctrlCommit 0;
	_seperator ctrlSetBackgroundColor [0,0,0,1];
	_tgH = _tgH + pixelH + UIH(0.1);
} forEach _traitConfigs;