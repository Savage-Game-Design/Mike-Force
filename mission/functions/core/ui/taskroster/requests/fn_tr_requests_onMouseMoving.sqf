#include "..\..\..\..\..\config\ui\ui_def_base.inc"

params ["_control", "_mx", "_my", "_mouseOver"];

if (_mouseOver isEqualTo false) exitWith {};

(ctrlPosition _control) params ["_cx", "_cy"];
[_mx - _cx, _my - _cy] params ["_px", "_py"];

private _curSel = ctCurSel VN_TR_REQUESTS_TAB_LIST_CTRL;
for "_rowIndex" from 0 to (ctRowCount VN_TR_REQUESTS_TAB_LIST_CTRL) - 1 do {
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

  (ctrlPosition _ctrlBackground) params ["_ctrlX", "_ctrlY", "_ctrlW", "_ctrlH"];
  
  private _show = _px >= _ctrlX && _py >= _ctrlY && _px <= _ctrlX + _ctrlW  && _py <= _ctrlY + _ctrlH && _rowIndex isNotEqualTo _curSel;
  {
    _x ctrlShow _show;
  } forEach [
    _ctrlHoverMarkerTop,
    _ctrlHoverMarkerBottom,
    _ctrlHoverMarkerLeft,
    _ctrlHoverMarkerRight
  ];
};