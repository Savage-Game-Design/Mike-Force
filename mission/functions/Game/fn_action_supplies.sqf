/*
	File: fn_action_supplies.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Adds action to request supplies

	Parameter(s):
		_object - Object [Object]

	Returns: nothing

	Example(s):
		call vn_mf_fnc_action_supplies;
*/

params ["_object"];

private _gamemodeConfig = (missionConfigFile >> "gamemode");
private _supplyDropCategoryConfig = _gamemodeConfig >> "supplydrops";
private _supplyDropCategory = "true" configClasses (_supplyDropCategoryConfig);

private _fnc_supplyDropActionFromConfig = {
	params ["_category", "_supplyClass"];
	private _supply = configName _supplyClass;
	private _name = localize getText (_supplyClass >> "name");
	private _icon = getText (_supplyClass >> "icon");

	createHashMapFromArray [
		["iconPath", _icon],
		["functionArguments", [_category, _supply, _object]],
		["function", "vn_mf_fnc_client_request_supplies"],
		["text", _name]
	]
};

{
	private _category = configName _x;
	private _submenuActions = "true" configClasses (_x) apply {[_category, _x] call _fnc_supplyDropActionFromConfig};
	private _name = localize getText (_x >> "name");
	private _icon = getText (_x >> "icon");
	private _submenus = createHashMapFromArray [
		["iconPath", _icon],
		["submenuActions", _submenuActions],
		["text", _name]
	];
	
	[
		_object,
		_submenus
	] call para_c_fnc_wheel_menu_add_obj_action;
} forEach _supplyDropCategory;
