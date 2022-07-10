/*
    File: fn_init_mission_handlers.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Adds mission event handlers by target scope.
    
    Parameter(s):
        _target_scope - Target scope [String]
    
    Returns: nothing
    
    Example(s):
        _target_scope call para_c_fnc_init_player_event_handlers;;
*/

params ["_target_scope"];

// init mission EH
{
	if (_target_scope in getArray(_x >> "targets")) then
	{
		private _files = getArray(_x >> "files");
		private _name = configName _x;
		if !(_files isEqualTo []) then
		{
			["Adding mission event handler: %1 with files %2", _name, _files] call BIS_fnc_logFormat;
			private _cmd = "";
			{
				_cmd = _cmd + preprocessFile _x;
			} forEach _files;
			private _id = addMissionEventHandler [_name,_cmd];
		} else {
			private _fileName = format["eventhandlers\mission\eh_%1.sqf",_name];
			private _file = preprocessFile _fileName;
			["Adding mission event handler: %1 with file %2", _name, _fileName] call BIS_fnc_logFormat;
			private _id = addMissionEventHandler [_name,_file];
		};
	};
} forEach (configProperties [missionConfigFile >> "gamemode" >> "missionEventHandler"]);
