/*
	File: fn_tr_tasks_init.sqf
	Author: Terra
	Date: 2022-01-23
	Last Update: 2022-01-23
	Public: No

	Description:
		Loads the taskroster page for tasks.
	
	Parameter(s):
		none
	
	Returns:
		nothing
	
	Example(s):
		[] call vn_mf_fnc_tr_tasks_init;
*/
#include "..\..\..\..\config\ui\ui_def_base.inc"

[] call vn_mf_fnc_tr_cleanRightSheet;
[VN_TR_TABTASKS_CTRL] call vn_mf_fnc_tr_tabs_toggle;
VN_TR_TASKS_CTRL ctrlShow true;

private _iconAttack = "\a3\ui_f\data\GUI\Cfg\CommunicationMenu\attack_ca.paa";

// Load main tasks into view
tvClear VN_TR_TASKS_TREEMAINTASKLIST_CTRL;
private _task = player call BIS_fnc_taskCurrent;
if (_task call BIS_fnc_taskExists) then {
	_task call BIS_fnc_taskDescription apply {_x select 0} params ["_description", "_title", "_marker"];
	private _taskZone = _task call BIS_fnc_taskParent;
	_taskZone call BIS_fnc_taskDescription apply {_x select 0} params ["_descriptionParent", "_titleParent", "_markerParent"];
	private _index = VN_TR_TASKS_TREEMAINTASKLIST_CTRL tvAdd [[], _titleParent];
	VN_TR_TASKS_TREEMAINTASKLIST_CTRL tvSetPicture [[_index], "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\default_ca.paa"];
	VN_TR_TASKS_TREEMAINTASKLIST_CTRL tvSetCurSel [_index];
	VN_TR_TASKS_TREEMAINTASKLIST_CTRL tvSetData [[_index], _taskZone];
	private _index = VN_TR_TASKS_TREEMAINTASKLIST_CTRL tvAdd [[_index], _title];
	VN_TR_TASKS_TREEMAINTASKLIST_CTRL tvSetPicture [[_index, _index], _iconAttack];
	VN_TR_TASKS_TREEMAINTASKLIST_CTRL tvSetData [[_index, _index], _task];
	VN_TR_TASKS_TREEMAINTASKLIST_CTRL tvSetTooltip [[_index, _index], "Show on map"];
	tvExpandAll VN_TR_TASKS_TREEMAINTASKLIST_CTRL;
} else {
	VN_TR_TASKS_TREEMAINTASKLIST_CTRL tvAdd [[], localize "STR_vn_mf_tr_tasks_please_select_zone"];
};


