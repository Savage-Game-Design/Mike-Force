/*
    File: fn_eatdrink.sqf
    Author: Savage Game Design
    Public: No

    Description:
        Changes water and food and can brodcast changes to player.
		[!:warning] The `_player` variable is passsed from the parent scope!
		[!:warning] This function should not be called directly!

    Parameter(s):
		_water - Water level [Number]
		_food - Food level [Number]
		_item - item class [String]

    Returns: nothing

    Example(s): none
*/

params ["_water","_food","_item"];

// update water
if !(_water isEqualTo 0) then
{
	[[_player],"thirst",_water] call vn_mf_fnc_change_player_stat;
};
// update food
if !(_food isEqualTo 0) then
{
	[[_player],"hunger",_food] call vn_mf_fnc_change_player_stat;
};

// set random attributes
private _item_config = (missionConfigFile >> "CfgItemInteractions" >> _item);
if (isClass _item_config) then
{
	private _payload = [];
	{
		_x params ["_attribute_name",["_chance",0.05]];
		if (random 1 < _chance) then
		{
			private _attributes = _player getVariable ["vn_mf_db_attributes",[]];
			_attributes pushBackUnique _attribute_name;
			private _vardata = ["vn_mf_db_attributes",_attributes];
			_player setVariable _vardata;
			_payload pushBack _vardata;
		};
	} forEach getArray(_item_config >> "attributes");

	{
		_x params ["_attribute_name",["_chance",0.05]];
		if (random 1 < _chance) then
		{
			private _attributes = _player getVariable ["vn_mf_db_attributes",[]];
			private _id = _attributes find _attribute_name;
			if (_id != -1) then
			{
				_attributes deleteAt _id
			};
			private _vardata = ["vn_mf_db_attributes",_attributes];
			_player setVariable _vardata;
			_payload pushBack _vardata;
		};
	} forEach getArray(_item_config >> "cures");

	// set vars on player
	if !(_payload isEqualTo []) then
	{
		[_payload] remoteExecCall ["para_c_fnc_set_local_var",_player];
	};
};
