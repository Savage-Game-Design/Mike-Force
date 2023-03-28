/*
	File: fn_zone_manager_job.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		No description added yet.
	
	Parameter(s):
		_localVariable - Description [DATATYPE, defaults to DEFAULTVALUE]
	
	Returns:
		Function reached the end [BOOL]
	
	Example(s):
		[parameter] call vn_fnc_myFunction
*/

{
	[_x] call vn_mf_fnc_zones_save_zone;
} forEach mf_s_zones;


// Identify active zones - presence < 100% - not secured?
// For each active zone, process it.
// All zones *will* have fortifications, but we're not there yet.

// Map starts in an initial state:
// - Each zone has various buildings in it, which contribute to a zone's overall stats
// - Those stats are used by the combat system to engage the players.
// - Stats are:
// -- Infantry strength
// -- Vehicle strength
// -- Anti-Air strength
// -- Artillery strength

// Combat system
// -- Attack an FOB
// -- Attack a known group of players
// -- Set up defenses
// -- Deploy mobile AA
// -- Deploy armoured support
// -- Deploy mobile artillery
// -- Establish foothold

// Building system
// -- Build camp or barracks
// -- Build vehicle depot
// -- Build tunnels
// -- Build AA battery
// -- Build SAM site
// -- Build fortification
// --- Bunkers
// --- MG Nest
// --- Spiderholes
// -- Deploy minefield
// -- Lay a roadblock or ambush

// The "zone" manager handles a few things:
// - Deploying buildings
// - Figuring out core mission objectives

// The missions then spawn in, and pass off the AI objective system, which handles spawning, tactics and strategy.
// This handles zones and gamemode flow, the other one handles organising and spawning units.

//private _store = _schedulerCurrentJob;

//For now, this uses mf_s_dir_activeZones
//Later, this should be all zones < 100 % presence, but only when spawning optimisations are in.
//private _activeZones = keys mf_s_dir_activeZones;

//private _mfPlayers = (allPlayers select {groupId group _x == "MikeForce"});
//private _ghPlayers = (allPlayers select {groupId group _x == "GreenHornets"});
//private _acavPlayers = (allPlayers select {groupId group _x == "ACAV"});

//Evaluated in context. Environment variables:
// _vehicleStrength - Vehicle strength in the zone (0-1)
// _infantryStrength - Strength of infantry in the zone (0-1)
// _artilleryStrength - Strength of artillery coverage in the zone (0-1)
// _fortificationStrength - How well fortified the zone is right now (0-1)
// _aaStrength - Strength of AA coverage over the zone (0-1)
// _desired<*>Strength - How much of the specific strength the zone needs right now (0-1)

// _vehicleDepots - Array of vehicle depots
// _camps - Array of camps
// _artillerySites - Array of artillery emplacements
// _aaSites - Array of AA sites

/*

private _fnc_considerAttack = {
	if (count mf_s_ongoing_attacks >= mf_s_max_attack_quantity) exitWith {0};
	if (serverTime - mf_s_last_attack < mf_s_min_attack_delay) exitWith {0};

	//Consider launching a counter attack.
	//Launch if zone is weak, and too many players in zone.
	if ((_infantryStrength > 0) && (_infantryStrength <= 0.3) && (count (allPlayers inAreaArray _zoneMarker) > 0)) then {
		//Possible origin zones
		private _connectedZones = getArray (missionConfigFile >> >> "map_config" >> "zones" >> _zoneMarker) apply {_x select 0};
		private _possibleOrigins = _connectedZones select {
			private _data = missionNamespace getVariable _x;
			!(_data select struct_zone_m_captured)
		};

		if (_possibleOrigins isEqualTo []) exitWith {};

		private _origin = selectRandom _possibleOrigins;
		["defend_counterattack", _zoneMarker, [["originZone", _origin]]] call vn_mf_fnc_task_create;
	};	

	//Consider launching an FOB attack.
	//Launch if zone is strong, and there's a nearby FOB.
	private _nearbyBases = para_g_bases inAreaArray [markerPos _zoneMarker, 4000, 4000, 0];
	if (_infantryStrength > 0.3 && count _nearbyBases > 0) then {
		//Launch an FOB attack.
		private _basesWithBuildingCount = _nearbyBases apply {[count (_x getVariable "para_g_buildings"), _x]};
		_basesWithBuildingCount sort false;
		private _largestBase = _basesWithBuildingCount select 0 select 1;
		["defend_base", _zoneMarker, [["originZone", _zoneMarker], ["targetBase", _largestBase]]] call vn_mf_fnc_task_create;
	};
};

private _allSites = [
	struct_zone_m_aa_sites, 
	struct_zone_m_artillery_sites, 
	struct_zone_m_camps, 
	struct_zone_m_fortifications, 
	struct_zone_m_tunnels, 
	struct_zone_m_vehicle_depots
];

{
	private _zoneData = localNamespace getVariable _x;
	private _zoneMarker = _zoneData select struct_zone_m_marker;

	private _infantryStrength = linearConversion [
		0,
		vn_mf_s_max_camps_per_zone,
		count (_zoneData select struct_zone_m_camps),
		0,
		1
	];

	//Step 1 - Consider doing an attack on the players.
	[] call _fnc_considerAttack;

	//Step 2 - Clear out any finished buildings. Would be better event driven, but this works for now. Fix it later.
	private _activeSitesCount = 0;
	{
		private _data = _zoneData select _x;
		private _activeSitesOfType = _zoneData select _x select {!(_x call vn_mf_fnc_task_is_completed)};
		_zoneData set [_x, _activeSitesOfType];
		_activeSitesCount = _activeSitesCount + count _activeSitesOfType;
	} forEach _allSites;

	if (_activeSitesCount <= 0) then
	{
		//Set zone as captured.
		//Needs to add to vn_mf_completed_zones for now.
	};

} forEach _activeZones;

*/