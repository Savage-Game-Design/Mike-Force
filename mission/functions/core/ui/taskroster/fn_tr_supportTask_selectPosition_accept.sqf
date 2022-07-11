/*
    File: fn_tr_supportTask_selectPosition_accept.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Accepts the selected position?
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s):
		call vn_mf_fnc_tr_supportTask_selectPosition_accept
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"
//get markerPos of desired Mission location
private _markerName = format["%1_missionMarker",getPlayerUID player];
private _pos = mapGridPosition (getMarkerPos _markerName);
systemchat str [(getMarkerPos _markerName),mapGridPosition (getMarkerPos _markerName)];

//update text of map selection
VN_TR_SUPREQ_SELPOS_CTRL ctrlSetText format["Selected Position: [%1]", _pos];
//update temporary data
vn_tr_supportMissionInfo set [1,(getMarkerPos _markerName)];
deleteMarkerLocal _markerName;

//enable "Create new support task"-control
VN_TR_SUPREQ_CTASK_CTRL ctrlEnable true;

//IMPORTANT:
//DEV NOTE: No idea why, but when "call"-ed -> Game crashes. Seems to be working with "spawn", but should be kept in mind!
//call vn_mf_fnc_tr_supportTask_map_hide;
//-------------------------------------
[] spawn vn_mf_fnc_tr_supportTask_map_hide;