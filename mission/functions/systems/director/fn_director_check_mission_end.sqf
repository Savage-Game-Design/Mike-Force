/*
    File: fn_director_check_mission_end.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Checks if all zones are captured, then ends the mission and wipes the save.
    
    Parameter(s):
        None
    
    Returns:
        None
    
    Example(s):
        [] call vn_mf_fnc_director_check_mission_end;
*/

private _allZonesCaptured = mf_s_zones findIf {!(_x select struct_zone_m_captured)} == -1;
 
if (_allZonesCaptured) then {
    call vn_mf_fnc_end_mission;
};