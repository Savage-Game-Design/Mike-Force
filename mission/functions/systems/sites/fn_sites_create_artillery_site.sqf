/*
	File: fn_zones_create_artillery_site.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Creates an artillery site in the given zone.
	
	Parameter(s):
		_zone - Zone marker name [STRING]
	
	Returns:
		Task Data store [NAMESPACE]
	
	Example(s):
		["zone_saigon"] call vn_mf_fnc_zones_create_artillery_site
*/

params ["_siteObj"];

[
	"artillery",
	_siteObj,
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _siteType = _siteStore getVariable "site_type";
		private _spawnPos = (getPos _siteStore) vectorMultiply [1, 1, 0];

		private _cls = selectRandom vehicles_vc_mortars;
		private _mortar = createVehicle [_cls, _spawnPos, [], 0, "CAN_COLLIDE"];
		[_mortar, true] call para_s_fnc_enable_dynamic_sim;
		_mortar enableWeaponDisassembly false;

		private _objectives = [];
		_objectives pushBack ([_mortar] call para_s_fnc_ai_obj_request_crew);
		_objectives pushBack ([_spawnPos, 1, 2] call para_s_fnc_ai_obj_request_defend);

		private _baseMarkerText = localize (format ["STR_vn_mf_site_type_name_short_%1", _siteType]);
		private _markerPos = _spawnPos getPos [random 5, random 360];
		private _artilleryMarker = createMarker [format ["%1_%2", _siteType, _siteId], _markerPos];
		_artilleryMarker setMarkerType "o_art";
		_artilleryMarker setMarkerText _baseMarkerText;
		// Hiden at spawn 0.5
		_artilleryMarker setMarkerAlpha 0;

		// create partially discovered marker
		private _partialPos = _spawnPos getPos [10 + random 40, random 360];
		private _partialMarker = createMarker [format ["%1_%2_partial", _siteType, _siteId], _partialPos];
		_partialMarker setMarkerSize [400, 400];
		_partialMarker setMarkerShape "ELLIPSE";
		_partialMarker setMarkerText format ["Suspected %1", _baseMarkerText];
		_partialMarker setMarkerColor "ColorRed";
		_partialMarker setMarkerAlpha 0; // hiden at spawn 0.3

		_siteStore setVariable ["aiObjectives", _objectives];
		_siteStore setVariable ["mortars", [_mortar]];
		_siteStore setVariable ["markers", [_artilleryMarker], true];
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
		(_siteStore getVariable "mortars" findIf {alive _x} == -1)
	},
	//Teardown code
	{
		params ["_siteStore"];

		{
			deleteMarker _x;
		} forEach ((_siteStore getVariable "markers") + (_siteStore getVariable "partialMarkers"));

		{
			deleteVehicle _x;
		} forEach ((_siteStore getVariable "mortars"));

		{
			[_x] call para_s_fnc_ai_obj_finish_objective;
		} forEach (_siteStore getVariable ["aiObjectives", []]);
	}
] call vn_mf_fnc_sites_create_site;