/*
    File: fn_tr_supportTask_show.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Fills the TaskRosters "Request Support Mission"-List
		Filtered by Teams
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s):
		call vn_mf_fnc_tr_supportTask_show
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"

//[] spawn vn_mf_fnc_tr_supportTask_map_hide;
call vn_mf_fnc_tr_supportTask_map_hide;


VN_TR_SUPREQ_CTASK_CTRL ctrlEnable false;
//"unhide" supportRequest Page
VN_TR_SUPREQ_CTRL ctrlShow true;

//Var for Missions
//["TeamName","Type",[Coords]]
vn_tr_supportMissionInfo = ["",[],[]];

//fill "Team" dropDownMenu
_ctrl_taskSelection = VN_TR_SUPREQ_TASK_CTRL;
lnbClear _ctrl_taskSelection;

_groupID = player getVariable ["vn_mf_db_player_group", "FAILED"];
_classes = "true" configClasses (missionConfigFile >> "gamemode" >> "tasks");
{
	//check if Supporttask
	if(getText(_x >> "taskcategory") isEqualTo "SUP")then
	{
		//check if current player group can request this mission
		if(_groupID in getArray(_x >> "requestgroups"))then
		{
			_task_name = getText(_x >> "taskname");
			_task_type = getText(_x >> "tasktype");
			_task_icon = getText(configFile >> "CfgTaskTypes" >> _task_type >> "icon");
			
			_index = _ctrl_taskSelection lnbAddRow ["",_task_name];
			_ctrl_taskSelection lnbSetPicture [[_index,0], _task_icon];
			_ctrl_taskSelection lnbSetData [[_index,0], (configName _x)];
			systemchat str [_index, _task_name, _task_type, _task_icon, (_ctrl_taskSelection lnbData [_index,0])];
		};
	};
} forEach _classes;
_ctrl_taskSelection lbSetCurSel 0;
