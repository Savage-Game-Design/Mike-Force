/*
	File: fn_unit_next_rank.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Converts rank to icon.

	Parameter(s):
		_unit - player unit object [Object]

	Returns:
		[0, 1] Array [Array]
			0 - path to rank icon [String]
			1 - rank text name [String]

	Example(s):
		[player] call vn_mf_fnc_unit_next_rank
*/

params
[
	["_unit",objNull,[objNull]] // 0: OBJECT - player unit object
];

private _data = [];
{
	//code
	_x params [["_rank_data",["","",0]]];
	_rank_data params ["", "", "_pointsneeded"];
	if (_unit getVariable ["vn_mf_db_rank",0] < _pointsneeded) exitWith
	{
		_data = _rank_data;
	};
} forEach getArray(missionConfigFile >> "gamemode" >> "rank" >> "ranks");
_data
