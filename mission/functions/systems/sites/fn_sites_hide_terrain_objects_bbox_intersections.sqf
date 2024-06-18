/*
	File: fn_sites_hide_terrain_objects_bbox_intersections.sqf
	Author: "DJ" Dijksterhuis"
	Public: No
	
	Description:
		Given a site, will search the surrounding area to find problematic
		terrain objects that could soft lock a site from being completed.

		Useful to find out if a mortar will spawn inside a rock.

		NOTE:	This operates on site AREA, not on site OBJECTS.

		NOTE:	Terrain objects are checked against their maximum bounding box edge dimension.
			This provides a good enough estimation, but is not precise, so we end up
			hiding a lot more terrian objects than we possibly need to.
	
	Parameter(s):
		_sitePos:	[ARRAY] No default.
				centre point position of a site

		_siteRadius:	[NUMBER] No default.

				Return terrain objects whose bounding box intersects
				within this radius from the site centre point position.

		_searchRadius:	[NUMBER] Default: 100

				How far out to search for terrain objects.

				Need this set higher than _siteRadius, as `nearestTerainObjects`
				looks for object centres, not the edges of the object.

				But also want this low to maintain performance.

		_terrainKinds:	[ARRAY] Default: ["ROCK", "ROCKS", "HIDE"]

				Types of terrain object to search for. Setting to
				an empty array will return all possible kinds of
				terrain object.
	
	Returns:
		Array of terrain objects that were hidden due to estimated bounding box intersection.
	
	Example(s):

		[[1000, 1000]] call vn_mf_fnc_sites_hide_terrain_objects_bbox_intersections;

		// will probably kill performance
		[[1000, 1000], 1000] call vn_mf_fnc_sites_hide_terrain_objects_bbox_intersections;

		// will probably miss some terrain objects
		[[1000, 1000], 10] call vn_mf_fnc_sites_hide_terrain_objects_bbox_intersections;

		// search for all terrain object kinds
		[[1000, 1000], 66, []] call vn_mf_fnc_sites_hide_terrain_objects_bbox_intersections;

		// search for building terrain objects
		[[1000, 1000], 66, ["BUILDING"]] call vn_mf_fnc_sites_hide_terrain_objects_bbox_intersections;
		
*/

// TODO: There must be some fancy flag somewhere in Mike Force to automate switching debug on/off.
private _debug = false;

params [
	"_sitePos",
	"_siteRadius",
	["_searchRadius", 100],
	["_terrainKinds", ["ROCK", "ROCKS", "HIDE"]]
];

private _nearbyTerrainObjs = nearestTerrainObjects [
	_sitePos,
	_terrainKinds,
	_searchRadius,
	false,
	true
];

if (_debug) then {
	private _markerName = format [
		"maker-debug-site-area-%1-%2",
		_sitePos select 0,
		_sitePos select 1
	];
	private _marker = createMarker [_markerName, _sitePos];
	_marker setMarkerAlpha 1;
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerSize [_siteRadius, _siteRadius];
	_marker setMarkerBrush "Border";
	_marker setMarkerColor "ColorGreen";
};

private _hiddenTerrainObjects = [];

_nearbyTerrainObjs apply {

	// use a bounding box to work out the terrain object's radius from maximum x/y dimension.
	// https://community.bistudio.com/wiki/boundingBoxReal

	private _bbr = boundingBoxReal _x;
	private _p1 = _bbr select 0;
	private _p2 = _bbr select 1;

	private _maxX = abs ((_p2 select 0) - (_p1 select 0));
	private _maxY = abs ((_p2 select 1) - (_p1 select 1));

	private _maxDimension = (_maxX max _maxY) / 2;

	/*
	work out if the site area intersects with the largest bounding box edge of the terrain
	object.

	TODO: use `getDir` to figure out the actual edge intersection instead of assuming the
	maximum edge length is what we always intersect with. for now, this is safe enough.

	NOTE: For some reason we have to divide siteRadius by 2 to get this working correctly.
	Otherwise we return terrain objects that do not intersect with the site's area.
	*/

	private _areaArr = [
		getPos _x, 
		_maxDimension + (_siteRadius / 2), 
		_maxDimension + (_siteRadius / 2),  
		0, 
		true
	];

	if (_sitePos inArea _areaArr) then {

		_x hideObjectGlobal true;
		_hiddenTerrainObjects pushBack _x;

		/*
		rocks can have bushes placed on top of them.
		removing the rocks alone leaves the bushes stranded in mid air which looks janky.
		so we need to remove any terrain objects on top of this terrain object.
		*/
		private _additionalObjects = nearestTerrainObjects [
			getPos _x,
			[], 
			_maxDimension,
			false,
			true
		];
		_additionalObjects apply {
			_x hideObjectGlobal true;
			_hiddenTerrainObjects pushBack _x;
		};

		if (_debug) then {
			diag_log format [
				"Hid terrain object that intersected with site: obj=%1 pos=%2",
				_x,
				getPos _x
			];
			private _markerName = format ["marker-debug-terrain-object-%1", _x];
			private _marker = createMarker [_markerName, getPos _x];
			_marker setMarkerAlpha 1;
			_marker setMarkerShape "ELLIPSE";
			_marker setMarkerSize [_maxDimension, _maxDimension];
			_marker setMarkerBrush "Border";

			_marker setMarkerColor "ColorRed";

		};
	};
};

_objsIntersectTerrainObjectsBBox
