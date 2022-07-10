/*
    File: fn_teleport.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Moves player to another camp or location.
		[!:warning] The `_player` variable is passsed from the parent scope!
		[!:warning] This function should not be called directly!
    
    Parameter(s):
		_location - Position [Position]
		_agent - Not used [Object]
    
    Returns: nothing
    
    Example(s): none
*/

params ["_objectName","_destinationName"];

private _baseConfig = missionConfigFile >> "gamemode" >> "teleporters";
private _objectConfig = _baseConfig >> "objects" >> _objectName;
private _destinationConfig = _baseConfig >> "destinations" >> _destinationName;

if (!isClass _objectConfig || !isClass _destinationConfig) exitWith {};

private _object = missionNamespace getVariable [_objectName, objNull];
//Works with objNull, as distance2D returns a huge number.
if (_player distance2D _object > 20) exitWith {};

private _destination = getMarkerPos getText (_destinationConfig >> "position_marker");
if (_destination isEqualTo [0,0,0]) exitWith {};

private _newLocation = _destination findEmptyPosition [3,20,typeOf _player];
if (_newLocation isEqualTo []) then {_newLocation = _destination};

remoteExecCall ["vn_mf_fnc_display_location_time",_player];

_player setPos _newLocation;