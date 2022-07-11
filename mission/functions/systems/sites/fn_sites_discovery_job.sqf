/*
    File: fn_sites_create_discovery_job.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Job that runs periodically to detect if player should partially/completely discover a site
    
    Parameter(s):
        None
    
    Returns:
        Function reached the end [BOOL]
    
    Example(s):
		["vehicle_creation_detection", vn_mf_fnc_veh_create_detection_job, [], 30] para_g_fnc_scheduler_add_job;
*/

private _playerRef = player;

private _sites = missionNamespace getVariable ["sites",[]];

private _nearbyUndiscoveredSites = 
  _sites inAreaArray [getPos _playerRef, vn_mf_g_sites_partial_discovery_radius, vn_mf_g_sites_partial_discovery_radius, 0, false]
  select {!(_x getVariable ["discovered", false])};

{
  private _siteRef = _x;
  private _distance = _playerRef distance2d (getPos _x);

  _siteRef setVariable ["partiallyDiscovered", true, true];

  if (_distance <= vn_mf_g_sites_discovery_radius) then {
    _siteRef getVariable ["markers", []] apply {_x setMarkerAlpha 0.5};
    _siteRef getVariable ["partialMarkers", []] apply {_x setMarkerAlpha 0};
    _siteRef setVariable ["discovered", true, true];
    continue;
  };

  // Only set partial markers if we're not close enough to fully reveal
  _siteRef getVariable ["partialMarkers", []] apply {_x setMarkerAlpha 0.3};
} forEach _nearbyUndiscoveredSites;

true