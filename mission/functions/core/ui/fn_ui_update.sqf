/*
	File: fn_ui_update.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Update stat progress bar ui.

	Parameter(s):
		_name - stat name [String]
		_value - value [String]

	Returns: nothing

	Example(s):
		[_name,_value] call vn_mf_fnc_ui_update
*/

params
[
	"_name",  	// 0: STRING - stat name
	"_value" 	// 1: STRING - value
];
private _ctrl = uiNamespace getVariable [format["%1_ctrl",_name],controlNull];
if !(isNull _ctrl) then
{
	_ctrl progressSetPosition (player getVariable [_name, 1]);
};

// apply health effects
call vn_mf_fnc_health_effects;
