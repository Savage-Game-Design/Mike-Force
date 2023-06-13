/*
	Author: 
		Karel Moricky, improved by Killzone_Kid

		Adapted for Mike Force by Savage Game Design

	Description:
		Initialize displays during preStart or init GUI display and run its script
		The config class of the display is available in "BIS_fnc_initDisplay_configClass" stored on display
			Example: _display getVariable "BIS_fnc_initDisplay_configClass";
		Display is also stored in uiNamespace variable with config class name
			Example: uiNamespace getVariable "RscAvCamera";

	Parameter(s):
		ARRAY - [] init displays during preStart
		or
		0: STRING - mode, can be "onLoad" or "onUnload"
		1: ARRAY - params passed from "onLoad" or "onUnload" event handler, contains only DISPLAY
		2: STRING - display class
		3: STRING - script path from CfgScriptPaths

	Returns:
		NOTHING
*/

#define CONFIG_CLASS_VAR "BIS_fnc_initDisplay_configClass"
#define INIT_GAME_VAR "BIS_initGame"

//--- Register/unregister display
with uiNamespace do
{
	params 
	[
		["_mode", "", [""]],
		["_params", []],
		["_class", "", [""]],
		["_path", "default", [""]],
		["_register", true, [true, 0]]
	];

	_display = _params param [0, displayNull];
	if (isNull _display) exitWith {nil};

	if (_register isEqualType true) then {_register = parseNumber _register};
	if (_register > 0) then 
	{
		_varDisplays = _path + "_displays";
		_displays = (uiNamespace getVariable [_varDisplays, []]) - [displayNull];

		if (_mode == "register") exitWith 
		{
			//--- Register current display
			_display setVariable [CONFIG_CLASS_VAR, _class];
			uiNamespace setVariable [_class, _display];
			
			_displays pushBackUnique _display;
			uiNamespace setVariable [_varDisplays, _displays];
			
			if !(uiNamespace getVariable [INIT_GAME_VAR, false]) then 
			{
				//--- tell loading screen it can stop using ARMA 3 logo which is shown only before main menu 
				//--- and start using the classic terrain picture
				uiNamespace setVariable [INIT_GAME_VAR, _path == "GUI" && {ctrlIdd _x >= 0} count _displays > 1];
			};
		};
		
		if (_mode == "unregister") exitWith 
		{
			//--- Unregister current display
			_displays = _displays - [_display];
			uiNamespace setVariable [_varDisplays, _displays];
		};
	};
};