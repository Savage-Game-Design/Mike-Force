/*
	File: fn_player_health_stats.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Downtick all players health each run

	Parameter(s):
		_hunger_loss_factor - Loss factor [Number, defaults to 1.0]
		_thirst_loss_factor - Loss factor [Number, defaults to 1.0]
		_hunger_loss_rate - Loss rate [Number, defaults to 0.005]
		_thirst_loss_rate - Loss rate [Number, defaults to 0.01]
		_hunger_min - Minimum [Number, defaults to 0]
		_thirst_min - Minimum [Number, defaults to 0]
		_hunger_max - Maximum [Number, defaults to 1]
		_thirst_max - Maximum [Number, defaults to 1]
		_hunger_attributes_config - Attributes [Array[], defaults to [[], []]]
		_thirst_attributes_config - Attributes [Array[], defaults to [[], []]]

	Returns: nothing

	Example(s):
		Call vn_mf_fnc_player_health_stats;
*/

params [
	["_hunger_loss_factor",1.0],
	["_thirst_loss_factor",1.0],
	["_hunger_loss_rate",0.005],
	["_thirst_loss_rate",0.01],
	["_hunger_min",0],
	["_thirst_min",0],
	["_hunger_max",1],
	["_thirst_max",1],
	["_hunger_attributes_config",[[],[]]],
	["_thirst_attributes_config",[[],[]]]
];

private _prefix = "vn_mf_db_";
private _config = (missionConfigFile >> "gamemode" >> "vars" >> "players");
private _blacklisted = getArray(_config >> "blacklisted");

{
	private _player = _x;
	if (_player getVariable ["vn_mf_dyn_issetup", false]) then
	{
		private _player_thirst_factor = _thirst_loss_factor;
		private _player_hunger_factor = _hunger_loss_factor;
		private _attributes = _player getVariable ["vn_mf_db_attributes",[]];
		// example of now to handle _attributes: if afflicted with a diuretic increase thirst loss 100%
		{
			if (_x in _attributes) then
			{
				_player_thirst_factor = _player_thirst_factor * ((_thirst_attributes_config select 1) select _forEachIndex);
			};
		} forEach (_thirst_attributes_config select 0);
		{
			if (_x in _attributes) then
			{
				_player_hunger_factor = _player_hunger_factor * ((_hunger_attributes_config select 1) select _forEachIndex);
			};
		} forEach (_hunger_attributes_config select 0);

		[[_player],"hunger",-(_hunger_loss_rate * _player_hunger_factor)] call vn_mf_fnc_change_player_stat;
		[[_player],"thirst",-(_thirst_loss_rate * _player_thirst_factor)] call vn_mf_fnc_change_player_stat;

		// force all players to save every 60 seconds to prevent roll back if server crashes
		_ticktime = diag_tickTime;
		_savetime = _player getVariable ["vn_mf_savetime",0];
		if (_ticktime > _savetime) then
		{
			_player setVariable ["vn_mf_savetime",_ticktime + 60];
			_uid = getPlayerUID _player;
			private _vardata = [];
			if !(isNull _player) then
			{
				// remove blacklisted vars
				private _all_player_vars = (allVariables _player) - _blacklisted;
				// filter for proper prefix and populate array to be saved
				{
					_vardata pushBack [_x,(_player getVariable _x)];
				} forEach (_all_player_vars select {_x find _prefix == 0});

				// save data
				["SET", (_uid + "_data"), _vardata] call para_s_fnc_profile_db;

				// save players loadout
				["SET", (_uid + "_loadout"), getUnitLoadout _player] call para_s_fnc_profile_db;

				//[_player,_uid,_vardata] call BIS_fnc_log;
			};
		};
	};

} forEach allPlayers;
