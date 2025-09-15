/*
    File: fn_sites_create_hq.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Creates a new HQ site in the given location.
    
    Parameter(s):
		_pos - Position to spawn the HQ site at
    
    Returns:
        Function reached the end [BOOL]
    
    Example(s):
        [markerPos "myHq"] call vn_mf_fnc_sites_create_hq
*/

params ["_pos"];

[
	"hq",
	_pos,
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _sitePos = getPos _siteStore;
		private _spawnPos = _sitePos;

		private _radius = 50;
		_siteStore setVariable ["siteRadius", _radius];

		//Hide all nearby terrain objects.
		{
			_x hideObjectGlobal true;
		} forEach (nearestTerrainObjects [_spawnPos, ["TREE", "BUSH", "SMALL TREE", "ROCK", "ROCKS"], _radius, false, true]);

		private _hqObjects = [_spawnPos] call vn_mf_fnc_create_hq_buildings;
		private _objectsToDestroy = _hqObjects select {_x isKindOf "land_vn_pavn_ammo"};

		// site objects being placed in a vehicle's logistics inventory
		// can result in strange side-effects / edge cases, including
		// soft-locked sites and objects being deleted in front of players.
		_objectsToDestroy apply {_x setVariable ["vn_log_enablePickup", false]};

		{
			[_x, true] call para_s_fnc_enable_dynamic_sim;
		} forEach _hqObjects;

		//Create a HQ marker.
		private _markerPos = _spawnPos getPos [10 + random 20, random 360];
		private _hqMarker = createMarker [format ["HQ_%1", _siteId], _markerPos];
		_hqMarker setMarkerType "o_hq";
		_hqMarker setMarkerText "HQ";
		// Hide at spawn 0.5
		_hqMarker setMarkerAlpha 0;

		// create partially discovered marker
		private _partialPos = _spawnPos getPos [10 + random 40, random 360];
		private _partialMarker = createMarker [format ["hq_zone_%1_partial", _siteId], _partialPos];
		_partialMarker setMarkerSize [400, 400];
		_partialMarker setMarkerShape "ELLIPSE";
		_partialMarker setMarkerText "Suspected HQ";
		_partialMarker setMarkerColor "ColorRed";
		_partialMarker setMarkerAlpha 0; // hiden at spawn 0.3

		private _guns = _hqObjects select {_x isKindOf "StaticWeapon"};
		private _objectives = [];
		{
			_objectives pushBack ([_x] call para_s_fnc_ai_obj_request_crew);
		} forEach _guns;
		_objectives pushBack ([_spawnPos, 4, 4] call para_s_fnc_ai_obj_request_defend);

		_siteStore setVariable ["aiObjectives", _objectives];
		_siteStore setVariable ["markers", [_hqMarker]];
		_siteStore setVariable ["staticGuns", _guns];
		_siteStore setVariable ["vehicles", _hqObjects]; 
		_siteStore setVariable ["objectsToDestroy", _objectsToDestroy];

		_siteStore setVariable ["markers", [_hqMarker], true];
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
		[
			_siteStore getVariable ["objectsToDestroy", []],
			_siteStore,
			_siteStore getVariable ["siteRadius", 50]
		] call vn_mf_fnc_sites_check_standard_site_completed;
	},
	//Teardown code
	{
		params ["_siteStore"];

		{
			deleteMarker _x;
		} forEach ((_siteStore getVariable "markers") + (_siteStore getVariable "partialMarkers"));

		{
			[_x] call para_s_fnc_ai_obj_finish_objective;
		} forEach (_siteStore getVariable ["aiObjectives", []]);
	}
] call vn_mf_fnc_sites_create_site;
