/*
    File: fn_tr_supportTask_create.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Deletes the controls, that were created by the SupportTask "Position Selection"-Menu.
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s):
		call vn_mf_fnc_tr_supportTask_map_hide
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"

private _display = VN_DISP_TR_TASKROSTER;

{
	ctrlDelete _x;
}forEach [VN_TR_SUPREQ_MAP_CTRL, VN_TR_SUPREQ_ACCEPT_CTRL, VN_TR_SUPREQ_ABORT_CTRL];

VN_TR_SUPREQ_SELPOS_CTRL ctrlenable true;