/*
	File: fn_sites_attempt_teardown.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Runs the site's teardown check, and tears it down if the check passes.
	
	Parameter(s):
		_siteId - ID of the site to attempt teardown on [NUMBER]
	
	Returns:
		Site has been torn down [BOOL]
	
	Example(s):
		[parameter] call vn_fnc_myFunction
*/
params ["_siteId"];

private _siteKey = format ["site_%1", _siteId];

private _siteStore = missionNamespace getVariable [_siteKey, objNull];

if (isNull _siteStore) exitWith {};

private _teardownCondition = _siteStore getVariable ["site_teardown_condition", {true}];
if ([_siteStore] call _teardownCondition) exitWith
{
	[_siteStore] call vn_mf_fnc_sites_teardown_site;
	true
};

false



