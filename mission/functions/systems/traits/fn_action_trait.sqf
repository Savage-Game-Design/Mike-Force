/*
	File: fn_action_trait.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Adds action to set unit traits

		Client locality.
	
	Parameter(s):
		_ - not used but passed from menu [any]
		_argments - location and agent [Array]
	
	Returns: nothing
	
	Example(s):
		call vn_mf_fnc_action_trait
*/

vn_mf_fnc_client_trait = {
	['settrait', _this] call para_c_fnc_call_on_server;
};

private _allTraits = "true" configClasses (missionConfigFile >> "Gamemode" >> "Traits");

private _airSupport = ["enable_air_support", 1] call BIS_fnc_getParamValue;
private _artySupport = ["enable_arty_support", 1] call BIS_fnc_getParamValue;
{
	private _agent = _x;

	// reset any existing client-side wheel menu options
	// to only show currently available roles to a player
	_agent setVariable ["para_wheel_menu_dyn_actions", []];
	{
		private _traitConfig = _x;
		private _trait = configName _traitConfig;
		private _traitName = getText(_traitConfig >> "text");
		private _image = getText(_traitConfig >> "image");
		if !(_trait == "vn_artillery" && (_airSupport == 0 && _artySupport == 0)) then {

			// set up the base action options
			private _action_hmap = createHashMapFromArray [
				["iconPath", _image],
				["functionArguments", [_trait, _agent]],
				["function", "vn_mf_fnc_client_trait"]
			];

			if (player getUnitTrait _trait) then {
				// "Remove <trait name>" title
				_action_hmap set ["text", format [localize "STR_vn_mf_training_remove", _traitName call BIS_fnc_localize]];
				// always show icon brightly to indicate it is selected
				_action_hmap set ["selectorColorCodes", [[0.8, 0.8, 0.8, 1], [0.8, 0.8, 0.8, 1]]];
				// always show white border on the menu option
				_action_hmap set ["iconColorCodes", [[1, 1, 1, 0.95], [1, 1, 1, 0.95]]]
			} else {
				// "Add <trait name>" title
				_action_hmap set ["text", format [localize "STR_vn_mf_training_add", _traitName call BIS_fnc_localize]];
				// icons are always 'greyed' out to show that the trait is not yet selected
				// wheel menu option border will still go to white when hovered over
				_action_hmap set ["iconColorCodes", [[0.5, 0.5, 0.5, 0.8], [0.5, 0.5, 0.5, 0.8]]]
			};

			[_agent, _action_hmap] call para_c_fnc_wheel_menu_add_obj_action;

		};
	} forEach _allTraits;
} forEach vn_mf_duty_officers;
