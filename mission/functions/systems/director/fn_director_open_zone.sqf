/*
    File: fn_director_open_zone.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        No description added yet.
    
    Parameter(s):
        _localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
    
    Returns:
        Function reached the end [BOOL]
    
    Example(s):
        [parameter] call vn_fnc_myFunction
*/
params ["_zone"];

private _taskStore = ["capture_zone", _zone] call vn_mf_fnc_task_create select 1;
mf_s_activeZones pushBack [_zone, _taskStore];