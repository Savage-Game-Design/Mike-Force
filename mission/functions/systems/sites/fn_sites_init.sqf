/*
    File: fn_sites_init.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
        Starts the sites system, which is responsible for managing all of the AI controlled installations and building new ones.
    
    Parameter(s):
        None
    
    Returns:
        None
    
    Example(s):
        [] call vn_mf_fnc_sites_init
*/
vn_mf_s_max_camps_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_camps_per_zone");
vn_mf_s_max_aa_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_aa_per_zone");
vn_mf_s_max_artillery_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_artillery_per_zone");
vn_mf_s_max_fortifications_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_fortifications_per_zone");
vn_mf_s_max_tunnels_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_tunnels_per_zone");
vn_mf_s_max_vehicle_depots_per_zone = getNumber (missionConfigFile >> "map_config" >> "max_vehicle_depots_per_zone");


// these objects on the map are the generated site spawn locations
private _editorObjectClassName = "VR_GroundIcon_01_F";

// all the editor objects in the mission we'll convert to simple objects for site spawns
// check for presence of correct variables to ensure don't grab wrong objects
private _editorSiteObjs = (-1 allObjects 0)
    select {typeOf _x isEqualTo _editorObjectClassName}
    select {"site_type" in allVariables _x}
    select {"site_radius" in allVariables _x}
    select {"zone" in allVariables _x};

// delete the editor generated objects, replacing them with simple objects
// retaining all the data we need to generate sites
// -- replaces non-simple with simple
// -- and hides spawn locations from zeus players
private _siteSpawnObjs = _editorSiteObjs
    apply {
        private _editorSiteObj = _x;
        private _normalizedPosition = ATLToASL ((getPosATL _editorSiteObj) vectorMultiply [1, 1, 0]);
        private _spawnObj = createSimpleObject ["a3\weapons_f\empty.p3d", _normalizedPosition, false];
        (allVariables _editorSiteObj)
            apply {_spawnObj setVariable [_x, _editorSiteObj getVariable _x]};
        deleteVehicle _editorSiteObj;
        _spawnObj
    };

// unique site type names
private _siteTypeNames = _siteSpawnObjs apply {_x getVariable "site_type"};
_siteTypeNames = _siteTypeNames arrayIntersect _siteTypeNames;

/*
create a per-zone hashmap of the locations for different site types

{
    "zone_one": {
        "SiteTypeOne": [object1, object2],
        "SiteTypeTwo": [object1, object2],
        "SiteTypeThree": [object1, object2],
    },
    "zone_two": {
        "SiteTypeOne": [object1, object2],
        "SiteTypeTwo": [object1, object2],
        "SiteTypeThree": [object1, object2],
    }
}
*/

vn_mf_s_zone_site_locations = createHashmapFromArray (
    mf_s_zone_markers apply {
        private _zone = _x;
        private _hmap = createHashMap;
        _siteTypeNames
            apply {
                private _siteTypeName = _x;
                private _siteTypeSpawnObjs = _siteSpawnObjs
                    select {(_x getVariable "site_type") isEqualTo _siteTypeName}
                    select {(_x getVariable "zone") isEqualTo _zone}
                    ;

                _hmap set [_siteTypeName, _siteTypeSpawnObjs];
                nil
            };

        [_x, _hmap]
    }
);

diag_log format ["%1: Loaded all possible zone locations for sites.", _fnc_scriptName];

vn_mf_g_sites_partial_discovery_radius = 300;
publicVariable "vn_mf_g_sites_partial_discovery_radius";
vn_mf_g_sites_discovery_radius = 50;
publicVariable "vn_mf_g_sites_discovery_radius";
vn_mf_g_sites_scout_action_cooldown = 30;
publicVariable "vn_mf_g_sites_scout_action_cooldown";

missionNamespace setVariable ["sites", []];
publicVariable "sites";

private _loadSuccessful = [] call vn_mf_fnc_sites_load;

if !(_loadSuccessful) then 
{
    //Generate sites
    [] call vn_mf_fnc_sites_generate;
};

[] call vn_mf_fnc_sites_aa_reveal_targets;
