/*
    File: fn_settrait.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Sets traits on player.
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
	private _current_traits_map = missionNamespace getVariable "vn_mf_traits_map";
    private _selected_traits = _current_traits_map get _trait;

	// remove disconnected users
	private _to_remove = [];
	{
		if (isNull _x || !isPlayer _x) then
		{
			_to_remove pushBack _forEachIndex;
		}
	} forEach _selected_traits;
	{
		_selected_traits deleteAt _x
	}
	forEach _to_remove;
	private _group_ID = _player getVariable ["vn_mf_db_player_group", "FAILED"];
	// check if group is over limit for trait
	private _limit = getNumber (missionConfigFile >> "gamemode" >> "teams" >> _group_ID >> "rolelimits" >> _trait);
	private _allowed = (count (_selected_traits select {_x getVariable ["vn_mf_db_player_group", "FAILED"] isEqualTo _group_ID}) < _limit);

	_player_current_trait = _player getVariable ["vn_mf_dyn_trait_set", ""];

	if (_allowed || _trait isEqualTo _player_current_trait) then
	{
		//We need these to set the isCustom flag on setUnitTrait!
		private _vanilla_traits = [ 
			"audibleCoef", 
			"camouflageCoef", 
			"loadCoef", 
			"engineer", 
			"explosiveSpecialist", 
			"medic", 
			"UAVHacker" 
		];

		// only allow one trait per player, if one is set then remove existing
		_already_set = (_player_current_trait isNotEqualTo "");
		if (_already_set) then
		{
			private _existing_traits = _current_traits_map get _player_current_trait;

			// remove existing user from other set trait
			private _to_remove = [];
			{
				if (_player isEqualTo _x) then
				{
					_to_remove pushBack _forEachIndex;
				}
			} forEach _existing_traits;

			{
				_existing_traits deleteAt _x
			} forEach _to_remove;
			// set trait to false
			[_player,[_player_current_trait, false, !(_player_current_trait in _vanilla_traits)]] remoteExecCall ["setUnitTrait",_player];
			_player setVariable ["vn_mf_dyn_trait_set", ""];
		};

		// set trait only if different from last
		if (_trait isNotEqualTo _player_current_trait) then
		{
			_selected_traits pushBackUnique _player;
            _current_traits_map set [_trait,_selected_traits];

			// Do checks for tutorial for trait
			["tookTraining", [_player, _trait]] call para_g_fnc_event_dispatch;

			// mark player as already having set a trait
			_player setVariable ["vn_mf_dyn_trait_set", _trait];

			[_player,[_trait, true, !(_trait in _vanilla_traits)]] remoteExecCall ["setUnitTrait",_player];
			{["TrainingSucceeded"] call para_c_fnc_show_notification} remoteExecCall ["call",_player];
		};

		// save changes to array and push to all players
		missionNamespace setVariable ["vn_mf_traits_map", _current_traits_map];
		publicVariable "vn_mf_traits_map";
	}
	else
	{
		{["TrainingFailedOneTraitPerTeam"] call para_c_fnc_show_notification} remoteExecCall ["call",_player];
	};

	[_trait,_allowed] call BIS_fnc_log;
};
