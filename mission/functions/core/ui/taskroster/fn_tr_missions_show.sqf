/*
    File: fn_tr_missions_show.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Called by Listbox "onLBSelChanged"
		Loads and fills the Mission Overview for the select Mission in the TaskRoster Mission Overview
    
    Parameter(s):
		_ (_ctrlSupportTasks) - Not used [Control, defaults to controlNull]
		_list_index - Index [Number, defaults to -1]
    
    Returns: nothing
    
    Example(s):
		onLBSelChanged = "_this call vn_mf_fnc_tr_missions_show;
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"

call vn_mf_fnc_tr_cleanRightSheet;

params[
				 ["_ctrlSupportTasks",controlNull,[controlNull]]	//Not used
				,["_list_index",-1,[0]]
			];
private _display = VN_DISP_TR_TASKROSTER;
//"unhide" Missionsheet
VN_TR_MISSIONSHEET_CTRL ctrlShow true;

_ctrl_missionPage_map = VN_TR_MISSION_MAP_CTRL;
_ctrl_missionPage_map ctrlEnable false;	//incase of wobblewobble. Probably not needed, but doesn't hurt to have.
VN_TR_MISSION_PIC_CTRL ctrlEnable false;

if (_list_index < 0)exitWith
{
	//cleanup, incase a mission Sheet was already open and the player has no active Mission (old one would remain open, maybe confusing for some peeps)
	call vn_mf_fnc_tr_cleanRightSheet;
	call vn_mf_fnc_tr_mainInfo_show;
	
	//get active Mission from list and set the listSelection to that row, to trigger the list autoexecutestuffthingygnaahhhh.... i hate describing that stuff...
	private _task = if(currentTask player isEqualTo taskNull)then{taskNull}else{taskParent currentTask player};
	if(isNull _task)exitWith{};
	
	private _ActiveTask = str(_task);
	for "_i" from 0 to ((lnbSize VN_TR_MISSIONLIST_CTRL)#0)-1 do
	{
		if ( (VN_TR_MISSIONLIST_CTRL lnbData [_i,1]) isEqualTo _ActiveTask)exitWith{ VN_TR_MISSIONLIST_CTRL lnbSetCurSelRow _i; };
	};
};

//try to get background img
private _missionPage_main_background_image = VN_TR_MISSIONLIST_CTRL lnbData [_list_index, 0];
//if "new" -> Assign a background img to the selected index (will be reassigned/redone, when the player reopens the TaskRoster, so it's just an "eye gimmick")
if(_missionPage_main_background_image isEqualTo "")then
{
	_missionPage_main_background_image = selectRandom [
		"\vn\ui_f_vietnam\ui\taskroster\img\tr_missionsheet_P_M_1.paa",
		"\vn\ui_f_vietnam\ui\taskroster\img\tr_missionsheet_P_M_2.paa",
		"\vn\ui_f_vietnam\ui\taskroster\img\tr_missionsheet_P_M_3.paa"
	];
	//set the Bg Img as fixed, as long as the TR is openend
	VN_TR_MISSIONLIST_CTRL lnbSetData [[_list_index, 0], _missionPage_main_background_image];
};
VN_TR_MISSIONSHEET_IMG_CTRL ctrlSetText _missionPage_main_background_image;
VN_TR_MISSIONSHEET_TASKS_CTRL ctrlSetStructuredText parseText "Tasks:";
lbClear VN_TR_MISSIONSHEET_TASKS_LIST_CTRL;
(vn_tr_taskList#_list_index) params["_sortOrder","_parent_category","_parent_classname","_parent"];
{
	(taskDescription _x) params ["_taskDesc", "_taskTitle", "_taskWpDesc"];
	private _ind = VN_TR_MISSIONSHEET_TASKS_LIST_CTRL lbAdd _taskTitle;
	private _taskIcon = ["\vn\ui_f_vietnam\ui\taskroster\img\box_unchecked.paa", "\vn\ui_f_vietnam\ui\taskroster\img\box_checked.paa"] select taskCompleted _x;
	if (currentTask player == _x) then {
		VN_TR_MISSIONSHEET_TASKS_LIST_CTRL lbSetCurSel _ind;
	};
	VN_TR_MISSIONSHEET_TASKS_LIST_CTRL lbSetPicture [_ind, _taskIcon];
	VN_TR_MISSIONSHEET_TASKS_LIST_CTRL setVariable [format ["taskIndex%1", _ind], _x];
}forEach taskChildren _parent;
_imgPath = getText(missionconfigfile >> "gamemode" >> "tasks" >> _parent_classname >> "taskimage");
if(_imgPath == "")then{_imgPath = "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_secondary.paa";};	//If nothing found -> load Placeholder
VN_TR_MISSION_PIC_CTRL ctrlSetText _imgPath;
//--- Load right page
[VN_TR_MISSIONLIST_CTRL, _list_index] call vn_mf_fnc_tr_listboxtask_select;