/*
    File: fn_player_award.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Displays award to player.

    Parameter(s):
		_name - award config name [STRING]
		_level - award level [NUMBER]

    Returns: nothing

    Example(s):
		[configName _x,_level_id] call vn_mf_fnc_player_award;
*/

params
[
	"_name",
	"_level"
];

[
	localize format["STR_vn_mf_%1",_name]
	,((	[
			 (missionConfigFile >> "gamemode" >> "awards_config" >> _name)
			,"levels"
			,[ "\vn\ui_f_vietnam\ui\taskroster\img\medal_placeholder.paa" ,"\vn\ui_f_vietnam\ui\taskroster\img\medal_placeholder.paa" ]
		] call para_g_fnc_get_gamemode_value ) select _level ) select 0
] call para_c_fnc_infopanel_addToQueue;