/*
    File: fn_tr_supportTask_selectTeam.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Called by Listbox "onLBSelChanged".
		Assign Team to the selected Task (selected with "vn_mf_fnc_tr_supportTask_selectTask" beforehand).
    
    Parameter(s):
		_0 - List-/Combobox control [Control]
		_1 - List-/Combobox selected Index (list of Groups) [Number]
    
    Returns: nothing
    
    Example(s):
		onLBSelChanged = "_this call vn_mf_fnc_tr_supportTask_selectTeam; false;"
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"

_display = ctrlParent (_this#0);
//get selected Index of ctrl
_index = _this#1;

//disable "Create new support Task" (all requirements must be met, before it get's enabled)
VN_TR_SUPREQ_CTASK_CTRL ctrlEnable false;
//reset Map position (if Team or Mission selection has changed)
VN_TR_SUPREQ_SELPOS_CTRL ctrlSetText "Select Position";
//Classname of selected Team (i hope)
_selectedTeam = VN_TR_SUPREQ_TEAM_CTRL lnbData [_index,0];
//update temporary data
vn_tr_supportMissionInfo set [2,_selectedTeam];
