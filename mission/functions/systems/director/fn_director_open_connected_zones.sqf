/*
    File: fn_zones_open_connected_zones.sqf
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
private _startingZones = getArray (missionConfigFile >> "map_config" >> "starting_zones");
private _potentialZonesToOpen = _startingZones;
private _capturedZones = (mf_s_zones select {_x select struct_zone_m_captured}) apply {_x select struct_zone_m_marker};
private _activeZones = keys mf_s_dir_activeZones;

{
	_potentialZonesToOpen append (getArray (missionConfigFile >> "map_config" >> "zones" >> _x) apply {_x # 0});
} forEach _capturedZones;

_potentialZonesToOpen = _potentialZonesToOpen arrayIntersect _potentialZonesToOpen;

private _zonesToOpen = _potentialZonesToOpen - _capturedZones - _activeZones;

{
    [_x] call vn_mf_fnc_director_open_zone;
} forEach _zonesToOpen;

diag_log format ["VN MikeForce: Opening new zones: %1", str _zonesToOpen]