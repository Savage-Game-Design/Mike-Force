/*
    File: fn_supporttaskcreate.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Creates support tasks.
		[!:warning] The `_player` variable is passsed from the parent scope!
		[!:warning] This function should not be called directly!
    
    Parameter(s):
		_taskClass - Task classname [String]
		_coords - Coordinates [Position]
		_teamToTarget - Targeted team [Group]
    
    Returns: nothing
    
    Example(s): none
*/

[format ["Creating support task %1", [_this]]] remoteExec ["hint", _player];

params ["_taskClass", "_coords", "_teamToTarget"];

private _taskCreationFunction = getText (missionConfigFile >> "gamemode" >> "tasks" >> _taskClass >> "creationfunction");

[_taskClass, _player, _coords, _teamToTarget] call (call compile _taskCreationFunction);