/*
    File: fn_director_zones_in_range_of_bases.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
		Returns all zones which are within capture distancce of an FOB.
    
    Parameter(s):
		None

    Returns:
		Zone markers in range of existing bases [ARRAY]
    
    Example(s):
		[] call vn_mf_fnc_director_zones_in_range_of_bases
*/

mf_s_zone_markers select {
	!(localNamespace getVariable _x select struct_zone_m_captured)
	&&
	{!(para_g_bases inAreaArray [markerPos _x, mf_s_baseZoneUnlockDistance, mf_s_baseZoneUnlockDistance, 0] isEqualTo [])}
}