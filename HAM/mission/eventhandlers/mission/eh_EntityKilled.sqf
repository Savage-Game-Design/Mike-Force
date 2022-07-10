/*
    File: eh_EntityKilled.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Entity death event handler for tracking stats.

    Parameter(s):
		_unit - entity that was killed [OBJECT]
		_killer - the killer (vehicle or person) [OBJECT]
		_instigator - person who pulled the trigger [OBJECT]
		_useEffects - destruction effects [BOOL]

    Returns: nothing

    Example(s):
    	Not called directly.
*/

params
[
	"_unit",
	"_killer",
	"_instigator",
	"_useEffects"
];

private _kill_type = "deaths";

private _is_unit_player = isPlayer _unit;
private _is_killer_player = isPlayer _killer;

if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill -
if (isNull _instigator) then {_instigator = _killer}; // player driven vehicle road kill

// record stats
if (_is_unit_player) then
{
	// record player death
	[[_unit],_kill_type] call vn_mf_fnc_change_player_stat;
	// reset hunger and thirst
	[[_unit],"hunger"] call vn_mf_fnc_change_player_stat;
	[[_unit],"thirst"] call vn_mf_fnc_change_player_stat;

	if (_is_killer_player) then
	{
		// if _killer is self add 1 to : suicides
		if (_unit isEqualTo _killer) then
		{
			_kill_type = "suicides";
			[crew _killer,_kill_type] call vn_mf_fnc_change_player_stat;
		}
		else
		{
			// _unit is another player report as - friendlyfire
			_kill_type = "friendlyfire";
			[[_instigator],_kill_type] call vn_mf_fnc_change_player_stat;
		};
	};


} else {

	if (_is_killer_player) then
	{

		if (vehicle _unit isKindOf "Man") then
		{
			// if _unit is AI check if civilian or enemy // TODO does not work on AI ??/
			if (_unit getVariable ["sideAtCreation", sideEmpty] isEqualTo civilian) then
			{
				// if civ record as - murder
				_kill_type = "murders";
				[crew _killer,_kill_type] call vn_mf_fnc_change_player_stat;
			}
			else
			{
				// if enemy record as - kill
				_kill_type = "kills";
				private _units = crew _killer;
				[_units,_kill_type] call vn_mf_fnc_change_player_stat;

			};

		}
		else
		{
			// if vehicle record as - vehiclekill
			_kill_type = "vehiclekills";
			[crew _killer,_kill_type] call vn_mf_fnc_change_player_stat;

			if (vehicle _unit isKindOf "ship") then
			{
				_kill_type = "boatkills";
				[crew _killer,_kill_type] call vn_mf_fnc_change_player_stat;
			} else {
				if (vehicle _unit isKindOf "air" && vehicle _killer isKindOf "air") then
				{
					_kill_type = "atoakills";
					[crew _killer,_kill_type] call vn_mf_fnc_change_player_stat;
				};
			};
		};
	};
};

//["EntityKilled mEH: %1 - %2", _kill_type, _this] call BIS_fnc_logFormat;
