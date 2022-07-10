class respawn_short
{
	respawnType = "RESPAWN";
	time = 10;
};

class respawn_medium
{
	respawnType = "RESPAWN";
	time = 30;
};

class respawn_long
{
	respawnType = "RESPAWN";
	time = 60;
};

class wreck_short
{
	respawnType = "WRECK";
	time = 10;
};

class wreck_medium
{
	respawnType = "WRECK";
	time = 30;
};

class wreck_long
{
	respawnType = "WRECK";
	time = 60;
};

//Jeeps + Small Cars
class vn_b_wheeled_m151_01 : respawn_short {};
class vn_b_wheeled_m151_02 : respawn_short {};
class vn_b_wheeled_m151_mg_01 : respawn_medium {};
class vn_b_wheeled_m151_mg_02 : respawn_medium {};
class vn_b_wheeled_m151_mg_03 : respawn_medium {};
class vn_b_wheeled_m151_mg_04 : respawn_medium {};
class vn_b_wheeled_m151_mg_05 : respawn_medium {};
class vn_b_wheeled_m151_mg_06 : respawn_medium {};
class vn_c_car_01_01 : respawn_short {};
class vn_c_car_02_01 : respawn_short {};
class vn_c_car_03_01 : respawn_short {};
class vn_c_car_04_01 : respawn_short {};

//Transport trucks
class vn_b_wheeled_m54_01 : respawn_medium {};
class vn_b_wheeled_m54_01_airport : respawn_medium {};
class vn_b_wheeled_m54_02 : respawn_medium {};
//M109 Command Truck
class vn_b_wheeled_m54_03 : respawn_medium {};
//Repair Truck
class vn_b_wheeled_m54_repair : wreck_short {};
class vn_b_wheeled_m54_repair_airport : respawn_short {};
//Fuel trucks
class vn_b_wheeled_m54_fuel : wreck_short {};
class vn_b_wheeled_m54_fuel_airport : respawn_short {};
//Ammo truck
class vn_b_wheeled_m54_ammo : wreck_short {};
class vn_b_wheeled_m54_ammo_airport : respawn_short {};
//Gun trucks
class vn_b_wheeled_m54_mg_01 : wreck_short {};
class vn_b_wheeled_m54_mg_02 : wreck_short {};
class vn_b_wheeled_m54_mg_03 : wreck_short {};

//Armoured Cars
class vn_b_armor_m41_01_01 : wreck_long {};
class vn_o_armor_type63_01 : wreck_long {};

//APC
class vn_b_armor_m113_01 : respawn_medium {};
class vn_b_armor_m113_acav_01 : wreck_short {};
class vn_b_armor_m113_acav_02 : wreck_short {};
class vn_b_armor_m113_acav_03 : wreck_short {};
class vn_b_armor_m113_acav_04 : wreck_short {};
class vn_b_armor_m113_acav_05 : wreck_short {};
class vn_b_armor_m113_acav_06 : wreck_short {};

//Wooden boats
class vn_c_boat_01_01 : respawn_short {};
class vn_c_boat_02_01 : respawn_short {};

//US Boats
class vn_b_boat_05_01 : respawn_long {};
class vn_b_boat_06_01 : respawn_long {};
class vn_b_boat_09_01 : respawn_medium {};
class vn_b_boat_10_01 : respawn_medium {};
class vn_b_boat_11_01 : respawn_medium {};
class vn_b_boat_12_01 : respawn_medium {};
class vn_b_boat_13_01 : respawn_medium {};

//Air assets
//Cobra Helicopter
class vn_b_air_ah1g_01 : wreck_long {};
class vn_b_air_ah1g_02 : wreck_long {};
class vn_b_air_ah1g_03 : wreck_long {};
class vn_b_air_ah1g_04 : wreck_long {};
class vn_b_air_ah1g_05 : wreck_long {};
class vn_b_air_ah1g_06 : wreck_long {};
class vn_b_air_ah1g_07 : wreck_long {};
class vn_b_air_ah1g_08 : wreck_long {};
class vn_b_air_ah1g_09 : wreck_long {};
class vn_b_air_ah1g_10 : wreck_long {};

class vn_b_air_ah1g_01_usmc : wreck_long {};
class vn_b_air_ah1g_02_usmc : wreck_long {};
class vn_b_air_ah1g_03_usmc : wreck_long {};
class vn_b_air_ah1g_04_usmc : wreck_long {};
class vn_b_air_ah1g_05_usmc : wreck_long {};
class vn_b_air_ah1g_06_usmc : wreck_long {};
class vn_b_air_ah1g_07_usmc : wreck_long {};
class vn_b_air_ah1g_08_usmc : wreck_long {};
class vn_b_air_ah1g_09_usmc : wreck_long {};
class vn_b_air_ah1g_10_usmc : wreck_long {};

