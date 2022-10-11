/*
	File: fn_create_mortar.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Creates a VC mortar at the specified position.
	
	Parameter(s):
		_position - Position where to roughly spawn the AA emplacement [Position3D]
	
	Returns:
		Array in from of [[Vehicles created, units created, groups created], [mortars]] [Array]
	
	Example(s):
		[[0,0,0], 10] call vn_mf_fnc_create_aa_emplacement
*/

params ["_position"];

private _mortar = [[selectRandom vehicles_vc_mortars, _position, 15, 3, true] call para_g_fnc_create_vehicle_safely, [], grpNull];
[_mortar # 0, sizeOf typeOf (_mortar # 0)] call para_s_fnc_hide_foliage;

private _vehicles = [_mortar select 0];
private _units = _mortar select 1;
private _groups = [_mortar select 2];

[[_vehicles, _units, _groups], [_mortar select 0]]