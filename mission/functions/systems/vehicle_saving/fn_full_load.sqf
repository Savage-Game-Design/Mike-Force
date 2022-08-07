/*
    File: fn_full_load.sqf
    Author: Ridderrasmus
    Public: No

    Description:
	    Starts loading all vehicles and crates.

    Parameter(s):
		NONE

    Returns: nothing

    Example(s):
	    [] call vn_mf_fnc_full_load;
*/

_savedData = [[], []];
// To be extra sure we don't load before ID's have been assigned
waitUntil { (((vehicles select {typeOf _x == "vn_b_air_oh6a_01"}) select 0) getVariable ["vehAssetId", ""]) != ""};

// Load saved data
["GET", "veh_save_data", _savedData] call para_s_fnc_profile_db params ["", "_savedData"];

// Load vehicles

  {
    [_x] call vn_mf_fnc_veh_load;
  } forEach (_savedData select 0);


// Load crates

  {
    [_x] call vn_mf_fnc_crate_load;
  } forEach (_savedData select 1);
