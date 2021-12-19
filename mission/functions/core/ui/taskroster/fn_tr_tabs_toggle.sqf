/*
	File: fn_tr_tabs_toggle.sqf
	Author: Terra
	Date: 2021-12-19
	Last Update: 2021-12-19
	Public: No

	Description:
		Makes the given control active while making all other tabs inactive.
	
	Parameter(s):
		_ctrlActive - The active tab [Control]
	
	Returns: nothing
	
	Example(s):
		[VN_TR_TABPROFILE_CTRL] call vn_mf_fnc_tr_tabs_toggle;
*/
#include "..\..\..\config\ui\ui_def_base.inc"
params ["_ctrlActive"];
VN_TR_TABS_CTRLS apply {
	_x ctrlSetTextColor [0.9,0.9,0.9,1];
};
_ctrlActive ctrlSetTextColor [1,1,1,1];
