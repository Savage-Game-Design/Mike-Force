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

params ["_siteObj"];

[
	"hq",
	_siteObj,
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _siteType = _siteStore getVariable "site_type";
		private _spawnPos = (getPos _siteStore) vectorMultiply [1, 1, 0];

		private _hqObjects = [_spawnPos] call vn_mf_fnc_create_hq_buildings;
		private _objectsToDestroy = _hqObjects select {_x isKindOf "land_vn_pavn_ammo"};

		{
			[_x, true] call para_s_fnc_enable_dynamic_sim;
		} forEach _hqObjects;

		private _baseMarkerText = localize (format ["STR_vn_mf_site_type_name_short_%1", _siteType]);

		//Create a HQ marker.
		private _markerPos = _spawnPos getPos [10 + random 20, random 360];
		private _hqMarker = createMarker [format ["%1_%2", _siteType, _siteId], _markerPos];
		_hqMarker setMarkerType "o_hq";
		_hqMarker setMarkerText _baseMarkerText;
		// Hide at spawn 0.5
		_hqMarker setMarkerAlpha 0;

		// create partially discovered marker
		private _partialPos = _spawnPos getPos [10 + random 40, random 360];
		private _partialMarker = createMarker [format ["%1_%2_partial", _siteType, _siteId], _partialPos];
		_partialMarker setMarkerSize [400, 400];
		_partialMarker setMarkerShape "ELLIPSE";
		_partialMarker setMarkerText format ["Suspected %1", _baseMarkerText];
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
		//Teardown when all guns destroyed
		(_siteStore getVariable "objectsToDestroy" findIf {alive _x} == -1)
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