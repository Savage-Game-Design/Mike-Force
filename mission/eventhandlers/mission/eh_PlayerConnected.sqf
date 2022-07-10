/*
    File: eh_PlayerConnected.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Player Connected Event Handler.

    Parameter(s):
		_id - unique DirectPlay ID [NUMBER]
		_uid - getPlayerUID of the joining client [STRING]
		_name - profileName of the joining client [STRING]
		_jip - didJIP of the joining client [BOOL]
		_owner - owner id of the joining client [NUMBER]
		_idstr - same as id but in string format [STRING]

    Returns: nothing

    Example(s):
    	Not called directly.
*/

params
[
	"_id",
	"_uid",
	"_name",
	"_jip",
	"_owner",
	"_idstr"
];

// log player connected
["PlayerConnected mEH: %1", _this] call BIS_fnc_logFormat;
