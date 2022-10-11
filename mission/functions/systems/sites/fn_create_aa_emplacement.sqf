/*
	File: fn_create_aa_emplacement.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Creates an AA emplacement (NVA) at the specified position.
	
	Parameter(s):
		_position - Position where to roughly spawn the AA emplacement [Position3D]
	
	Returns:
		Array in form of [[Vehicles created, units created, groups created], [AA Guns created]] [Array]
	
	Example(s):
		[[0,0,0], "heavy"] call vn_mf_fnc_create_aa_emplacement
*/

params ["_position", ["_style", "heavy"]];

private _aaGun	= ["vn_o_nva_static_dshkm_high_02", "vn_o_nva_static_zpu4"] select (_style == "heavy");

private _crewedAAGun = [[_aaGun, _position, 15, 3, true] call para_g_fnc_create_vehicle_safely, [], grpNull];
[_crewedAAGun # 0, sizeOf typeOf (_crewedAAGun # 0)] call para_s_fnc_hide_foliage;

private _vehicles = [_crewedAAGun select 0];
private _units = _crewedAAGun select 1;
private _groups = [_crewedAAGun select 2];

[[_vehicles, _units, _groups], [_crewedAAGun select 0]]