//Choctaw
class vn_b_air_ch34_01_01 : respawn_medium {};
class vn_b_air_ch34_03_01 : respawn_medium {};
//Choctaw gunships
class vn_b_air_ch34_04_01 : wreck_medium {};
class vn_b_air_ch34_04_02 : wreck_medium {};
class vn_b_air_ch34_04_03 : wreck_medium {};
class vn_b_air_ch34_04_04 : wreck_medium {};

//Littlebird
class C_Heli_Light_01_civil_F : respawn_short {};
class vn_b_air_oh6a_01 : respawn_short {};
class vn_b_air_oh6a_02 : wreck_medium {};
class vn_b_air_oh6a_03 : wreck_medium {};
class vn_b_air_oh6a_04 : wreck_medium {};
class vn_b_air_oh6a_05 : wreck_medium {};
class vn_b_air_oh6a_06 : wreck_medium {};
class vn_b_air_oh6a_07 : wreck_medium {};

//UH1D - Dustoff
class vn_b_air_uh1d_01_01 : respawn_medium {};
class vn_b_air_uh1d_01_02 : respawn_medium {};
class vn_b_air_uh1d_01_03 : respawn_medium {};
class vn_b_air_uh1d_01_04 : respawn_medium {};
class vn_b_air_uh1d_01_05 : respawn_medium {};
class vn_b_air_uh1d_01_06 : respawn_medium {};
class vn_b_air_uh1d_01_07 : respawn_medium {};

//UH1D - Slick
class vn_b_air_uh1d_02_01 : respawn_medium {};
class vn_b_air_uh1d_02_02 : respawn_medium {};
class vn_b_air_uh1d_02_03 : respawn_medium {};
class vn_b_air_uh1d_02_04 : respawn_medium {};
class vn_b_air_uh1d_02_05 : respawn_medium {};
class vn_b_air_uh1d_02_06 : respawn_medium {};
class vn_b_air_uh1d_02_07 : respawn_medium {};

//UH-1D Bushranger
class vn_b_air_uh1d_03_06 : wreck_medium {};

//UH1C - Hog
class vn_b_air_uh1c_01_01 : wreck_medium {};
class vn_b_air_uh1c_01_02 : wreck_medium {};
class vn_b_air_uh1c_01_03 : wreck_medium {};
class vn_b_air_uh1c_01_04 : wreck_medium {};
class vn_b_air_uh1c_01_05 : wreck_medium {};
class vn_b_air_uh1c_01_06 : wreck_medium {};
class vn_b_air_uh1c_01_07 : wreck_medium {};

//UH1C - Gunship
class vn_b_air_uh1c_02_01 : wreck_medium {};
class vn_b_air_uh1c_02_02 : wreck_medium {};
class vn_b_air_uh1c_02_03 : wreck_medium {};
class vn_b_air_uh1c_02_04 : wreck_medium {};
class vn_b_air_uh1c_02_05 : wreck_medium {};
class vn_b_air_uh1c_02_06 : wreck_medium {};
class vn_b_air_uh1c_02_07 : wreck_medium {};

//UH1C - Hornet
class vn_b_air_uh1c_03_01 : wreck_medium {};
class vn_b_air_uh1c_03_02 : wreck_medium {};
class vn_b_air_uh1c_03_03 : wreck_medium {};
class vn_b_air_uh1c_03_04 : wreck_medium {};
class vn_b_air_uh1c_03_05 : wreck_medium {};
class vn_b_air_uh1c_03_06 : wreck_medium {};
class vn_b_air_uh1c_03_07 : wreck_medium {};

//UH1C - Frog
class vn_b_air_uh1c_04_01 : wreck_medium {};
class vn_b_air_uh1c_04_02 : wreck_medium {};
class vn_b_air_uh1c_04_03 : wreck_medium {};
class vn_b_air_uh1c_04_04 : wreck_medium {};
class vn_b_air_uh1c_04_05 : wreck_medium {};
class vn_b_air_uh1c_04_06 : wreck_medium {};
class vn_b_air_uh1c_04_07 : wreck_medium {};

//UH1C - Heavy Hog
class vn_b_air_uh1c_05_01 : wreck_medium {};
class vn_b_air_uh1c_05_02 : wreck_medium {};
class vn_b_air_uh1c_05_03 : wreck_medium {};
class vn_b_air_uh1c_05_04 : wreck_medium {};
class vn_b_air_uh1c_05_05 : wreck_medium {};
class vn_b_air_uh1c_05_06 : wreck_medium {};
class vn_b_air_uh1c_05_07 : wreck_medium {};

//UH1C - ARA
class vn_b_air_uh1c_06_01 : wreck_medium {};
class vn_b_air_uh1c_06_02 : wreck_medium {};

//UH1B - Slick
class vn_b_air_uh1c_07_01 : respawn_medium {};

