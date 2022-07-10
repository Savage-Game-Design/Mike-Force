/*
    File: fn_get_squad_composition.sqf
    Author: Savage Game Design
    Public: No
    
	Description:
		Retrieves the units that should be in a squad of a given type, side and size.
	
	Parameter(s):
		_type - Type of squad. [STRING]
		_side - Side the squad should be on [SIDE]
		_size - Size of the squad [NUMBER]
	
	Returns:
		Array of unit class names, with _size members [ARRAY]
	
	Example(s):
		//Make the call paradigm, which delegates to the mission.
		["PATROL", west, 5] call para_g_fnc_spawning_get_squad_composition
*/

params ["_type", "_side", "_squadSize", ["_pos", []]];

//Here, we select a faction, and use that to decide on a squad type from the list of squad compositions.
//Right now, this is hacky, but it works, using hard-coded positions on cam_lao_nam.
//Need to be tidied up in the future - possibly moving into a config file too.

private _resolvedType = "";
private _faction = "";

if (_pos isEqualTo []) then 
{
	_faction = "nva";
} 
else 
{
	if (_pos distance2D [14296, 5932, 0] < 7000) exitWith {
		_faction = "vc";
	};

	if (_pos # 0 < 6303) exitWith {
		_faction = "dac_cong";
	};

	_faction = "nva";
};

if (_type == "PATROL") then 
{
	_resolvedType = switch (_faction) do {
		case "vc":
		{
			selectRandom ["vc_regional_sentry", "vc_main_sentry", "vc_local_sentry", "vc_local_patrol"]
		};
		case "dac_cong":
		{
			selectRandom ["nva_dac_cong_sentry"]
		};
		default
		{
			selectRandom ["nva_main_sentry", "nva_main_patrol"]
		};
	};
};

if (_type == "STANDARD") then 
{
	_resolvedType = switch (_faction) do {
		case "vc":
		{
			selectRandom ["vc_regional_standard", "vc_main_standard", "vc_local_standard", "vc_regional_cover_element", "vc_local_cover_element", "vc_main_cover_element", "vc_regional_at", "vc_main_at", "vc_local_at"]
		};
		case "dac_cong":
		{
			selectRandom ["nva_dac_cong_standard", "nva_dac_cong_standard", "nva_dac_cong_at", "nva_dac_cong_cover_element"]
		};
		default 
		{
			selectRandom ["nva_main_standard", "nva_main_standard", "nva_main_cover_element", "nva_main_at"];
		}; 
	};
};

//Cache this in memory, so it can be temporarily updated at runtime.
private _key = format ["vn_mf_squad_%1_%2", _side, _resolvedType];
private _squadTemplate = missionNamespace getVariable _key;

if (isNil "_squadTemplate") then 
{
	private _fnc_resolveUnitReferences = {
		params ["_unitArray"];
		private _classArray = [];
		{
			if (_x isEqualType []) then {
				_classArray pushBack ([_x] call _fnc_resolveUnitReferences);
			} 
			else 
			{
				private _unitConfig = (missionConfigFile >> "gamemode" >> "units" >> str _side >> _x);
				switch true do 
				{
					case (isArray _unitConfig): {_classArray pushBack ([getArray (_unitConfig)] call _fnc_resolveUnitReferences)};
					case (isText _unitConfig): {_classArray pushBack (getText (_unitConfig))};
					default 
					{
						if (_x isKindOf "Man") then 
						{
							_classArray pushBack _x;
						} 
						else 
						{
							diag_log format ["VN MikeForce ERROR: Bad unit in squad composition %1", _x];
							_classArray pushBack "C_Soldier_VR_F";
						};
					};
				};
			};
		} forEach _unitArray;
		_classArray
	};

	_squadTemplate = getArray (missionConfigFile >> "gamemode" >> "squad_compositions" >> str _side >> _resolvedType);
	//Resolve any references to a unit type, rather than a unit.
	_squadTemplate = [_squadTemplate] call _fnc_resolveUnitReferences;
	if (_squadTemplate isEqualTo []) then {
		_squadTemplate = ["C_Soldier_VR_F"];
	};
	missionNamespace setVariable [_key, _squadTemplate];
};

private _squad = [];
private _index = 0;
private _templateSize =	count _squadTemplate;
for "_i" from 1 to _squadSize do 
{
	private _class = _squadTemplate select _index;
	while {_class isEqualType []} do {_class = selectRandom _class;};
	_squad pushBack _class;
	_index = (_index + 1) mod _templateSize;
};
_squad