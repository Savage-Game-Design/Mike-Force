/*
	File: fn_vn_mf_RscDisplayExample.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		onLoad and onUnload function for the Example display.
	
	Parameter(s):
		_mode - Either "onLoad" or "onUnload" [STRING]
		_params - UIEH params [ARRAY]
		_class - Config classname of the display [STRING]
	
	Returns:
		Nothing
	
	Example(s):
		Only use from config
*/
#include "..\ui_def_base.inc"
params ["_mode", "_params", "_class"];

if (_mode == "onLoad") exitWith {
	_params params ["_display"];
	// The script was called from the onLoad UIEH in the config. Assign the UIEH for the controls
	_ctrlLeftTop = _display displayCtrl VN_MF_RSCDISPLAYEXAMPLE_LT_IDC;
	_ctrlLeftTop ctrlAddEventHandler ["MouseEnter", vn_mf_fnc_displayExample_LTMouseEnter];
};
_params params ["_display", "_exitCode"];