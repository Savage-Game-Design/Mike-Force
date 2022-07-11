/*
    File: fn_tr_characterInfo_show.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Called by clicking on the Playername.
		Inhides and files the Charactersheet
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"

call vn_mf_fnc_tr_supportTask_map_hide;

//"unhide" CharacterInfo Page
VN_TR_CHARINFO_CTRL ctrlShow true;

///////////// WIP /////////////

VN_TR_CHARINFO_NAME_CTRL ctrlSetText profileName;
VN_TR_CHARINFO_POINTS_CTRL ctrlSetText str(player getVariable ["vn_mf_db_rank",0]);
VN_TR_CHARINFO_RANK_CTRL ctrlSetText (rank player);

_player_id = player getVariable ["vn_mf_db_serial","0"];
VN_TR_CHARINFO_SNUM_CTRL ctrlSetText _player_id;

_taskName = (taskDescription currentTask player)#1;
if(isNil "_taskName")then
{
	VN_TR_CHARINFO_TASK_CTRL ctrlSetText "No active tasking";
}else{
	VN_TR_CHARINFO_TASK_CTRL ctrlSetText (taskDescription currentTask player)#1;
};
VN_TR_CHARINFO_WORLD_CTRL ctrlSetText worldName;
_progress = call vn_mf_fnc_points_to_next_rank;
VN_TR_CHARINFO_PROGR_CTRL ctrlSetText str(_progress);


VN_TR_CHARINFO_REWARD_TEXT_CTRL ctrlSetStructuredText parseText "<t size='0.6' font='tt2020base_vn'>Description for current Medal or Ribbon shown. More textspace blablabla roflcopter blub bla, i like trains and more stuff to add omgwtf stuff thingy</t>";
_ctrl_text ctrlCommit 0;

private _awards_cur = player getVariable ["vn_mf_db_awards",vn_mf_default_awards];
{
	//exit, when reached end of awards array
	if(_foreachIndex > count _awards_cur)exitWith{};

	private _className = _awards_cur#_foreachIndex#0;
	private _index = _awards_cur#_foreachIndex#1;
	private _cfgPath = (missionConfigFile >> "gamemode" >> "awards_config" >> _className);
	private _img_data = getArray (_cfgPath >> "levels");
	private _desc = getText (_cfgPath >> "desc");
	private _name = getText (_cfgPath >> "title");


	if(_index != -1)then
	{
		//store medal for preview Image
		_x setVariable ["medal",(_img_data#_index#0)];
		//set Ribbon
		_x ctrlSetText (_img_data#_index#1);
		// turn up color, so the player knows he earned that one.
		_x ctrlSetTextColor [0.8,0.8,0.8,1];
	}else{
		//store medal for preview Image
		_x setVariable ["medal",(_img_data#0#0)];
		//set Ribbon
		_x ctrlSetText (_img_data#0#1);
		// turn down color, as indicator that the player hasn't earned it yet.
		_x ctrlSetTextColor [0.3,0.3,0.3,0.5];
	};
	_x setVariable ["text",_desc];
	_x setVariable ["name",_name];
	_x ctrlSetToolTip localize _name;
	_x ctrlCommit 0;
}forEach
[
	 VN_TR_CHARINFO_RIBBON_1_CTRL,	VN_TR_CHARINFO_RIBBON_2_CTRL,	VN_TR_CHARINFO_RIBBON_3_CTRL,	VN_TR_CHARINFO_RIBBON_4_CTRL,	VN_TR_CHARINFO_RIBBON_5_CTRL
	,VN_TR_CHARINFO_RIBBON_6_CTRL,	VN_TR_CHARINFO_RIBBON_7_CTRL,	VN_TR_CHARINFO_RIBBON_8_CTRL,	VN_TR_CHARINFO_RIBBON_9_CTRL,	VN_TR_CHARINFO_RIBBON_10_CTRL
	,VN_TR_CHARINFO_RIBBON_11_CTRL,	VN_TR_CHARINFO_RIBBON_12_CTRL,	VN_TR_CHARINFO_RIBBON_13_CTRL,	VN_TR_CHARINFO_RIBBON_14_CTRL,	VN_TR_CHARINFO_RIBBON_15_CTRL
	,VN_TR_CHARINFO_RIBBON_16_CTRL,	VN_TR_CHARINFO_RIBBON_17_CTRL,	VN_TR_CHARINFO_RIBBON_18_CTRL,	VN_TR_CHARINFO_RIBBON_19_CTRL,	VN_TR_CHARINFO_RIBBON_20_CTRL
	,VN_TR_CHARINFO_RIBBON_21_CTRL,	VN_TR_CHARINFO_RIBBON_22_CTRL,	VN_TR_CHARINFO_RIBBON_23_CTRL,	VN_TR_CHARINFO_RIBBON_24_CTRL,	VN_TR_CHARINFO_RIBBON_25_CTRL
	,VN_TR_CHARINFO_RIBBON_26_CTRL,	VN_TR_CHARINFO_RIBBON_27_CTRL,	VN_TR_CHARINFO_RIBBON_28_CTRL,	VN_TR_CHARINFO_RIBBON_29_CTRL,	VN_TR_CHARINFO_RIBBON_30_CTRL
	,VN_TR_CHARINFO_RIBBON_31_CTRL,	VN_TR_CHARINFO_RIBBON_32_CTRL,	VN_TR_CHARINFO_RIBBON_33_CTRL,	VN_TR_CHARINFO_RIBBON_34_CTRL,	VN_TR_CHARINFO_RIBBON_35_CTRL
];
