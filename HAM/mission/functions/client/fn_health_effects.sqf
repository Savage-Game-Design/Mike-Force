/*
    File: fn_health_effects.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Sets health stats based effects on player.

    Parameter(s): none

    Returns: nothing

    Example(s):
		call vn_mf_fnc_health_effects;
*/

private _stamina_scheme = "Default";
// disable spriting if player is thirsty
if (player getVariable ["vn_mf_db_thirst", 1] isEqualTo 0) then
{
	_stamina_scheme = "FastDrain";
	player allowSprint false;
}
else
{
	player allowSprint true;
};

// force walk if player is hungry
if (player getVariable ["vn_mf_db_hunger", 1] isEqualTo 0) then
{
	_stamina_scheme = "Exhausted";
	player forceWalk true;
}
else
{
	player forceWalk false;
};

// disable sprinting if player has medical condition (attributes) eg. poison or diarrhea
if (count (player getVariable ["vn_mf_db_attributes", []]) isEqualto 0) then
{
  player allowSprint true;
}
else
{
  _stamina_scheme = "Exhausted";
  player allowSprint false;
};

setStaminaScheme _stamina_scheme;
