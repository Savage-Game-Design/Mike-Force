/*
    File: fn_tr_zone_change.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Changes the zone?
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

#include "..\..\..\..\config\ui\ui_def_base.inc"

params["_ctrl"];
vn_mf_tr_zone_filter = _ctrl getVariable ["selectedZone",""];

if(_ctrl isEqualTo VN_TR_ZONE_A_CTRL)then
{
	vn_mf_tr_zone_active_cur_color = [VN_TR_MISS_PRIM];
	VN_TR_ZONE_A_CTRL ctrlSetTextColor [0,0,0,1];
	VN_TR_ZONE_B_CTRL ctrlSetTextColor [0,0,0,0.2];
}else{
	vn_mf_tr_zone_active_cur_color = [COLOR_VN_TR_ZONE2];
	VN_TR_ZONE_A_CTRL ctrlSetTextColor [0,0,0,0.2];
	VN_TR_ZONE_B_CTRL ctrlSetTextColor [0,0,0,1];
};

call vn_mf_fnc_tr_cleanRightSheet;
call vn_mf_fnc_tr_mainInfo_show;
[] call vn_mf_fnc_tr_missions_fill;