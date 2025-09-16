/*
    File: fn_traits_db_get.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Get a list of players from the `vn_mf_traits_map` who currently have the provided trait.

        Global locality.
    
    Parameter(s):
		_trait - Trait [String]
    
    Returns:
        [ARRAY] List of players
    
    Example(s): 
        ["engineer"] call vn_mf_fnc_traits_db_get;
        ["medic"] call vn_mf_fnc_traits_db_get;
*/

params ["_trait"];
(missionNamespace getVariable "vn_mf_traits_map") getOrDefault [_trait, []]
