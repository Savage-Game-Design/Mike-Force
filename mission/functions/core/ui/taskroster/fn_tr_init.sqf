/*
    File: fn_tr_init.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Opens or closes TaskRoster
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"


//////////////////////////////////////////////////////////
// DEV:

// systemchat "!! DEV: recompiling Files...";
	
	// /* TaskRoster: */
	// vn_mf_fnc_tr_cleanRightSheet = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_cleanRightSheet.sqf";
	// vn_mf_fnc_tr_init = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_init.sqf";
	// vn_mf_fnc_tr_overview_init = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_overview_init.sqf";
	// vn_mf_fnc_tr_overview_team_update = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_overview_team_update.sqf";
	
	// /* Main Info: */
	// vn_mf_fnc_tr_mainInfo_show = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_mainInfo_show.sqf";
	
	// /* Mission List */
	// vn_mf_fnc_tr_zone_change = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_zone_change.sqf";
	// vn_mf_fnc_tr_missions_fill = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_missions_fill.sqf";
	// vn_mf_fnc_tr_missions_show = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_missions_show.sqf";
	// vn_mf_fnc_tr_mission_setActive = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_mission_setActive.sqf";
	// vn_mf_fnc_tr_listboxtask_select = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_listboxtask_select.sqf";
	
	// /* Support Task Stuff */
	// vn_mf_fnc_tr_supportTask_show = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_supportTask_show.sqf";
	// vn_mf_fnc_tr_supportTask_selectTask = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_supportTask_selectTask.sqf";
	// vn_mf_fnc_tr_supportTask_selectTeam = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_supportTask_selectTeam.sqf";
	// vn_mf_fnc_tr_supportTask_selectPosition = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_supportTask_selectPosition.sqf";
	// vn_mf_fnc_tr_supportTask_selectPosition_accept = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_supportTask_selectPosition_accept.sqf";
	// vn_mf_fnc_tr_supportTask_create = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_supportTask_create.sqf";
	// vn_mf_fnc_tr_supportTask_map_hide = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_supportTask_map_hide.sqf";
	// vn_mf_fnc_tr_getMapPosClick = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_getMapPosClick.sqf";
	
	// /* Team selection */
	// vn_mf_fnc_tr_selectTeam = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_selectTeam.sqf";
	// vn_mf_fnc_tr_selectTeam_init = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_selectTeam_init.sqf";
	// vn_mf_fnc_tr_selectTeam_set = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_selectTeam_set.sqf";
	
	// /* Character Info */
	// vn_mf_fnc_tr_characterInfo_show = compile preprocessFileLineNumbers "functions\ui\taskroster\fn_tr_characterInfo_show.sqf";

// systemchat "!! DEV: recompiling Files... DONE";
 
//////////////////////////////////////////////////////////

//check if closing or opening the TR
if(isNull VN_DISP_TR_TASKROSTER)then
{
	//open TaskRoster
	createDialog "vn_tr_disp_taskRoster_Main";
}else{
	//close TaskRoster
	closeDialog VN_IDD_TR_TASKROSTER;
};

