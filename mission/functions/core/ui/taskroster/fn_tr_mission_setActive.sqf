/*
    File: fn_tr_mission_setActive.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Set the active mission?
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

#include "..\..\..\..\config\ui\ui_def_base.inc"


_list_index = lbCurSel VN_TR_MISSIONLIST_CTRL;

systemchat str ["_list_index",_list_index];

(vn_tr_taskList#_list_index) params["_sortOrder","_parent_category","_parent_classname","_parent"];

{
	systemchat str ["taskCompleted _x", taskCompleted _x];
	if!(taskCompleted _x)then
	{
		_task = _x;
		//Make last Childrentask active
		player setCurrentTask _task;
		//Update "Current Tasking" on the left side
		_task_title = (taskDescription _parent)#1;
		VN_TR_TASK_ACTIVE_CTRL ctrlSetText _task_title;
		_icon = getText(configFile >> "CfgTaskTypes" >> taskType _parent >> "icon");
		VN_TR_TASK_ICON_CTRL ctrlSetText _icon;
		
		
		private _task_classname = _parent call vn_mf_fnc_getTaskConfigName;
		private _taskID = _parent call vn_mf_fnc_getTaskID;
		private _task_varName = format["%1-%2", _taskID, _task_classname];
		private _task_data = missionNamespace getVariable [format ["task_%1", _task_varName], []];
		systemchat str [_task_classname, _taskID, _task_varName, _task_data];
		
	};
}forEach taskChildren _parent;