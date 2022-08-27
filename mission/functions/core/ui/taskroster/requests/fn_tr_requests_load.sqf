#include "..\..\..\..\..\config\ui\ui_def_base.inc"
#define PULSE_R 245 / 255
#define PULSE_G 197 / 255
#define PULSE_B 66 / 255

params ["_unsorted"];

VN_TR_REQUESTS_TAB_LIST_CTRL ctrlRemoveAllEventHandlers "Unload";
VN_TR_REQUESTS_TAB_LIST_CTRL ctrlRemoveAllEventHandlers "LBSelChanged";
VN_TR_REQUESTS_TAB_LIST_CTRL ctrlRemoveAllEventHandlers "MouseMoving";
ctClear VN_TR_REQUESTS_TAB_LIST_CTRL;

// Sort the tasks
private _groups = [[], [], [], []];

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

  private _i = switch _team do {
    case "acav": {
      2
    };
    case "hornets": {
      1
    };
    case "mikeforce": {
      0
    };
    case "spiketeam": {
      4
    };
  };
  (_groups#_i) pushBack _x;
} forEach _unsorted;

private _tasks = [];
{
  private _sorted = [
    _x,
    [],
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

      _requestedAt
    },
    "DESCEND"
  ] call BIS_fnc_sortBy;

  _tasks append _sorted;
} forEach _groups;
VN_TR_REQUESTS_TAB_LIST_CTRL setVariable ["tasks", _tasks];

// Load the list
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

  private _row = ctAddRow VN_TR_REQUESTS_TAB_LIST_CTRL;
  _row params ["_rowIndex", "_row"];
  _row params [
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
  VN_TR_REQUESTS_TAB_LIST_CTRL ctSetValue [_rowIndex, _id];

  private _config = missionconfigfile >> "gamemode" >> "tasks" >> _configName;
  private _title = getText (_config >> "tasktitle");
  if (_title isEqualTo "") then {
    _title = "Help the squad /loc";
  };

  _ctrlTitle ctrlSetText _title;

  private _distance = ceil (player distance _position);
  _ctrlDistance ctrlSetText format ["%1m away /loc", _distance];

  _ctrlTeamIconPulseBg ctrlSetText "img\TaskRoster\white_circle_128.paa";
  _ctrlTeamIconBlk ctrlSetText format ["img\TaskRoster\tr_%1_white.paa", _team];
  _ctrlTeamIconClr ctrlSetText format ["img\TaskRoster\tr_%1_white.paa", _team];
  _ctrlTeamIconFullClr ctrlSetText format ["\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_%1_HL.paa", _team];
  _ctrlSelectionMarker ctrlSetText "img\TaskRoster\oval_black_512.paa";

  {
    _x ctrlShow false;
  } forEach [
    _ctrlBackground,
    _ctrlHoverMarkerTop,
    _ctrlHoverMarkerBottom,
    _ctrlHoverMarkerLeft,
    _ctrlHoverMarkerRight,
    _ctrlTeamIconFullClr,
    _ctrlSelectionMarker
  ];

  _ctrlTeamIconPulseBg ctrlSetTextColor [PULSE_R, PULSE_G, PULSE_B, 0.1];
  _ctrlTeamIconBlk ctrlSetTextColor [0, 0, 0, 1];
  _ctrlTeamIconClr ctrlSetTextColor [PULSE_R, PULSE_G, PULSE_B, 1];
  _ctrlSelectionMarker ctrlSetFade 0.5;
  _ctrlSelectionMarker ctrlCommit 0;

  _ctrlQuickAction setVariable ["taskId", _id];
  _ctrlQuickAction ctrlAddEventHandler ["ButtonClick", vn_mf_fnc_tr_requests_onDismiss];
} forEach _tasks;

// Setup hover handler
call vn_mf_fnc_tr_requests_pulse;


VN_TR_REQUESTS_TAB_DETAILS_CTRL ctrlShow false;
VN_TR_REQUESTS_TAB_DETAILS_CTRL ctrlEnable false;


// EH
VN_TR_REQUESTS_TAB_LIST_CTRL ctrlAddEventHandler ["Unload", {
  terminate VN_TR_REQUESTS_HANDLE_PULSE;
}];

VN_TR_REQUESTS_TAB_LIST_CTRL ctrlAddEventHandler ["LBSelChanged", vn_mf_fnc_tr_requests_onLBSelChanged];
VN_TR_REQUESTS_TAB_LIST_CTRL ctrlAddEventHandler ["MouseMoving", vn_mf_fnc_tr_requests_onMouseMoving];

private _selectedTaskId = VN_TR_REQUESTS_TAB_LIST_CTRL getVariable ["selectedTaskId", -1];
private _taskIndex = _tasks findIf { _x#0 isEqualTo _selectedTaskId };
VN_TR_REQUESTS_TAB_LIST_CTRL ctSetCurSel _taskIndex;
