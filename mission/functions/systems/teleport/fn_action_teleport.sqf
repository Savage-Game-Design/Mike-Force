/*
	File: fn_action_teleport.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Adds action to teleport

	Parameter(s):
		_agent - existing object [Object]
		_str_loc - localized string [String]
		_location - requested supplies [String]
		_image - image path [String]
	
	Returns: nothing
	
	Example(s):
		call vn_mf_fnc_action_teleport
*/

private _baseConfig = missionConfigFile >> "gamemode" >> "teleporters";

{
	private _teleporterConfig = _x;

	private _object = missionNamespace getVariable [configName _teleporterConfig, objNull];
	if (!isNull _object) then {
		_object setVariable ["#para_InteractionOverlay_ConfigClass", "FastTravel"];
		private _destinations = getArray (_teleporterConfig >> "destinations");
		{
			private _destinationConfig = _baseConfig >> "destinations" >> _x;
			private _image = getText (_destinationConfig >> "image");
			private _marker = getText (_destinationConfig >> "position_marker");
			[
				_object,
				createHashMapFromArray [
					["iconPath", _image],
					["functionArguments", [configName _teleporterConfig, configName _destinationConfig]],
					["function", "vn_mf_fnc_client_teleport"],
					["text", format [localize "STR_vn_mf_goto", markerText _marker call para_c_fnc_localize]]
				]
			] call para_c_fnc_wheel_menu_add_obj_action;
		} forEach _destinations;
	};
} forEach ("true" configClasses (_baseConfig >> "objects"))