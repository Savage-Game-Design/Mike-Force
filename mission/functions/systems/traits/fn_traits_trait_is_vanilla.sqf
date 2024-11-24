/*
    File: fn_traits_trait_is_vanilla.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Checks whether the given trait string is a vanilla arma3 player trait.

    Parameter(s):
		_trait - Trait [String]
    
    Returns: BOOL: True when trait string is vanilla, false otherwise
    
    Example(s): 
        ["engineer"] call vn_mf_fnc_traits_trait_is_vanilla;  // returns true
        ["vn_artillery"] call vn_mf_fnc_traits_trait_is_vanilla;  // returns false
*/

params ["_trait"];

private _vanilla_traits = [
    "audibleCoef",
    "camouflageCoef",
    "loadCoef",
    "engineer",
    "explosiveSpecialist",
    "medic",
    "UAVHacker"
];

_trait in _vanilla_traits;
