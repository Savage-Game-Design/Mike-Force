/*
	File: fn_veh_asset_setup_package_wreck_action_local.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Handles adding a "package for slingloading" action to the local player, when appropriate, for a specific vehicle.


	Parameter(s):
		_target - Object addAction is to be added to [Object]

	Returns: nothing

	Example(s): none
*/

params ["_target"];

private _trigger = createTrigger ["EmptyDetector", _target, false];
_trigger attachTo [_target];
_trigger setTriggerArea [75, 75, 0, false, -1];
_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trigger setVariable ["vehicle", _target];
_trigger setTriggerStatements [
	"this && surfaceIsWater getPos thisTrigger && vehicle player in thisList",
	"[thisTrigger getVariable 'vehicle'] call vn_mf_fnc_veh_asset_add_package_underwater_wreck_action_local",
	"[thisTrigger getVariable 'vehicle'] call vn_mf_fnc_veh_asset_remove_package_underwater_wreck_action_local"
];

_target addEventHandler ["Deleted", {
	params ["_object"];
	private _trigger = _object getVariable "veh_asset_trigger";
	if (!isNil "_trigger") then {
		[_object] call vn_mf_fnc_veh_asset_remove_package_underwater_wreck_action_local;
		deleteVehicle _trigger;
	};
}];


[_target] call vn_mf_fnc_veh_asset_add_package_wreck_action_local;