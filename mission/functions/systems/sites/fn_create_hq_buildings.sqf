/*
	File: fn_create_hq_buildings.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Creates buildings for a PAVN HQ.
	
	Parameter(s):
		_position - Position [Position]
	
	Returns: nothing
	
	Example(s): none
*/

params ["_position"];

[_position, 20] call para_s_fnc_hide_foliage;

vn_mf_hq_composition = [
	["Land_vn_o_shelter_01",[-0.541992,2.78516,0],0,1,0,[0,0],"","",true,false], 
	["Land_vn_pavn_weapons_stack3",[0.99707,2.85059,0],65.7312,1,0,[0,0],"","",true,false], 
	["Land_vn_pavn_weapons_stack1",[-1.94336,2.70313,0.00320292],125.043,1,0,[0,-0],"","",true,false], 
	["Land_vn_o_shelter_01",[3.8125,2.74316,0],0,1,0,[0,0],"","",true,false], 
	["Land_vn_pavn_weapons_stack2",[4.29102,2.57031,0.00285816],32.5782,1,0,[0,0],"","",true,false], 
	["Land_vn_o_shelter_02",[1.21582,-6.43945,0],193.762,1,0,[0,0],"","",true,false], 
	["vn_o_nva_static_dshkm_high_01",[-6.22266,-2.72168,-0.0749993],255.893,1,0,[0,0],"","",true,false], 
	["Land_vn_woodentable_small_f",[0.217773,-7.01855,0],324.084,1,0,[0,0],"","",false,false], 
	["vn_o_prop_t102e_01",[0.24707,-7.00684,0.9],222.587,1,0,[0,0],"","",false,false], 
	["vn_o_nva_static_dshkm_high_01",[3.37109,6.85156,-0.0749993],15.0513,1,0,[0,0],"","",true,false], 
	["vn_o_nva_static_dshkm_high_01",[5.81836,-5.98047,-0.0749993],130.326,1,0,[0,-0],"","",true,false], 
	["Land_vn_o_trench_firing_01",[-7.31543,-3.46191,0],249.218,1,0,[0,0],"","",false,false], 
	["Land_vn_o_trench_firing_01",[3.63379,7.58398,0],15.3497,1,0,[0,0],"","",false,false], 
	["Land_vn_o_trench_firing_01",[6.83301,-6.43848,0],131.823,1,0,[0,-0],"","",false,false], 
	["Land_vn_o_tower_01",[-14.6172,15.9551,0],41.257,1,0,[0,0],"","",false,false], 
	["Land_vn_o_tower_01",[23.667,5.99023,0],165.404,1,0,[0,-0],"","",false,false], 
	["Land_vn_o_tower_01",[-2.19238,-25.3643,0],267.329,1,0,[0,0],"","",false,false]
];

private _hqObjects = [_position, 0, vn_mf_hq_composition] call BIS_fnc_objectsMapper;
{
    if (_x isKindOf "Land_vn_o_trench_firing_01") then {
        _x setVectorUp (surfaceNormal getPos _x);
    };

	if (_x isKindOf "StaticWeapon") then {
		_x setVectorUp (surfaceNormal getPos _x);
		_x setPos [getPos _x # 0, getPos _x # 1, 0];
	};
} forEach _hqObjects;

_hqObjects