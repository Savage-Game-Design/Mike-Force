/*
	File: fn_action_trait.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Adds action to set unit traits
	
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
	{
        private _traitConfig = _x; 
        private _trait = configName _traitConfig;
		private _traitName = getText(_traitConfig >> "text");
		private _image = getText(_traitConfig >> "image");
		if !(_trait == "vn_artillery" && (_airSupport == 0 && _artySupport == 0)) then {
			if !(player getUnitTrait _trait) then
			{
				[
					_agent,
					createHashMapFromArray [
						["iconPath", _image],
						["functionArguments", [_trait, _agent]],
						["function", "vn_mf_fnc_client_trait"],
						["text", format [localize "STR_vn_mf_training", _traitName call BIS_fnc_localize]]
					]
				] call para_c_fnc_wheel_menu_add_obj_action;
			};
		};
	} forEach _allTraits;
} forEach vn_mf_duty_officers;
