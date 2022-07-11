/*
    File: fn_tr_cleanRightSheet.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Hides all pages on the right side of the TaskRoster
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"

call vn_mf_fnc_tr_supportTask_map_hide;

_display = VN_DISP_TR_TASKROSTER;

//DISABLED! WOBBLEWOBBLE (crash)
//_ctrl_SupportTasks = VN_TR_MISSIONLIST_CTRL;
//_ctrl_SupportTasks lnbSetCurSelRow -1;

deleteMarkerLocal format["%1_missionMarker",getPlayerUID player];

{
	_x ctrlShow false;
}forEach[VN_TR_MISSIONSHEET_CTRL, VN_TR_SUPREQ_CTRL, VN_TR_CHARINFO_CTRL];

//Added as single one, so it's staying ontop, until the others are "hidden"
VN_TR_MAININFO_CTRL ctrlShow false;

{
	ctrlDelete (_display displayCtrl _x);
}forEach[VN_TR_MISSION_ACTIVATE_IDC];