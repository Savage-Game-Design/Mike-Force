/*
	File: fn_progress_to_color_config.sqf
	Author: Savage Game Design
	Public: No
	
	Description: 
		Adds progress markers, and sets up initial task
	
	Parameter(s):
		_progress - progress range of 0 - 100 [Number]

	Returns:
		Color Config String [String]

	Example(s):
		[33] call vn_mf_fnc_progress_to_color_config;
*/

params [
	["_progress",0] //	0: NUMBER - progress range of 0 - 100
];

private _colorstr = switch (floor (_progress * 0.1) * 10) do
{
	case (100):
	{
		"ColorRed"
	};
	case (90):
	{
		"ColorBrown"
	};
	case (80);
	case (70):
	{
		"ColorOrange"
	};
	case (60);
	case (50):
	{
		"ColorYellow"
	};
	case (40);
	case (30):
	{
		"ColorKhaki"
	};
	case (20);
	case (10):
	{
		"ColorGreen"
	};
	default
	{
		"Default"
	};
};

_colorstr
