/*
	File: fn_player_markers_job.sqf
	Author: Savage Game Design
	Edited: DirtySanchez
	
	Public: No
	
	Description:
	    Called periodically to maintain player markers. 
	
	Parameter(s): none
	
	Returns: nothing
	
	Example(s):
	    call vn_mf_fnc_player_marker_job
*/

//Markers which has corresponding players in the game.
private _activePlayerMarkers = [];
private _activeVehicleMarkers = [];

// Get Player Marker info
private _playerMarker = format ["player_marker_%1", getPlayerUID player];
private _playerMarkerType = "b_inf";
if (player getUnitTrait "Medic") then {_playerMarkerType = "b_med"};
if (player getUnitTrait "Engineer") then {_playerMarkerType = "b_maint"};
if (player getUnitTrait "ExplosiveSpecialist") then {_playerMarkerType = "b_Ordnance"};
if (player getUnitTrait "vn_artillery") then {_playerMarkerType = "b_support"};
_playerMarker setMarkerTypeLocal _playerMarkerType;

//Vehicles which have players in.
vn_mf_player_markers_manned_vehicles = [];

{
	private _unit = _x;
	private _unitMarker = format ["player_marker_%1", getPlayerUID _unit];
	private _unitGroup = _unit getVariable ["vn_mf_db_player_group", "MikeForce"];

	private _markerType = "b_inf";
	if (_unit getUnitTrait "Medic") then {_markerType = "b_med"};
	if (_unit getUnitTrait "Engineer") then {_markerType = "b_maint"};
	if (_unit getUnitTrait "ExplosiveSpecialist") then {_markerType = "b_Ordnance"};
	if (_unit getUnitTrait "vn_artillery") then {_markerType = "b_support"};

	//Easiest way to check if it exists
	if (markerShape _unitMarker == "") then {
		createMarkerLocal [_unitMarker, [0,0,0]];
	};
	_unitMarker setMarkerTextLocal name _unit;
	_unitMarker setMarkerShapeLocal "ICON";
	_unitMarker setMarkerTypeLocal _markerType;

	_activePlayerMarkers pushBack _unitMarker;

	private _healthState = lifeState _unit;
	private _incapacitated = alive _unit && (_unit getVariable ["vn_revive_incapacitated", false] || _healthState == "INCAPACITATED");

	if (alive _unit) then {
		if (_incapacitated) then {
			_unitMarker setMarkerColorLocal "ColorRed";
		} else {
			_unitMarker setMarkerColorLocal "ColorBLUFOR";
		};
	} else {
		_unitMarker setMarkerColorLocal "ColorGrey";
	};

	//Special case if player is in vehicle.
	if (vehicle _unit != _unit) then {
		vn_mf_player_markers_manned_vehicles pushBackUnique vehicle _unit;
		_unitMarker setMarkerAlphaLocal 0;
	} else {
		_unitMarker setMarkerAlphaLocal 1;
	};
} forEach allPlayers;

//Add markers for vehicles.
{
	private _vehicle = _x;
	private _crew = crew _vehicle select {isPlayer _x};
	//If somehow we've got a vehicle in this list with no player crew.
	if (_crew isEqualTo []) exitWith {};

	private _vehicleMarker = format ["player_marker_vehicle_%1", netId _vehicle];
	_activeVehicleMarkers pushBack _vehicleMarker;

	//Easiest way to check if it exists
	if (markerShape _vehicleMarker == "") then {
		createMarkerLocal [_vehicleMarker, [0,0,0]];
		_vehicleMarker setMarkerColorLocal "ColorBLUFOR";
		_vehicleMarker setMarkerShapeLocal "ICON";
		_vehicleMarker setMarkerAlphaLocal 1;

		private _markerType = call {
			if (_vehicle isKindOf "Helicopter") exitWith {"b_air"};
			if (_vehicle isKindOf "Plane") exitWith {"b_plane"};
			if (_vehicle isKindOf "StaticMortar") exitWith {"b_mortar"};
			if (_vehicle isKindOf "Boat_F") exitWith {"b_naval"};
			if (_vehicle isKindOf "Tank") exitWith {"b_armor"};
			if (_vehicle isKindOf "vn_howitzer_base") exitWith {"b_art"};
			if (_vehicle isKindOf "vn_static_l60mk3_base" || _vehicle isKindOf "vn_static_m45_base" || _vehicle isKindOf "vn_static_l70mk2_base" || _vehicle isKindOf "vn_wheeled_m54_mg_02_base") exitWith {"b_antiair"};
			if (_vehicle isKindOf "StaticMGWeapon") exitWith {"b_installation"};
			if (_vehicle isKindOf "vn_wheeled_m54_fuel_base" || _vehicle isKindOf "vn_wheeled_m54_ammo_base" || _vehicle isKindOf "vn_wheeled_m54_repair_base") exitWith {"b_support"};
			"b_motor_inf"
		};

		_vehicleMarker setMarkerTypeLocal _markerType;
	};

	private _vehicleName = getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
	private _crewCount = count _crew;
	private _crewDisplay = 0;
	if (_crewCount - 1 <= 0) then {
		_crewDisplay = "";
	} else {
		_crewDisplay = format [" + %1", (_crewCount - 1)];
	};
	_vehicleMarker setMarkerTextLocal format [localize "STR_vn_mf_player_markers_vehicle_marker", _vehicleName, name (_crew select 0), _crewDisplay];
} forEach vn_mf_player_markers_manned_vehicles;

//Prune markers for players that have left.
private _inactiveMarkers = (vn_mf_player_markers - _activePlayerMarkers) + (vn_mf_player_markers_vehicle_markers - _activeVehicleMarkers);

{
	deleteMarker _x;
} forEach _inactiveMarkers;

vn_mf_player_markers = _activePlayerMarkers;
vn_mf_player_markers_vehicle_markers = _activeVehicleMarkers;