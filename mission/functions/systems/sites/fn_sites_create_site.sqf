/*
	File: fn_sites_create_site.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		No description added yet.
	
	Parameter(s):
		_type - Name of the type of site [STRING]
		_siteStore - Spawn object created during init [OBJECT]
		_setup - Code to set the site up, spawn in assets, etc [CODE]
		_setupTeardownConditionTriggers - Code to set up when _teardownCondition should be checked [CODE]
		_teardownCondition - Returns true when the site should be torn down (removed) [CODE]
		_teardown - Code that removes the site from the map when called [CODE]
	
	Returns:
		The site store containing site info [NAMESPACE]
	
	Example(s):
		[parameter] call vn_fnc_myFunction
*/
params ["_type", "_siteStore", "_setup", "_setupTeardownConditionTriggers", "_teardownCondition",  "_teardown"];

//Give the site a unique ID
private _siteId = missionNamespace getVariable ["site_current_id", 0];
_siteId = _siteId + 1;
missionNamespace setVariable ["site_current_id", _siteId];
publicVariable "site_current_id";

private _siteKey = format ["site_%1", _siteId];
missionNamespace setVariable [_siteKey, _siteStore];
publicVariable _siteKey;

// Global properties
_siteStore setVariable ["site_id", _siteId, true];
_siteStore setVariable ["site_type", _type, true];
_siteStore setVariable ["discovered", false, true];
_siteStore setVariable ["partiallyDiscovered", false, true];

// Server-only properties
_siteStore setVariable ["site_teardown_condition", _teardownCondition];
_siteStore setVariable ["site_teardown", _teardown];

//Setup the site
[_siteStore] call _setup;

private _fnc_attemptTeardown = compile format ["[%1] call vn_mf_fnc_sites_attempt_teardown", _siteId];
private _fnc_periodicallyAttemptTeardown = {[_siteKey, vn_mf_fnc_sites_attempt_teardown, _siteId, _this] call para_g_fnc_scheduler_add_job;};

//Setup the triggers which will cause _teardownCondition to be evaluated
[_siteStore] call _setupTeardownConditionTriggers;

//Register in a list of sites of this type.
private _siteTypeKey = format ["sites_%1", _type];
private _sites = missionNamespace getVariable [_siteTypeKey, []];
_sites pushBack _siteStore;
missionNamespace setVariable [_siteTypeKey, _sites];
publicVariable _siteTypeKey;

//Register in a global list of sites
private _allSites = missionNamespace getVariable ["sites", []];
_allSites pushBack _siteStore;
missionNamespace setVariable ["sites", _allSites];
publicVariable "sites";

_siteStore