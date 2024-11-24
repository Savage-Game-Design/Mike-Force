/*
    File: fn_settrait.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Sets traits on player. Server local.

		[!:warning] The `_player` variable is passsed from the parent scope!
		[!:warning] This function should not be called directly!
    
    Parameter(s):
		_trait - Trait [String]
		_agent - Not used [Object]
    
    Returns: nothing
    
    Example(s): none
*/

params ["_trait","_agent"];

private _trait_config = (missionConfigFile >> "gamemode" >> "traits" >> _trait);

// make sure player is witin 20m of a duty officer
if !(vn_mf_duty_officers inAreaArray [getPos _player, 20, 20, 0, false, 20] isEqualTo []) then
{
	private _players_with_selected_trait = [_trait] call vn_mf_fnc_traits_db_get;

	// remove disconnected users
	[_trait] call vn_mf_fnc_traits_db_prune;

	private _group_ID = _player getVariable ["vn_mf_db_player_group", "FAILED"];
	// check if group is over limit for trait
	private _limit = getNumber (missionConfigFile >> "gamemode" >> "teams" >> _group_ID >> "rolelimits" >> _trait);
	private _allowed = (count (_selected_traits select {_x getVariable ["vn_mf_db_player_group", "FAILED"] isEqualTo _group_ID}) < _limit);

	_current_trait = _player getVariable ["vn_mf_dyn_trait_set", ""];

	if (_allowed || _trait isEqualTo _current_trait) then
	{

		switch (true) do {
			// no player trait currently set -- add the new trait
			// special case, needs to come first otherwise gets processed
			// by the new_trait != current_trait block
			case (_current_trait isEqualTo "") : {
				[_trait, _player] call vn_mf_fnc_traits_player_add_trait;
				[_trait, _player] call vn_mf_fnc_traits_db_push;
				["TrainingSucceeded"] remoteExecCall ["para_c_fnc_show_notification", _player];
			};
			// a different trait was selected -- swap the assigned trait
			case (_trait isNotEqualTo _current_trait) : {
				[_current_trait, _player] call vn_mf_fnc_traits_player_remove_trait;
				[_current_trait, _player] call vn_mf_fnc_traits_db_pop;
				[_trait, _player] call vn_mf_fnc_traits_player_add_trait;
				[_trait, _player] call vn_mf_fnc_traits_db_push;
				["TrainingSwapped"] remoteExecCall ["para_c_fnc_show_notification", _player];
			};
			// the same trait selected -- remove the existing trait
			case (_trait isEqualTo _current_trait) : {
				[_trait, _player] call vn_mf_fnc_traits_player_remove_trait;
				[_trait, _player] call vn_mf_fnc_traits_db_pop;
				["TrainingRemoved"] remoteExecCall ["para_c_fnc_show_notification", _player];
			};
		};
	}
	else
	{
		{["TrainingFailedOneTraitPerTeam"] call para_c_fnc_show_notification} remoteExecCall ["call",_player];
	};

	// broadcast any trait changes we've made across all clients
	// do this late to avoid up to 3x publicVariable calls within the logic above
	publicVariable "vn_mf_traits_map";

	[_trait, _allowed] call BIS_fnc_log;

	// reset the duty officer wheel menu on the client
	[] remoteExecCall ["vn_mf_fnc_action_trait",_player];
};
