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

params ["_pos"];

[
	"artillery",
	_pos,
	//Setup Code
	{
		params ["_siteStore"];
		private _siteId = _siteStore getVariable "site_id";
		private _sitePos = getPos _siteStore;
		private _spawnPos = _sitePos;

		private _result = [_spawnPos] call vn_mf_fnc_create_mortar;
		private _createdThings = _result select 0;

		private _markerPos = _spawnPos getPos [random 5, random 360];
		private _artilleryMarker = createMarker [format ["Artillery_%1", _siteId], _markerPos];
		_artilleryMarker setMarkerType "o_art";
		_artilleryMarker setMarkerText "Artillery";
		// Hiden at spawn 0.5
		_artilleryMarker setMarkerAlpha 0;

		// create partially discovered marker
		private _partialPos = _spawnPos getPos [10 + random 40, random 360];
		private _partialMarker = createMarker [format ["artillery_zone_%1_partial", _siteId], _partialPos];
		_partialMarker setMarkerSize [400, 400];
		_partialMarker setMarkerShape "ELLIPSE";
		_partialMarker setMarkerText "Suspected Artillery";
		_partialMarker setMarkerColor "ColorRed";
		_partialMarker setMarkerAlpha 0; // hiden at spawn 0.3

		private _vehicles = _createdThings select 0;
		{
			//Disable weapon dissassembly - statics don't get deleted properly when disassembled, so it breaks the site/mission.
			_x enableWeaponDisassembly false;
		} forEach _vehicles;
		private _groups = _createdThings select 1;
		{
			[_x, true] call para_s_fnc_enable_dynamic_sim;
		} forEach (_vehicles + _groups);

		private _mortars = _result select 1;
		private _objectives = [];
		{
			_objectives pushBack ([_x] call para_s_fnc_ai_obj_request_crew);
		} forEach _mortars;
		_objectives pushBack ([_spawnPos, 1, 2] call para_s_fnc_ai_obj_request_defend);

		_siteStore setVariable ["aiObjectives", _objectives];
		_siteStore setVariable ["mortars", _mortars];
		_siteStore setVariable ["vehicles", _vehicles]; 
		_siteStore setVariable ["units", (_createdThings select 1)]; 
		_siteStore setVariable ["groups", _groups];

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
		} forEach ((_siteStore getVariable "vehicles") + (_siteStore getVariable "units"));

		{
			[_x] call para_s_fnc_ai_obj_finish_objective;
		} forEach (_siteStore getVariable ["aiObjectives", []]);
	}
] call vn_mf_fnc_sites_create_site;