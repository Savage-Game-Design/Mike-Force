/*
    File: fn_update_loading_screen.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Update loading screen text.

    Parameter(s):
		_text - text to display [STRING, defaults to ""]
		_idc - idc number [NUMBER]

    Returns: nothing

    Example(s):
		"" call vn_mf_fnc_update_loading_screen;
		["vn/objects_f_vietnam/civ/signs/data/billboards/vn_ui_billboard_01_ca.paa",5040] call vn_mf_fnc_update_loading_screen;
*/

params [
	["_text","",["",parseText ""]], // STRING : text to display
	["_idc",5050]
];
disableSerialization;
private _display = uiNameSpace getVariable ["vn_mf_loadingScreen",displayNull];
if (!isNull _display) then
{
	if (_text isEqualType parseText "") then
	{
		(_display displayCtrl _idc) ctrlSetStructuredText _text;
	} else {
		(_display displayCtrl _idc) ctrlSetText _text;
	};
};
