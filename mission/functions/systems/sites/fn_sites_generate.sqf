/*
    File: fn_sites_generate.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Places new sites down on the map procedurally. 
    
    Parameter(s):
		_zonesToGenerateIn - Targeted zones in the zoneData format - Array (Optional)

    Returns:
		None
    
    Example(s):
		[] call vn_mf_fnc_sites_generate
*/
params [["_zonesToGenerateIn", 0]];

private _attempts = 3;

//Simple approach for now - surround hostile zones with AA and artillery.
if (_zonesToGenerateIn isEqualType 0) then {
  _zonesToGenerateIn = mf_s_zones select {!(_x select struct_zone_m_captured)};
};

private _fnc_noSitesZoneCheck = {
	params ["_position"];
	vn_mf_markers_blocked_areas findIf {_position inArea _x} != -1
};


private _fnc_fallback_findPos = {
    params ["_startPos", "_maxDist"];
    private _result = _startPos;
    for "_i" from 1 to _attempts do
    {
        _attempt = _startPos getPos [random _maxDist, random 360];
        if (!surfaceIsWater _attempt && !([_attempt] call _fnc_noSitesZoneCheck)) exitWith {
            _result = _attempt;
            break;
        };
    };
    _result;
};

private _terrHideKinds = ["TREE", "HIDE", "BUSH", "SMALL TREE", "ROCK", "ROCKS", "STACK"];

// finds a random site location object to use as the basis for creating a site
// also terrain hides trees etc. within the site area
private _fnc_find_and_prep_site_spawn_location = {
	params ["_zoneName", "_siteType"];

	private _siteSpawn = selectRandom (vn_mf_s_zone_site_locations get _zoneName get _siteType);
	(nearestTerrainObjects [_siteSpawn, _terrHideKinds, _siteSpawn getVariable "site_radius", false, true])
		apply {_x hideObjectGlobal true};
	_siteSpawn
};

// TODO: Need to figure out func lookups FrogeBonk...
// TODO: I feel like we can generalise INIT stuff
//       * create objects
//       * create ai objectives
//       * create main marker
//       * create partial marker

{

	// NOTE: use `STR_vn_mf_site_type_name_short_*` stringtable entries as the
	// 'site type' identifier ...
	// means marker name == site_type variable on object

	private _zoneData = _x;
	private _zoneMarker = (_zoneData select struct_zone_m_marker);

	//Create zone HQ first -- largest radius.
	private _hqLoc = [_zoneMarker, "hq"] call _fnc_find_and_prep_site_spawn_location;
	[_hqLoc] call vn_mf_fnc_sites_create_hq;

	//Create initial AA emplacements
	for "_i" from 1 to (1 + ceil random (vn_mf_s_max_aa_per_zone - 1)) do
	{
		private _siteLoc = [_zoneMarker, "aa"] call _fnc_find_and_prep_site_spawn_location;
		[_siteLoc] call vn_mf_fnc_sites_create_aa_site;
	};

	//Create initial artillery emplacements
	for "_i" from 1 to (1 + ceil random (vn_mf_s_max_artillery_per_zone - 1)) do
	{
		private _siteLoc = [_zoneMarker, "artillery"] call _fnc_find_and_prep_site_spawn_location;
		[_siteLoc] call vn_mf_fnc_sites_create_artillery_site;
	};

} forEach _zonesToGenerateIn;
