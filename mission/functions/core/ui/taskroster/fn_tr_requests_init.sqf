/*
	File: fn_tr_requests_init.sqf
	Author: Terra
	Date: 2021-12-20
	Last Update: 2021-12-20
	Public: No

	Description:
		Loads the taskroster page for making requests.
	
	Parameter(s): none
	
	Returns: nothing
	
	Example(s):
		[] call vn_mf_fnc_tr_requests_init;
*/
#include "..\..\..\config\ui\ui_def_base.inc"
diag_log "fn_tr_requests_init.sqf";
//cleanup everything
call vn_mf_fnc_tr_cleanRightSheet;
[VN_TR_TABSUPPORT_CTRL] call vn_mf_fnc_tr_tabs_toggle;
VN_TR_REQUESTS_CTRL ctrlShow true;

