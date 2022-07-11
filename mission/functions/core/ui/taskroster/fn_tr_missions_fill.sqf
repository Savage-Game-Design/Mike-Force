/*
    File: fn_tr_missions_fill.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Fills the TaskRoster Mission Overview with the Parent-/Maintasks. Children will be handled in "vn_mf_fnc_tr_missions_show"
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"


private _ctrlSupportTasks = VN_TR_MISSIONLIST_CTRL;
lbclear _ctrlSupportTasks;


vn_mf_fnc_getTaskConfigName =
{
	//BigBadButchery...
	private _taskname = str _this;
	//BUTTCCHHHEERR IIITTTTT
	private _taskConfigName_stripped_taskID = _taskname select [(_taskname find "-") + 1];
    private _ret = _taskConfigName_stripped_taskID select [0, (_taskConfigName_stripped_taskID find " (")];
	_ret
};

vn_mf_fnc_getTaskID =
{
	//BigBadButchery...
	private _taskname = str _this;
	//BUTTCCHHHEERR IIITTTTT
	private _ret = _taskName select [5,((_taskname find "-")-5)];
	_ret
};

vn_tr_taskList = [];
{
	_task = _x;		//Type: Task (not String/Array or anything else. Type: TASK)
	private _taskParent = taskParent _task;
	
	// [Task 1:primary_2b (id 8),Task 1:primary_2b_build_aid_post (id 9),Task 5:primary_6a (id 10),Task 5:primary_6a_defend_village (id 11)]
	//["1:primary_2b","2:secondary_mf3","3:secondary_st3","4:secondary_gh1","5:primary_6a","6:secondary_mf3","7:secondary_st3","8:secondary_gh1","9:secondary_gh6","10:secondary_gh6"]
	private _taskStatus = taskCompleted _task;
	//only get taskParents
	if((isNull _taskParent) && {!_taskStatus})then
	{
		
		//butchering the string, to get the Classname... don't like it, but atm, i do not know any other way.
		//"task " = 5 || -5 = select [startIndex, "steps forward"];
		private _task_classname = _task call vn_mf_fnc_getTaskConfigName;
		private _taskID = _task call vn_mf_fnc_getTaskID;
		private _task_varName = format["%1-%2", _taskID, _task_classname];
		private _task_data = missionNamespace getVariable [format ["task_%1", _task_varName], []];
		//Don't add, if Mission is in a different Zone.
		private _zoneName = _task_data#0;
		
		private _lnbindex = _ctrlSupportTasks lnbAddRow ["","","",(taskDescription _task)#1];
		_ctrlSupportTasks lnbSetPicture					[ [_lnbindex, 1], getText(configFile >> "CfgTaskTypes" >> taskType _task >> "icon")];
		
		//store the taskname (if clicked on "Current Tasking" -> Select Index of mission)
		_ctrlSupportTasks lnbSetData [[_lnbindex, 1], str(_task)];
		
		//get Task category
		private _task_category = getText(missionConfigFile >> "gamemode" >> "tasks" >> _task_classname >> "taskcategory");
		//Backup: Colors: VN_TR_MISS_PRIM - VN_TR_MISS_SECO - VN_TR_MISS_SUPP
		private _typeData = switch(_task_category)do
		{
			case "PRI":	{[0, "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_primary.paa"]};
			case "SEC":	{[50, "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_secondary.paa"]};
			case "SUP":	{[100, "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_support.paa"]};
			default {[1, "Vn\ui_f_vietnam\ui\debrief\sticky.paa"]};
		};
		private _orderValue = (_typeData#0)+_forEachIndex;
		_ctrlSupportTasks lnbSetValue					[ [_lnbindex, 0],	_orderValue];	//order value - used for sorting by Mission Type
		_ctrlSupportTasks lnbSetPicture					[ [_lnbindex, 0],	(_typeData#1)];
		_ctrlSupportTasks lnbSetPictureColor 			[ [_lnbindex, 0],	vn_mf_tr_zone_active_cur_color];
		_ctrlSupportTasks lnbSetPictureColorSelected	[ [_lnbindex, 0],	vn_mf_tr_zone_active_cur_color];
		//Set the data for missions_fill, to be loaded in the mission-Infosheet
		vn_tr_taskList pushback [_orderValue, _task_category, _task_classname, _task];
	};
}forEach simpleTasks player;

vn_tr_taskList sort true;

_ctrlSupportTasks lnbSortByValue [0, false];
_ctrlSupportTasks lnbSetCurSelRow -1;