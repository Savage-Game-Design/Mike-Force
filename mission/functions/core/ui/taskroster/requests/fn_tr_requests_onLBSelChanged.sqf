#include "..\..\..\..\..\config\ui\ui_def_base.inc"

params ["_ctrl", "_rowIndex"];
if (_rowIndex isEqualTo -1) exitWith {};

private _rowId = VN_TR_REQUESTS_TAB_LIST_CTRL ctValue _rowIndex;
private _tasks = VN_TR_REQUESTS_TAB_LIST_CTRL getVariable ["tasks", []];
private _taskIndex = _tasks findIf { _x#0 isEqualTo _rowId };

if (_taskIndex isEqualTo -1) exitWith {};

VN_TR_REQUESTS_TAB_DETAILS_CTRL ctrlShow true;
VN_TR_REQUESTS_TAB_DETAILS_CTRL ctrlEnable true;

{
  _x ctrlShow false;
} forEach [
  VN_TR_REQUESTS_TAB_ACCEPT_BT_CTRL,
  VN_TR_REQUESTS_TAB_ACCEPT_BB_CTRL,
  VN_TR_REQUESTS_TAB_ACCEPT_BL_CTRL,
  VN_TR_REQUESTS_TAB_ACCEPT_BR_CTRL,
  VN_TR_REQUESTS_TAB_DISMISS_BT_CTRL,
  VN_TR_REQUESTS_TAB_DISMISS_BB_CTRL,
  VN_TR_REQUESTS_TAB_DISMISS_BL_CTRL,
  VN_TR_REQUESTS_TAB_DISMISS_BR_CTRL
];

private _task = _tasks#_taskIndex;
_task params [
  "_id",
  "_team",
  "_configName",
  "_Distance",
  "_selected",
  "_acknowledged",
  "_position",
  "_requestedAt",
  "_acceptCount"
];

VN_TR_REQUESTS_TAB_LIST_CTRL setVariable ["selectedTaskId", _id];

// Update right page
private _config = missionconfigfile >> "gamemode" >> "tasks" >> _configName;
private _image = getText (_config >> "taskimage");
if (_image isEqualTo "") then {
  _image = "\vn\missions_f_vietnam\data\img\mikeforce\su\vn_ui_mf_task_mfs1.jpg";
};

private _description = getText (_config >> "taskdesc");
// TODO: private _data = [/* ??? */] call compile getText (_config >> "taskformatdata");
private _data = [];
private _minutes = ceil ((diag_tickTime - _requestedAt) / 60);

VN_TR_REQUESTS_TAB_MAP_CTRL ctrlMapAnimAdd [1, 0.1, _position];
ctrlMapAnimCommit VN_TR_REQUESTS_TAB_MAP_CTRL;

VN_TR_REQUESTS_TAB_THUMBNAIL_CTRL ctrlSetText _image;
VN_TR_REQUESTS_TAB_DESCRIPTION_CTRL ctrlSetText _description;
// VN_TR_REQUESTS_TAB_DESCRIPTION_CTRL ctrlSetText (format ([_description] + _data));
// TODO: VN_TR_REQUESTS_TAB_CONDITIONS_CTRL

ctClear VN_TR_REQUESTS_TAB_CONDITIONS_CTRL;
{
  private _row = ctAddRow VN_TR_REQUESTS_TAB_CONDITIONS_CTRL;
  _row params ["_rowIndex", "_row"];
  _row params [
		"_ctrlCb",
		"_ctrlDesc"
	];

  systemChat str [_forEachIndex, _x, _x#0];
  _ctrlCb cbSetChecked (_x#0);
  _ctrlDesc ctrlSetText (_x#1);
} forEach [[true, "Completed"], [false, "Not completed"]];
VN_TR_REQUESTS_TAB_CONDITIONS_CTRL ctrlEnable false;

VN_TR_REQUESTS_TAB_DISMISS_CTRL setVariable ["taskId", _id];

VN_TR_REQUESTS_TAB_ACCEPTCOUNT_CTRL ctrlShow (_acceptCount > 0);
VN_TR_REQUESTS_TAB_ACCEPTCOUNT_CTRL ctrlSetText format ["Already accepted by %1 player(s) /loc", _acceptCount];

VN_TR_REQUESTS_TAB_REQUESTEDAT_CTRL ctrlSetText format ["Requested %1 minute(s) ago by %2 /loc", _minutes, _Distance];

for "_i" from 0 to (ctRowCount VN_TR_REQUESTS_TAB_LIST_CTRL) - 1 do {
  (VN_TR_REQUESTS_TAB_LIST_CTRL ctRowControls _i) params [
    "_ctrlBackground",
    "_ctrlHoverMarkerTop",
    "_ctrlHoverMarkerBottom",
    "_ctrlHoverMarkerLeft",
    "_ctrlHoverMarkerRight",
    "_ctrlTeamIconPulseBg",
    "_ctrlTeamIconBlk",
    "_ctrlTeamIconClr",
    "_ctrlTeamIconFullClr",
    "_ctrlTitle",
    "_ctrlDistance",
    "_ctrlQuickAction",
    "_ctrlSelectionMarker"
  ];
  
  private _isSelected = _i isEqualTo _rowIndex;
  _ctrlSelectionMarker ctrlShow _isSelected;
  _ctrlTeamIconFullClr ctrlShow _isSelected;

  if (_isSelected) then {
    {
      _x ctrlShow false;
    } forEach [
      _ctrlHoverMarkerTop,
      _ctrlHoverMarkerBottom,
      _ctrlHoverMarkerLeft,
      _ctrlHoverMarkerRight
    ];
  };
};

{
  _x params [
    "_id",
    "_team",
    "_configName",
    "_Distance",
    "_selected",
    "_acknowledged",
    "_position",
    "_requestedAt",
    "_acceptCount"
  ];

  _tasks set [_forEachIndex, [
    _id,
    _team,
    _configName,
    _Distance,
    false,
    _acknowledged,
    _position,
    _requestedAt,
    _acceptCount
  ]];
} forEach _tasks;

_tasks set [_taskIndex, [
  _id,
  _team,
  _configName,
  _Distance,
  _selected,
  true,
  _position,
  _requestedAt,
  _acceptCount
]];

VN_TR_REQUESTS_TAB_ACCEPT_CTRL ctrlRemoveAllEventHandlers "ButtonClick";
VN_TR_REQUESTS_TAB_DISMISS_CTRL ctrlRemoveAllEventHandlers "ButtonClick";

VN_TR_REQUESTS_TAB_ACCEPT_CTRL ctrlEnable true;
VN_TR_REQUESTS_TAB_ACCEPT_CTRL ctrlShow true;
VN_TR_REQUESTS_TAB_DISMISS_CTRL ctrlEnable true;
VN_TR_REQUESTS_TAB_DISMISS_CTRL ctrlShow true;
VN_TR_REQUESTS_TAB_INFO_CTRL ctrlShow false;

VN_TR_REQUESTS_TAB_ACCEPT_CTRL setVariable ["rowIndex", _rowIndex];
VN_TR_REQUESTS_TAB_ACCEPT_CTRL ctrlAddEventHandler ["ButtonClick", {
  VN_TR_REQUESTS_TAB_ACCEPT_CTRL ctrlEnable false;
  VN_TR_REQUESTS_TAB_ACCEPT_CTRL ctrlShow false;

  VN_TR_REQUESTS_TAB_DISMISS_CTRL ctrlEnable false;
  VN_TR_REQUESTS_TAB_DISMISS_CTRL ctrlShow false;

  VN_TR_REQUESTS_TAB_INFO_CTRL ctrlShow true;

  VN_TR_REQUESTS_TAB_LIST_CTRL ctRemoveRows [VN_TR_REQUESTS_TAB_ACCEPT_CTRL getVariable "rowIndex"];
  // TODO: Add request to the Task Menu
}];
VN_TR_REQUESTS_TAB_DISMISS_CTRL ctrlAddEventHandler ["ButtonClick", {
  VN_TR_REQUESTS_TAB_DETAILS_CTRL ctrlShow true;
  VN_TR_REQUESTS_TAB_DETAILS_CTRL ctrlEnable true;
  _this call vn_mf_fnc_tr_requests_onDismiss;
}];

// Dismiss hover
VN_TR_REQUESTS_TAB_DISMISS_CTRL ctrlAddEventHandler ["MouseEnter", {
  {
    _x ctrlShow true;
  } forEach [
    VN_TR_REQUESTS_TAB_DISMISS_BT_CTRL,
    VN_TR_REQUESTS_TAB_DISMISS_BB_CTRL,
    VN_TR_REQUESTS_TAB_DISMISS_BL_CTRL,
    VN_TR_REQUESTS_TAB_DISMISS_BR_CTRL
  ];
}];

VN_TR_REQUESTS_TAB_DISMISS_CTRL ctrlAddEventHandler ["MouseExit", {
  {
    _x ctrlShow false;
  } forEach [
    VN_TR_REQUESTS_TAB_DISMISS_BT_CTRL,
    VN_TR_REQUESTS_TAB_DISMISS_BB_CTRL,
    VN_TR_REQUESTS_TAB_DISMISS_BL_CTRL,
    VN_TR_REQUESTS_TAB_DISMISS_BR_CTRL
  ];
}];

// Accept hover
VN_TR_REQUESTS_TAB_ACCEPT_CTRL ctrlAddEventHandler ["MouseEnter", {
  {
    _x ctrlShow true;
  } forEach [
    VN_TR_REQUESTS_TAB_ACCEPT_BT_CTRL,
    VN_TR_REQUESTS_TAB_ACCEPT_BB_CTRL,
    VN_TR_REQUESTS_TAB_ACCEPT_BL_CTRL,
    VN_TR_REQUESTS_TAB_ACCEPT_BR_CTRL
  ];
}];

VN_TR_REQUESTS_TAB_ACCEPT_CTRL ctrlAddEventHandler ["MouseExit", {
  {
    _x ctrlShow false;
  } forEach [
    VN_TR_REQUESTS_TAB_ACCEPT_BT_CTRL,
    VN_TR_REQUESTS_TAB_ACCEPT_BB_CTRL,
    VN_TR_REQUESTS_TAB_ACCEPT_BL_CTRL,
    VN_TR_REQUESTS_TAB_ACCEPT_BR_CTRL
  ];
}];