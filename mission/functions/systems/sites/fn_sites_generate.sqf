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

private _fnc_findPos = {
    params ["_startPos", "_minDist", "_maxDist"];
    private _result = _startPos;
    for "_i" from 1 to _attempts do
    {
        _attempt = _startPos getPos [_minDist + random (_maxDist - _minDist), random 360];
        if (!surfaceIsWater _attempt && !([_attempt] call _fnc_noSitesZoneCheck)) exitWith {
            _result = _attempt;
            break;
        };

    };
    _result
};

{
	private _zoneData = _x;
	private _center = markerPos (_zoneData select struct_zone_m_marker);
	private _rawSizes = markerSize (_zoneData select struct_zone_m_marker);
	private _sizes = _rawSizes apply {abs _x};
	private _sizeMax = selectMax _sizes;

	//Create initial AA emplacements
	for "_i" from 1 to (1 + ceil random (vn_mf_s_max_aa_per_zone - 1)) do
	{
		[[_center, _sizeMax / 4, _sizeMax / 2] call _fnc_findPos] call vn_mf_fnc_sites_create_aa_site;
	};

	//Create initial artillery emplacements
	for "_i" from 1 to (1 + ceil random (vn_mf_s_max_artillery_per_zone - 1)) do
	{
		[[_center, _sizeMax / 3, _sizeMax] call _fnc_findPos] call vn_mf_fnc_sites_create_artillery_site;
	};

	//Create zone HQ
	private _hqPosition = _center;
	for "_i" from 0 to 10 do {
		private _testPosition = _hqPosition getPos [100, random 360];
		_testPosition = (selectBestPlaces [_testPosition, 200, "-(houses + 10 * waterDepth)", 10, 1]) select 0 select 0;
		if !(_testPosition isFlatEmpty [0, -1, 0.5, 50, 0] isEqualTo []) exitWith {
			_hqPosition = _testPosition + [0];
		};
	};
	[_hqPosition] call vn_mf_fnc_sites_create_hq;
} forEach _zonesToGenerateIn;
