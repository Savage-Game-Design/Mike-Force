#include "..\..\..\..\..\config\ui\ui_def_base.inc"

if (!isNil "VN_TR_REQUESTS_HANDLE_PULSE") then {
  terminate VN_TR_REQUESTS_HANDLE_PULSE;
};

#define PULSE_LENGTH 0.6
#define PULSE_WAIT 0.4

VN_TR_REQUESTS_HANDLE_PULSE = [] spawn {
  while { true } do {
    private _blinkCtrls = [];
    private _tasks = VN_TR_REQUESTS_TAB_LIST_CTRL getVariable ["tasks", []];

    for '_rowIndex' from 0 to (ctRowCount VN_TR_REQUESTS_TAB_LIST_CTRL) - 1 do {
      private _rowId = VN_TR_REQUESTS_TAB_LIST_CTRL ctValue _rowIndex;
      private _taskIndex = _tasks findIf { _x#0 isEqualTo _rowId };

      private _shouldBlink = false;
      (VN_TR_REQUESTS_TAB_LIST_CTRL ctRowControls _rowIndex) params [
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

      // Hide
      _ctrlTeamIconPulseBg ctrlSetFade 1;
      _ctrlTeamIconPulseBg ctrlCommit 0;
      _ctrlTeamIconBlk ctrlSetFade 0;
      _ctrlTeamIconBlk ctrlCommit 0;
      _ctrlTeamIconClr ctrlSetFade 1;
      _ctrlTeamIconClr ctrlCommit 0;

      if (_taskIndex isNotEqualTo -1) then {
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

        _shouldBlink = !_acknowledged;
      };

      if (_shouldBlink) then {
        _blinkCtrls pushBack [_ctrlTeamIconPulseBg, _ctrlTeamIconBlk, _ctrlTeamIconClr];
      };
    };

    {
      // Show
      _x params ["_ctrlTeamIconPulseBg", "_ctrlTeamIconBlk", "_ctrlTeamIconClr"];
      _ctrlTeamIconPulseBg ctrlSetFade 0;
      _ctrlTeamIconPulseBg ctrlCommit PULSE_LENGTH;
      _ctrlTeamIconBlk ctrlSetFade 1;
      _ctrlTeamIconBlk ctrlCommit PULSE_LENGTH;
      _ctrlTeamIconClr ctrlSetFade 0;
      _ctrlTeamIconClr ctrlCommit PULSE_LENGTH;
    } forEach _blinkCtrls;
    uiSleep PULSE_LENGTH;
		uiSleep PULSE_WAIT;

    {
      // Hide
      _x params ["_ctrlTeamIconPulseBg", "_ctrlTeamIconBlk", "_ctrlTeamIconClr"];
      _ctrlTeamIconPulseBg ctrlSetFade 1;
      _ctrlTeamIconPulseBg ctrlCommit PULSE_LENGTH;
      _ctrlTeamIconBlk ctrlSetFade 0;
      _ctrlTeamIconBlk ctrlCommit PULSE_LENGTH;
      _ctrlTeamIconClr ctrlSetFade 1;
      _ctrlTeamIconClr ctrlCommit PULSE_LENGTH;
    } forEach _blinkCtrls;
    uiSleep PULSE_LENGTH;
		uiSleep PULSE_WAIT;
	};
};