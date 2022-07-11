/*
    File: fn_player_rank_up.sqf
	
	Author: Savage Game Design
    Public: No

    Description:
		changes players rank and displays info

    Parameter(s):
		// _name - award config name [STRING]		*ToDo: Recheck
		// _rank - award level [NUMBER]				*ToDo: Recheck

    Returns: nothing

    Example(s):
		// [_rank] call vn_mf_fnc_player_rank_up;	*ToDo: Recheck
*/

params ["_name","_rank"];
private _last_rank = missionNamespace getVariable ["vn_mf_last_rank",vn_mf_starting_rank];
private _last_rank_text = missionNamespace getVariable ["vn_mf_last_rank_text","Private"];
private _diff = (_rank-_last_rank);

([player] call vn_mf_fnc_unit_to_rank) params ["_icon", "_rank_text", "_pointsneeded"];

missionNamespace setVariable ["vn_mf_last_rank",_rank];

if(missionNamespace getVariable ["para_infopanel_isInit",true])exitWith
{
	//disable initCheck
	missionNamespace setVariable ["para_infopanel_isInit",false];
	missionNamespace setVariable ["vn_mf_last_rank_text",_rank_text];
};

// check if rank has changed
if (_last_rank_text isEqualTo _rank_text) then
{
	// same rank - only Rankpoints added
	[format["+ %1 %2",_diff,localize "STR_vn_mf_rankpoint_short"],"",true] call para_c_fnc_infopanel_addToQueue;
} else {
	// rank changed
	[localize "STR_vn_mf_levelup", _icon] call para_c_fnc_infopanel_addToQueue;
	// store last rank
	missionNamespace setVariable ["vn_mf_last_rank_text",_rank_text];
};

