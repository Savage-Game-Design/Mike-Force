/*
    // TODO - Rename to make_zone_active
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

if (_zone in mf_s_dir_activeZones) exitWith {
    ["WARNING", format ["Cannot activate already active zone '%1'", _zone]] call para_g_fnc_log;
};

["INFO", format ["Make zone '%1' an active zone", _zone]] call para_g_fnc_log;

private _taskStore = ["capture_zone", _zone] call vn_mf_fnc_task_create select 1;

private _activeZoneInfo = createHashMapFromArray [
    ["state", "capture"],
    ["currentTask", _taskStore]
];

mf_s_dir_activeZones set [_zone, _activeZoneInfo];

mf_g_dir_activeZoneNames = keys mf_s_dir_activeZones;
publicVariable "mf_g_dir_activeZoneNames";