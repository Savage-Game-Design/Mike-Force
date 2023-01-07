/*
    File: fn_tr_overview_init.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Loaded by Taskroster onLoad.
		Updates all the controls in the TaskRoster mainView and hides everything, that is not active/used in the "initial state".
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"



//cleanup everything
call vn_mf_fnc_tr_cleanRightSheet;
//show Main Info Screen on the right Side
call vn_mf_fnc_tr_mainInfo_show;
call vn_mf_fnc_tr_missions_fill;


//set Username
[VN_TR_USERNAME_CTRL, profileName] call vn_fnc_UI_checkFontSize;
VN_TR_USERNAME_CTRL ctrlSetText profileName;

//Check which group the player is in
private _groupID = player getVariable ["vn_mf_db_player_group", "FAILED"];

systemchat str ["_groupID: ",_groupID];
private _group_config = (missionConfigFile >> "gamemode" >> "teams" >> _groupID);
private _group_name_full = getText(_group_config >> "name");
private _group_icon = getText(_group_config >> "icon");
//set name and logo of the Team, the player is in

[VN_TR_TEAMNAME_CTRL, (_group_name_full)] call vn_fnc_UI_checkFontSize;
VN_TR_TEAMNAME_CTRL ctrlSetText _group_name_full;
VN_TR_TEAMLOGO_CTRL ctrlSetText _group_icon;


// private _task =  taskParent currentTask player;	//A3-Crash since 1.99 - needs to be revised at a later point
private _task = if(currentTask player isEqualTo taskNull)then{taskNull}else{taskParent currentTask player};
if(!isNull _task)then
{
	private _task_title = (taskDescription _task)#1;
	VN_TR_TASK_ACTIVE_CTRL ctrlSetText _task_title;
	
	private _icon = getText(configFile >> "CfgTaskTypes" >> taskType _task >> "icon");
	VN_TR_TASK_ICON_CTRL ctrlSetText _icon;
	
	// private _task_classname = _task call vn_mf_fnc_getTaskConfigName;
	// private _taskID = _task call vn_mf_fnc_getTaskID;
	// private _task_varName = format["%1:%2", _taskID, _task_classname];
	// private _task_data = missionNamespace getVariable [format ["task_%1", _task_varName], []];
	// /* get Task category */
	// private _task_category = getText(missionConfigFile >> "gamemode" >> "tasks" >> _task_classname >> "taskcategory");
	// if(_task_category in ["PRI","SEC"])then
	// {
		// VN_TR_TASK_ICON_CTRL ctrlSetTextColor vn_mf_tr_zone_active_cur_color;
		// VN_TR_TASK_ACTIVE_CTRL ctrlSetTextColor vn_mf_tr_zone_active_cur_color;
	// }else{
		// VN_TR_TASK_ICON_CTRL ctrlSetTextColor VN_TR_MISS_SUPP;
		// VN_TR_TASK_ACTIVE_CTRL ctrlSetTextColor VN_TR_MISS_SUPP;
	// };
};

//set Zone names and setup the Ctrl with the proper Filter
private _activeZoneNames = missionNamespace getVariable ["mf_g_dir_activeZoneNames", []];

{
	if(_forEachIndex > (count _activeZoneNames) -1)then
	{
		_x ctrlSetText "";
		_x setVariable ["activeZone",""];
		_x setVariable ["selectedZone",""];
		_x ctrlSetEventhandler ["buttonClick",""];
		_x ctrlSetTextColor [0,0,0,0];
	}else{
		private _curZoneData = _activeZoneNames # _forEachIndex;
		private _markerText = markerText _curZoneData;
		private _zoneName = if(isLocalized _markerText)then{localize _markerText}else{_markerText};
		_x ctrlSetText _zoneName;
		_x setVariable ["activeZone",_markerText];
		_x setVariable ["selectedZone",_curZoneData];
		_x ctrlSetEventhandler ["buttonClick","_this call vn_mf_fnc_tr_zone_change;"];
		
		if(vn_mf_tr_zone_filter isEqualTo _curZoneData)then
		{
			_x ctrlSetTextColor [0,0,0,1];
		}else{
			_x ctrlSetTextColor [0,0,0,0.2];
		};
	};
}forEach[VN_TR_ZONE_A_CTRL, VN_TR_ZONE_B_CTRL];

//If nothing is set (gamestart) -> Autoselect the first Zone.
if(isNil "vn_mf_tr_zone_filter") then {[VN_TR_ZONE_A_CTRL] call vn_mf_fnc_tr_zone_change;};
