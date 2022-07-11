/*
    File: fn_tr_supportTask_map_hide.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Opens the Mapscreen for the Maplocation.
		[!:info] As of the 23rd of December 2019, this is not in use.
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s):
		call vn_mf_fnc_tr_supportTask_map_hide
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"

_display = ctrlParent (_this#0);
//ToDo: maybe redo it, to load a ctrlGroup, instead of single ctrl's
_ctrl_map = _display ctrlCreate ["vn_tr_supportRequest_miniMap",VN_TR_SUPREQ_MAP_IDC];
_ctrl_map_accept = _display ctrlCreate ["vn_tr_supportRequest_miniMap_accept",VN_TR_SUPREQ_ACCEPT_IDC];
_ctrl_map_abort = _display ctrlCreate ["vn_tr_supportRequest_miniMap_abort",VN_TR_SUPREQ_ABORT_IDC];

private _coords = getPos player;
//move map to player Position
_ctrl_map ctrlMapAnimAdd [0, 0.15, _coords];
ctrlMapAnimCommit _ctrl_map;
//Add mouseEH, to be able to click around the map
_ctrl_map ctrlAddEventHandler ["MouseButtonClick",vn_mf_fnc_tr_getMapPosClick];

