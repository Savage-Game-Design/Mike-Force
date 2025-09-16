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

params ["_siteObj"];

[
	"aa",
	_siteObj,
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _siteType = _siteStore getVariable "site_type";
		private _spawnPos = (getPos _siteStore) vectorMultiply [1, 1, 0];

		private _cls = selectRandom ["vn_o_nva_static_zpu4"];
		private _aaGun = createVehicle [_cls, _spawnPos, [], 0, "CAN_COLLIDE"];
		[_aaGun, true] call para_s_fnc_enable_dynamic_sim;

		private _baseMarkerText = localize (format ["STR_vn_mf_site_type_name_short_%1", _siteType]);
		//Create an AA warning marker.
		private _markerPos = _spawnPos getPos [5 + random 10, random 360];
		private _aaZoneMarker = createMarker [format ["%1_%2", _siteType, _siteId], _markerPos];
		_aaZoneMarker setMarkerSize [1000, 1000];
		_aaZoneMarker setMarkerShape "ELLIPSE";
		_aaZoneMarker setMarkerBrush "DiagGrid";
		_aaZoneMarker setMarkerColor "ColorRed";
		// hiden at spawn 0.3
		_aaZoneMarker setMarkerAlpha 0;

		// create partially discovered marker
		private _partialPos = _spawnPos getPos [10 + random 40, random 360];
		private _partialMarker = createMarker [format ["%1_%2_partial", _siteType, _siteId], _partialPos];
		_partialMarker setMarkerSize [400, 400];
		_partialMarker setMarkerShape "ELLIPSE";
		_partialMarker setMarkerText format ["Suspected %1", _baseMarkerText];
		_partialMarker setMarkerColor "ColorRed";
		_partialMarker setMarkerAlpha 0; // hiden at spawn 0.3

		private _aaMarker = createMarker [format ["%1_%2", _siteType, _siteId], _markerPos];
		_aaMarker setMarkerType "o_antiair";
		_aaMarker setMarkerText _baseMarkerText;
		// hiden at spawn 0.5
		_aaMarker setMarkerAlpha 0;

		private _objectives = [];
		_objectives pushBack ([_aaGun] call para_s_fnc_ai_obj_request_crew);
		_objectives pushBack ([_spawnPos, 2, 3] call para_s_fnc_ai_obj_request_defend);

		_siteStore setVariable ["aiObjectives", _objectives];
		_siteStore setVariable ["aaGuns", [_aaGun]];
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
		} forEach (_siteStore getVariable "aaGuns");

		{
			[_x] call para_s_fnc_ai_obj_finish_objective;
		} forEach (_siteStore getVariable ["aiObjectives", []]);
	}
] call vn_mf_fnc_sites_create_site;