// Load support requests
private _supportTasks = vn_mf_tasks select {"support" in (_x#0)};
lbClear VN_TR_TASKS_SUPPORTTASKS_CTRL;
if (count _supportTasks == 0) then {
	VN_TR_TASKS_SUPPORTTASKS_CTRL lbAdd "No support tasks";
} else {
	{
		_x params ["_task", "_location"];
		(flatten (_task call BIS_fnc_taskDescription)) params ["", "_title", "_marker"];
		private _pos = _location getVariable "supportrequestpos";
		private _index = VN_TR_TASKS_SUPPORTTASKS_CTRL lbAdd _title;
		private _distance = round(getPos player distance _pos);
		VN_TR_TASKS_SUPPORTTASKS_CTRL lbSetData [_index, _task];
		VN_TR_TASKS_SUPPORTTASKS_CTRL lbSetTextRight [_index, format["%1 m", _distance]];
		VN_TR_TASKS_SUPPORTTASKS_CTRL lbSetValue [_index, _distance];
		private _requester = _location getVariable "supportrequestplayer";
		private _requesterGroup = _requester getVariable ["vn_mf_db_player_group", "MikeForce"];
		getArray (missionConfigFile >> "gamemode" >> "settings" >> "teams" >> _requesterGroup) params ["", "_groupIconRequester"];
		VN_TR_TASKS_SUPPORTTASKS_CTRL lbSetPicture [_index, _groupIconRequester];
		diag_log [_requester, _requesterGroup, _groupIconRequester];
	} forEach _supportTasks;
};

// Prevent multiple executions of code that should only run when the dislay is opened
if (VN_TR_TASKS_CTRL getVariable ["initialized", false]) exitWith {};

// Update right page when selection changes
VN_TR_TASKS_TREEMAINTASKLIST_CTRL ctrlAddEventHandler ["TreeSelChanged",{
	params ["", "_selectionPath"];
	private _task = VN_TR_TASKS_TREEMAINTASKLIST_CTRL tvData _selectionPath;
	if (_task call BIS_fnc_taskExists) then {
		private _mainTask = if (count _selectionPath == 1) then {
			_task
		} else {
			_task call BIS_fnc_taskParent
		};
		(flatten (_task call BIS_fnc_taskDescription)) params ["_description", "_title", "_marker"]; // For some reason the task's description is an array of arrays with one element each
		VN_TR_TASKS_TASKTITLE_CTRL ctrlSetText _title;
		VN_TR_TASKS_TASKDESCRIPTION_CTRL ctrlSetText _description;
		private _taskPosition = _task call BIS_fnc_taskDestination;
		if (objNull in _taskPosition) then {
			// Main tasks have no destination, use the marker instead
			_taskPosition = getMarkerPos _marker;
		};
		VN_TR_TASKS_TASKDISTANCE_CTRL ctrlSetText format ["%1 m", (player distance _taskPosition)];
		private _taskLocation = vn_mf_tasks select (vn_mf_tasks findIf {_x#0 == _mainTask}) select 1;
		VN_TR_TASKS_POLAROID_CTRL ctrlSetText (getText (_taskLocation getVariable "taskconfig" >> "taskimage"));
		VN_TR_TASKS_ZONEMAP_CTRL ctrlMapAnimAdd [0.1, 0.25, _taskPosition];
		ctrlMapAnimCommit VN_TR_TASKS_ZONEMAP_CTRL;
	} else {
		{
			_x ctrlSetText "";
		} forEach [
			VN_TR_TASKS_TASKTITLE_CTRL,
			VN_TR_TASKS_TASKDESCRIPTION_CTRL,
			VN_TR_TASKS_TASKDISTANCE_CTRL
		];
	};
}];
// Select the first entry by default
VN_TR_TASKS_TREEMAINTASKLIST_CTRL tvSetCurSel [0];

// Eventhandler to open map on double click with the task location centered
VN_TR_TASKS_TREEMAINTASKLIST_CTRL ctrlAddEventHandler ["TreeDblClick", {
	params ["", "_selectionPath"];
	private _task = VN_TR_TASKS_TREEMAINTASKLIST_CTRL tvData _selectionPath;
	if (_task call BIS_fnc_taskExists) then {
		private _destination = _task call BIS_fnc_taskDestination;
		_destination spawn {
			closeDialog 0;
			openMap true;
			private _ctrlMap = findDisplay IDD_MAIN_MAP displayCtrl IDC_MAP;
			_ctrlMap ctrlMapAnimAdd [1, 0.15, _this];
			ctrlMapAnimCommit _ctrlMap;
		};
	};
}];

// UIEH for the support tasks
VN_TR_TASKS_SUPPORTTASKS_CTRL ctrlAddEventHandler ["LBSelChanged", {
	params ["", "_index"];
	private _task = VN_TR_TASKS_SUPPORTTASKS_CTRL lbData _index;
	vn_mf_tasks select (vn_mf_tasks findIf {_x#0 == _task}) params ["", "_location"];
	private _taskPosition = _location getVariable "supportrequestpos";
	VN_TR_TASKS_ZONEMAP_CTRL ctrlMapAnimAdd [0.1, 0.25, _taskPosition];
	ctrlMapAnimCommit VN_TR_TASKS_ZONEMAP_CTRL;
	private _taskConfig = _location getVariable "taskconfig";
	private _image = getText(_taskConfig >> "image");
	private _title = getText(_taskConfig >> "tasktitle");
	VN_TR_TASKS_TASKTITLE_CTRL ctrlSetText _title;
	diag_log [_taskConfig, _image];
}];
// Select first entry
VN_TR_TASKS_CTRL lbSetCurSel 0;


VN_TR_TASKS_CTRL setVariable ["initialized", true];
