/*
    File: fn_veh_load.sqf
    Author: Ridderrasmus
    Public: No

    Description:
	    Loads saved vehicle data.

    Parameter(s):
        _vehData - The data to load [ARRAY]

    Returns: nothing


    Example(s):
	    ["_id", "_class", "_loc", "_data", "_dataCargo", ["_packaged", false]] call vn_mf_fnc_veh_load;
*/

params ["_vehData"];

_vehData params ["_id", "_class", "_loc", "_data", "_dataCargo", ["_packaged", false]];

/* ONLY WORKS ONCE DOUBLE CHECKING IN MAIN MIKE FORCE IS IMPLEMENTED
_veh = [_id] call vn_mf_fnc_veh_asset_get_by_id select struct_veh_asset_info_m_vehicle;
*/

_vehicles = vehicles select {typeOf _x == _class && !(_x getVariable ["rid_loaded", false])};
//_vehicles = _vehicles select {_x call compile preprocessFileLineNumbers "rid_save_sys\rid_fn_area_check.sqf"};
if (count _vehicles >= 1) then {
	_veh = (_vehicles select 0);
	_veh setVariable ["rid_loaded", true, true];
	_id call vn_mf_fnc_veh_asset_unlock_vehicle;


	// Load vehicle position and direction
	_veh setPosWorld (_loc select 0);
	_veh setVectorDirAndUp (_loc select 1);


	// Load saved damage and fuel
	_veh setDamage (_data select 0);
	_veh setFuel (_data select 1);
	

	// Empty vehicle turrets of ammo and put the saved ammo back in
	_mags = (_data select 2) select 0;
	_turretsData = (_data select 2) - _mags;

	{
		_turret = _x;
		{
			_veh removeMagazineTurret[_x, _turret];
		}forEach (_veh magazinesTurret _turret);
	}forEach allTurrets _veh;

	{
		_veh addMagazine _x;
	} forEach _mags;


	// Empty vehicle inventory and put the saved inventory back in
	_inv = (_data select 3);

	[_veh, _inv] call vn_mf_fnc_inv_set_data;


	// Load saved fuel and ammo cargo
	if (_dataCargo select 0 != -1) then {
		_veh setFuelCargo (_dataCargo select 0);
	};
	if (_dataCargo select 1 != -1) then {
		_veh setAmmoCargo (_dataCargo select 1);
	};

	if (_packaged) then {
		[_veh] call vn_mf_fnc_veh_asset_package_wreck;
	};
};

