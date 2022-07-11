/*
    File: fn_tr_supportTask_selectTask.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Called by Listbox "onLBSelChanged".
		Support Request Teams will be updated, depending on the selected Missions.
    
    Parameter(s):
		_0 - List-/Combobox control [Control]
		_1 - List-/Combobox selected Index (list of Tasknames) [Number]
    
    Returns: nothing
    
    Example(s):
		onLBSelChanged = "_this call vn_mf_fnc_tr_supportTask_selectTask; false;"
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"

private _display = ctrlParent (_this#0);
//get selected Index of ctrl
private _index = _this#1;

//disable "Create new support Task" (all requirements must be met, before it get's enabled)
VN_TR_SUPREQ_CTASK_CTRL ctrlEnable false;
//reset Map position (if Team or Mission selection has changed)
VN_TR_SUPREQ_SELPOS_CTRL ctrlSetText "Select Position";

//Get the data from the selected Index
private _supportClassname = VN_TR_SUPREQ_TASK_CTRL lnbData [_index,0];
//update temporary data
vn_tr_supportMissionInfo = [_supportClassname,[],[]];

//get the Teams-List-/Combobox and clear it
_ctrl_availableTeams = VN_TR_SUPREQ_TEAM_CTRL;
lnbclear _ctrl_availableTeams;
//get the Teams, who are able to be assigned to the selected Task
//ret: Array with configName of allowed Teams for that Task
_teamsToAssign = getArray(missionConfigFile >> "gamemode" >> "tasks" >> _supportClassname >> "taskgroups");
_taskDesc = getText(missionConfigFile >> "gamemode" >> "tasks" >> _supportClassname >> "requesterDesc");
VN_TR_SUPREQ_DESC_TXT_CTRL ctrlSetStructuredText parseText _taskDesc;
//Fill the List-/Combobox with the Teams
{
	private _groupConfig = (missionConfigFile >> "gamemode" >> "teams" >> _x);
	private _groupNameFull = getText(_groupConfig >> "name");
	private _groupIcon = getText(_groupConfig >> "icon");
	private _groupName = getText(_groupConfig >> "shortname");
	
	private _index = _ctrl_availableTeams lnbAddRow ["",_groupName];
	_ctrl_availableTeams lnbSetData [[_index,0], _x];
	_ctrl_availableTeams lnbSetPicture [[_index,0],I];

} forEach _teamsToAssign;
_ctrl_availableTeams lbSetCurSel 0;