//UH1E - Heavy Gunship
class vn_b_air_uh1e_02_04 : wreck_medium {};

//UH1F - Slick
class vn_b_air_uh1f_01_03 : respawn_medium {};

//CH43 - Heavy Transport
class vn_i_air_ch34_01_02 : wreck_medium {};
class vn_i_air_ch34_02_01 : wreck_medium {};
class vn_i_air_ch34_02_02 : wreck_medium {};

//F4 aircraft
class vn_b_air_f4c_cap : respawn_long {};
class vn_b_air_f4c_cas : respawn_long {};
class vn_b_air_f4c_hcas : respawn_long {};
class vn_b_air_f4c_ehcas : respawn_long {};
class vn_b_air_f4c_ucas : respawn_long {};
class vn_b_air_f4c_at : respawn_long {};
class vn_b_air_f4c_mr : respawn_long {};
class vn_b_air_f4c_lrbmb : respawn_long {};
class vn_b_air_f4c_lbmb : respawn_long {};
class vn_b_air_f4c_bmb : respawn_long {};
class vn_b_air_f4c_mbmb : respawn_long {};
class vn_b_air_f4c_hbmb : respawn_long {};
class vn_b_air_f4c_gbu : respawn_long {};
class vn_b_air_f4c_cbu : respawn_long {};
class vn_b_air_f4c_sead : respawn_long {};
class vn_b_air_f4c_chico : respawn_long {};
class vn_b_air_f4b_usmc_cap : respawn_long {};
class vn_b_air_f4b_usmc_cas : respawn_long {};
class vn_b_air_f4b_usmc_hcas : respawn_long {};
class vn_b_air_f4b_usmc_ehcas : respawn_long {};
class vn_b_air_f4b_usmc_ucas : respawn_long {};
class vn_b_air_f4b_usmc_at : respawn_long {};
class vn_b_air_f4b_usmc_mr : respawn_long {};
class vn_b_air_f4b_usmc_lrbmb : respawn_long {};
class vn_b_air_f4b_usmc_lbmb : respawn_long {};
class vn_b_air_f4b_usmc_bmb : respawn_long {};
class vn_b_air_f4b_usmc_mbmb : respawn_long {};
class vn_b_air_f4b_usmc_hbmb : respawn_long {};
class vn_b_air_f4b_usmc_gbu : respawn_long {};
class vn_b_air_f4b_usmc_cbu : respawn_long {};
class vn_b_air_f4b_usmc_sead : respawn_long {};
class vn_b_air_f4b_navy_cap : respawn_long {};
class vn_b_air_f4b_navy_cas : respawn_long {};
class vn_b_air_f4b_navy_hcas : respawn_long {};
class vn_b_air_f4b_navy_ehcas : respawn_long {};
class vn_b_air_f4b_navy_ucas : respawn_long {};
class vn_b_air_f4b_navy_at : respawn_long {};
class vn_b_air_f4b_navy_mr : respawn_long {};
class vn_b_air_f4b_navy_lrbmb : respawn_long {};
class vn_b_air_f4b_navy_lbmb : respawn_long {};
class vn_b_air_f4b_navy_bmb : respawn_long {};
class vn_b_air_f4b_navy_mbmb : respawn_long {};
class vn_b_air_f4b_navy_hbmb : respawn_long {};
class vn_b_air_f4b_navy_gbu : respawn_long {};
class vn_b_air_f4b_navy_cbu : respawn_long {};
class vn_b_air_f4b_navy_sead : respawn_long {};

//Howitzer
class vn_b_army_static_m101_02 : respawn_short {};
class vn_b_sf_static_m101_02 : respawn_short {};

//Unsung
//Unsung Huey
class uns_UH1D_raaf_m60 : respawn_medium {};
class uns_UH1C_M21_M200 : wreck_medium {};

//Chinook
class uns_ch47_m60_army : respawn_medium {};

//US Boats
class uns_pbr : respawn_long {};
class uns_pbr_m10 : respawn_long {};
class uns_pbr_mk18 : respawn_long {};

//Armoured Cars
class uns_xm706e1 : wreck_short {};
class uns_xm706e2 : wreck_short {};

//Trucks
class uns_m37b1 : respawn_medium {};
class uns_m37b1_m1919 : respawn_medium {};
class uns_M35A2 : respawn_medium {};
class uns_M35A2_Open : respawn_medium {};

//Jeeps + Small Cars
class uns_willys : respawn_short {};
class uns_willys_2 : respawn_short {};
class uns_willysmg50 : respawn_short {};
class uns_willysm40 : respawn_short {};
class uns_willysmg : respawn_short {};
class uns_willys_2_usmp : respawn_short {};
class uns_willys_2_usmc : respawn_short {};
class uns_willys_2_m60 : respawn_short {};
class uns_willys_2_m1919 : respawn_short {};
