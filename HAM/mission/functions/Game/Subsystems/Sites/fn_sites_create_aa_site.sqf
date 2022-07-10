/*
	File: fn_zones_create_aa_site.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Creates an AA site in the given zone.
	
	Parameter(s):
		_zone - Zone marker name [STRING]
	
	Returns:
		Task data store [NAMESPACE]
	
	Example(s):
		["zone_saigon"] call vn_mf_fnc_zones_create_aa_site
*/

params ["_pos"];

[
	"aa",
	_pos,
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _sitePos = getPos _siteStore;
		private _spawnPos = _sitePos;

		private _result = [_spawnPos, "HEAVY"] call vn_mf_fnc_create_aa_emplacement;
		private _createdThings = _result select 0;

		//Create an AA warning marker.
		private _markerPos = _spawnPos getPos [5 + random 10, random 360];
		private _aaZoneMarker = createMarker [format ["AA_zone_%1", _siteId], _markerPos];
		_aaZoneMarker setMarkerSize [1000, 1000];
		_aaZoneMarker setMarkerShape "ELLIPSE";
		_aaZoneMarker setMarkerBrush "DiagGrid";
		_aaZoneMarker setMarkerColor "ColorRed";
		// hiden at spawn 0.3
		_aaZoneMarker setMarkerAlpha 0;


		// create partially discovered marker
		private _partialPos = _spawnPos getPos [10 + random 40, random 360];
		private _partialMarker = createMarker [format ["AA_zone_%1_partial", _siteId], _partialPos];
		_partialMarker setMarkerSize [400, 400];
		_partialMarker setMarkerShape "ELLIPSE";
		_partialMarker setMarkerText "Suspected AA";
		_partialMarker setMarkerColor "ColorRed";
		_partialMarker setMarkerAlpha 0; // hiden at spawn 0.3

		private _aaMarker = createMarker [format ["AA_%1", _siteId], _markerPos];
		_aaMarker setMarkerType "o_antiair";
		_aaMarker setMarkerText "AA";
		// hiden at spawn 0.5
		_aaMarker setMarkerAlpha 0;

		private _vehicles = _createdThings select 0;
		private _groups = _createdThings select 1;
		{
			[_x, true] call para_s_fnc_enable_dynamic_sim;
		} forEach (_vehicles + _groups);

		private _guns = _result select 1;
		private _objectives = [];
		{
			_objectives pushBack ([_x] call para_s_fnc_ai_obj_request_crew);
		} forEach _guns;
		_objectives pushBack ([_spawnPos, 2, 3] call para_s_fnc_ai_obj_request_defend);

		_siteStore setVariable ["aiObjectives", _objectives];
		_siteStore setVariable ["aaGuns", _guns];
		_siteStore setVariable ["vehicles", _vehicles]; 
		_siteStore setVariable ["units", (_createdThings select 1)]; 
		_siteStore setVariable ["groups", _groups];

		
		_siteStore setVariable ["markers", [_aaZoneMarker, _aaMarker], true];
		_siteStore setVariable ["partialMarkers", [_partialMarker], true];
	},
	//Teardown condition check code
	{
		//Check if we need to teardown every 15 seconds.
		15 call _fnc_periodicallyAttemptTeardown;
	},
	//Teardown condition
	{
		params ["_siteStore"];
		//Teardown when all guns destroyed
		(_siteStore getVariable "aaGuns" findIf {alive _x} == -1)
	},
	//Teardown code
	{
		params ["_siteStore"];

		//Delete the AA warning marker
		{
			deleteMarker _x;
		} forEach ((_siteStore getVariable "markers") + (_siteStore getVariable "partialMarkers"));

		{
			deleteVehicle _x;
		} forEach ((_siteStore getVariable "vehicles") + (_siteStore getVariable "units"));

		{
			[_x] call para_s_fnc_ai_obj_finish_objective;
		} forEach (_siteStore getVariable ["aiObjectives", []]);
	}
] call vn_mf_fnc_sites_create_site;