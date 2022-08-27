#include "..\..\..\..\..\config\ui\ui_def_base.inc"

params ["_control"];

private _taskId = _control getVariable ["taskId", -1];
private _tasks = VN_TR_REQUESTS_DATA_LIST_UNSORTED;
private _taskIndex = _tasks findIf { _x#0 isEqualTo _taskId };

if (_taskIndex isNotEqualTo -1) then {
  _tasks deleteAt _taskIndex;
};

// For whatever reason Arma crashes if I call it so yeah, whatever makes Arma happy ¯\_(ツ)_/¯
[_tasks] spawn {
  _this call vn_mf_fnc_tr_requests_load;
};