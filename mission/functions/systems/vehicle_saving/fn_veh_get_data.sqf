/*
    File: fn_veh_get_data.sqf
    Author: Ridderrasmus
    Public: No

    Description:
	    Gathers information about the given vehicle and returns it.

    Parameter(s):
        _veh - The vehicle to collect information about [OBJ]

    Returns: 
		[ARRAY] - Array containing the following information:
			[0] - Asset ID
			[1] - Vehicle class
			[2] - Array containing position and direction of vehicle
				[0] - X
				[1] - Y
				[2] - Z
				[3] - Direction
			[3] - Array containing health, fuel, turret magazines, and inventory of vehicle
				[0] - Health
				[1] - Fuel
				[2] - Turret magazines
				[3] - Array containing cargo inventory of vehicle
			[4] - Array containing cargo fuel and ammo of vehicle
				[0] - Cargo fuel
				[1] - Cargo ammo
			[5] - Whether vehicle is a packaged wreck or not


    Example(s):
	    [AMassiveTruck] call vn_mf_fnc_veh_get_data;
*/


// TODO: Add support for backpack inventory and weapon accessories

params ["_veh"];


_weaponsData = [(magazinesAmmo [_veh, true])];

_vehInventory = [_veh] call vn_mf_fnc_inv_get_data;


_id = _veh getVariable "vehAssetId";
_class = typeOf _veh;
_loc = [getPos _veh, getDir _veh];
_data = [damage _veh, fuel _veh, _weaponsData, _vehInventory];
_dataCargo = [getFuelCargo _veh, getAmmoCargo _veh];
_packaged = ((_class splitString "-") select 0 == "vn_us_komex_medium_01");


_vehData = [_id, _class, _loc, _data, _dataCargo, _packaged];
return _vehData;