/*
	File: fn_veh_asset_marker_create.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Creates a marker of the specific type for every player, localized. Replaces any previous markers.

	Parameter(s):
		_id - Id of the vehicle asset [Number]
		_type - Type of marker [String]

	Returns: nothing

	Example(s): none
*/


params ["_id", "_type"];

private _vehicleInfo = [_id] call vn_mf_fnc_veh_asset_get_by_id;
private _vehicle = _vehicleInfo select struct_veh_asset_info_m_vehicle;

private _textGenerator = [
	[_type, _vehicle],
	{
		params ["_type", "_vehicle"];
		private _markerPrefix = "";
		if (_type == "WRECK") then {
			_markerPrefix = localize "STR_vn_mf_wreck";
		};

		if (_type == "IDLE") then {
			_markerPrefix = localize "STR_vn_mf_idle";
		};

		if (_type == "DISABLED") then {
			_markerPrefix = localize "STR_vn_mf_disabled";
		};

		format [
			"%1: %2",
			_markerPrefix,
			getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName")
		]
	}
];

private _markerName = format ["marker_%1", _id];
[_markerName, getPos _vehicle, _textGenerator] call para_g_fnc_create_localized_marker;

_markerName setMarkerType "mil_marker";

if (_type in ["WRECK", "DISABLED"]) then {
	_markerName setMarkerColor "ColorRed";
} else {
	_markerName setMarkerColor "ColorBlue";
};

_vehicleInfo set [struct_veh_asset_info_m_marker, _markerName];