/*
    File: eh_EntityRespawned.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Entity respawned event handler, used to reapply unit loadout after death.

    Parameter(s):
		_entity - respawned entity [OBJECT]
		_corpse - corpse/wreck [OBJECT]

    Returns: nothing

    Example(s):
		Not called directly.
*/

params
[
	"_entity",
	"_corpse"
];
// respawn player with same loadout as before death
if (isPlayer _entity) then
{
	// get loadout from body
	private _loadout = getUnitLoadout _corpse;

	// get dropped weaponholders
	private _weaponholders = _corpse getVariable ["vn_mf_dyn_weaponholders",[]];
	{
		if (!isnull _x) then {
			private _weaponholder = _x;
			{
				private _type = getNumber(configfile >> "cfgweapons" >> (_x select 0) >> "type");
				switch _type do
				{
					case 1: {_loadout set [0,_x]};
					case 4: {_loadout set [1,_x]};
				};
			} forEach (weaponsItemsCargo _weaponholder);
			// remove weaponholder
			deletevehicle _weaponholder;
		};
	} foreach _weaponholders;

	// Check if ACRE is running
	if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
		// Check if the corpse has a radio
		private _radioCheck = [_corpse] call acre_api_fnc_hasRadio;
		if (_radioCheck) then {
			// Replace any radios with their base class
			// We need to do this because ACRE has a finite number of radio classes available and it breaks if they all get used.
			_corpse setUnitLoadout [[_corpse] call acre_api_fnc_filterUnitLoadout, false];
		};
	};

	// restore loadout
	_entity setUnitLoadout [_loadout, false];

	// Activate ACRE
	if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
		[{
			params ["_entity"];
			private _radioCheck = [_entity] call acre_api_fnc_hasRadio;
			if (_radioCheck) then {
				// Get all radios on the player and set active to enable hotkeys
				private _radios = _entity call acre_api_fnc_getCurrentRadioList;
				{[(_radios select _x)] call acre_sys_radio_fnc_setActiveRadio} forEach _radios;
			};
		// Wait one second and execute the above
		}, [_entity], 1] call CBA_fnc_waitAndExecute;
	};


	// wipe out unused data
	_corpse setVariable ["vn_mf_dyn_weaponholders",nil,true];
};
