class vn_logistics
{
    class vehicle_data
    {
	class vn_defaults_extra_large
	{
		inventory_max_weight = 1200;
		inventory_max_size = 10;
	};
	class vn_defaults_large
	{
		inventory_max_weight = 600;
		inventory_max_size = 7.5;
	};
	class vn_defaults_medium
	{
		inventory_max_weight = 300;
		inventory_max_size = 5;
	};
	class vn_defaults_small
	{
		inventory_max_weight = 100;
		inventory_max_size = 2.5;
	};
	class vn_defaults_tiny
	{
		inventory_max_weight = 50;
		inventory_max_size = 1;
	};
	//Jeeps + Small Cars
	class vn_b_wheeled_m151_01 : vn_defaults_small {};
	class vn_b_wheeled_m151_01_mp : vn_defaults_small {};
	class vn_b_wheeled_m151_02_mp : vn_defaults_small {};
	class vn_b_wheeled_m151_02 : vn_defaults_small {};
	class vn_c_car_01_01 : vn_defaults_small {};
	class vn_c_car_02_01 : vn_defaults_small {};
	class vn_c_car_03_01 : vn_defaults_small {};
	class vn_c_car_04_01 : vn_defaults_small {};
	class vn_c_car_01_02 : vn_defaults_small {};
	class vn_c_wheeled_m151_01 : vn_defaults_small {};
	class vn_c_wheeled_m151_02 : vn_defaults_small {};


	//Armed Jeeps
	class vn_b_wheeled_m151_mg_01 : vn_defaults_tiny {};
	class vn_b_wheeled_m151_mg_02_mp : vn_defaults_tiny {};
	class vn_b_wheeled_m151_mg_02 : vn_defaults_tiny {};
	class vn_b_wheeled_m151_mg_03_mp : vn_defaults_tiny {};
	class vn_b_wheeled_m151_mg_03 : vn_defaults_tiny {};
	class vn_b_wheeled_m151_mg_04_mp : vn_defaults_tiny {};
	class vn_b_wheeled_m151_mg_04 : vn_defaults_tiny {};
	class vn_b_wheeled_m151_mg_05 : vn_defaults_tiny {};
	class vn_b_wheeled_m151_mg_06 : vn_defaults_tiny {};

	//APC
	class vn_b_armor_m113_01 : vn_defaults_medium {};
	class vn_b_armor_m113_acav_01 : vn_defaults_small {};
	class vn_b_armor_m113_acav_02 : vn_defaults_small {};
	class vn_b_armor_m113_acav_03 : vn_defaults_small {};
	class vn_b_armor_m113_acav_04 : vn_defaults_small {};
	class vn_b_armor_m113_acav_05 : vn_defaults_small {};
	class vn_b_armor_m113_acav_06 : vn_defaults_small {};

	//Transport trucks
	class vn_b_wheeled_m54_01 : vn_defaults_extra_large {};
	class vn_b_wheeled_m54_01_airport : vn_defaults_extra_large {};
	class vn_b_wheeled_m54_02 : vn_defaults_extra_large {};
	//M109 Command Truck
	class vn_b_wheeled_m54_03 : vn_defaults_medium {};
	//Repair Truck
	class vn_b_wheeled_m54_repair : vn_defaults_medium {};
	class vn_b_wheeled_m54_repair_airport : vn_defaults_medium {};
	//Fuel trucks
	class vn_b_wheeled_m54_fuel : vn_defaults_medium {};
	class vn_b_wheeled_m54_fuel_airport : vn_defaults_medium {};
	//Ammo truck
	class vn_b_wheeled_m54_ammo : vn_defaults_medium {};
	//Gun trucks
	class vn_b_wheeled_m54_mg_01 : vn_defaults_small {};
	class vn_b_wheeled_m54_mg_02 : vn_defaults_small {};
	class vn_b_wheeled_m54_mg_03 : vn_defaults_small {};

	//Armor
	class vn_b_armor_m41_01_01 : vn_defaults_tiny {};
	class vn_o_armor_type63_01 : vn_defaults_tiny {};
	class vn_b_armor_m48_01_01 : vn_defaults_tiny {};
	class vn_b_armor_m67_01_01 : vn_defaults_tiny {};
	class vn_i_armor_type63_01 : vn_defaults_tiny {};

	//Small VC boats
	class vn_o_boat_01_00 : vn_defaults_small {};
	class vn_o_boat_01_01 : vn_defaults_small {};
	class vn_o_boat_01_02 : vn_defaults_small {};
	class vn_o_boat_01_03 : vn_defaults_small {};
	class vn_o_boat_01_04 : vn_defaults_small {};

	class vn_o_boat_01_mg_00 : vn_defaults_tiny {};
	class vn_o_boat_01_mg_01 : vn_defaults_tiny {};
	class vn_o_boat_01_mg_02 : vn_defaults_tiny {};
	class vn_o_boat_01_mg_03 : vn_defaults_tiny {};
	class vn_o_boat_01_mg_04 : vn_defaults_tiny {};

	//Long VC Boats
	class vn_o_boat_02_00 : vn_defaults_medium {};
	class vn_o_boat_02_01 : vn_defaults_medium {};
	class vn_o_boat_02_02 : vn_defaults_medium {};
	class vn_o_boat_02_03 : vn_defaults_medium {};
	class vn_o_boat_02_04 : vn_defaults_medium {};

	class vn_o_boat_02_mg_00 : vn_defaults_small {};
	class vn_o_boat_02_mg_01 : vn_defaults_small {};
	class vn_o_boat_02_mg_02 : vn_defaults_small {};
	class vn_o_boat_02_mg_03 : vn_defaults_small {};
	class vn_o_boat_02_mg_04 : vn_defaults_small {};

	//US Boats
	class vn_b_boat_05_01 : vn_defaults_large {};
	class vn_b_boat_05_02 : vn_defaults_large {};
	class vn_b_boat_06_01 : vn_defaults_large {};
	class vn_b_boat_09_01 : vn_defaults_small {};
	class vn_b_boat_10_01 : vn_defaults_small {};
	class vn_b_boat_11_01 : vn_defaults_small {};
	class vn_b_boat_12_01 : vn_defaults_medium {};
	class vn_b_boat_13_01 : vn_defaults_medium {};

	//Air assets
	//Cobra Helicopter
	class vn_b_air_ah1g_01 : vn_defaults_tiny {};
	class vn_b_air_ah1g_02 : vn_defaults_tiny {};
	class vn_b_air_ah1g_03 : vn_defaults_tiny {};
	class vn_b_air_ah1g_04 : vn_defaults_tiny {};
	class vn_b_air_ah1g_05 : vn_defaults_tiny {};
	class vn_b_air_ah1g_06 : vn_defaults_tiny {};
	class vn_b_air_ah1g_07 : vn_defaults_tiny {};
	class vn_b_air_ah1g_08 : vn_defaults_tiny {};
	class vn_b_air_ah1g_09 : vn_defaults_tiny {};
	class vn_b_air_ah1g_10 : vn_defaults_tiny {};

	class vn_b_air_ah1g_01_usmc : vn_defaults_tiny {};
	class vn_b_air_ah1g_02_usmc : vn_defaults_tiny {};
	class vn_b_air_ah1g_03_usmc : vn_defaults_tiny {};
	class vn_b_air_ah1g_04_usmc : vn_defaults_tiny {};
	class vn_b_air_ah1g_05_usmc : vn_defaults_tiny {};
	class vn_b_air_ah1g_06_usmc : vn_defaults_tiny {};
	class vn_b_air_ah1g_07_usmc : vn_defaults_tiny {};
	class vn_b_air_ah1g_08_usmc : vn_defaults_tiny {};
	class vn_b_air_ah1g_09_usmc : vn_defaults_tiny {};
	class vn_b_air_ah1g_10_usmc : vn_defaults_tiny {};

	//UH1D - Dustoff
	class vn_b_air_uh1d_01_01 : vn_defaults_small {};
	class vn_b_air_uh1d_01_02 : vn_defaults_small {};
	class vn_b_air_uh1d_01_03 : vn_defaults_small {};
	class vn_b_air_uh1d_01_04 : vn_defaults_small {};
	class vn_b_air_uh1d_01_05 : vn_defaults_small {};
	class vn_b_air_uh1d_01_06 : vn_defaults_small {};
	class vn_b_air_uh1d_01_07 : vn_defaults_small {};

	//UH1D - Slick
	class vn_b_air_uh1d_02_01 : vn_defaults_small {};
	class vn_b_air_uh1d_02_02 : vn_defaults_small {};
	class vn_b_air_uh1d_02_03 : vn_defaults_small {};
	class vn_b_air_uh1d_02_04 : vn_defaults_small {};
	class vn_b_air_uh1d_02_05 : vn_defaults_small {};
	class vn_b_air_uh1d_02_06 : vn_defaults_small {};
	class vn_b_air_uh1d_02_07 : vn_defaults_small {};

	//UH1C - Hog
	class vn_b_air_uh1c_01_01 : vn_defaults_tiny {};
	class vn_b_air_uh1c_01_02 : vn_defaults_tiny {};
	class vn_b_air_uh1c_01_03 : vn_defaults_tiny {};
	class vn_b_air_uh1c_01_04 : vn_defaults_tiny {};
	class vn_b_air_uh1c_01_05 : vn_defaults_tiny {};
	class vn_b_air_uh1c_01_06 : vn_defaults_tiny {};
	class vn_b_air_uh1c_01_07 : vn_defaults_tiny {};

	//UH1C - Gunship
	class vn_b_air_uh1c_02_01 : vn_defaults_tiny {};
	class vn_b_air_uh1c_02_02 : vn_defaults_tiny {};
	class vn_b_air_uh1c_02_03 : vn_defaults_tiny {};
	class vn_b_air_uh1c_02_04 : vn_defaults_tiny {};
	class vn_b_air_uh1c_02_05 : vn_defaults_tiny {};
	class vn_b_air_uh1c_02_06 : vn_defaults_tiny {};
	class vn_b_air_uh1c_02_07 : vn_defaults_tiny {};

	//UH1C - Hornet
	class vn_b_air_uh1c_03_01 : vn_defaults_tiny {};
	class vn_b_air_uh1c_03_02 : vn_defaults_tiny {};
	class vn_b_air_uh1c_03_03 : vn_defaults_tiny {};
	class vn_b_air_uh1c_03_04 : vn_defaults_tiny {};
	class vn_b_air_uh1c_03_05 : vn_defaults_tiny {};
	class vn_b_air_uh1c_03_06 : vn_defaults_tiny {};
	class vn_b_air_uh1c_03_07 : vn_defaults_tiny {};

	//UH1C - Frog
	class vn_b_air_uh1c_04_01 : vn_defaults_tiny {};
	class vn_b_air_uh1c_04_02 : vn_defaults_tiny {};
	class vn_b_air_uh1c_04_03 : vn_defaults_tiny {};
	class vn_b_air_uh1c_04_04 : vn_defaults_tiny {};
	class vn_b_air_uh1c_04_05 : vn_defaults_tiny {};
	class vn_b_air_uh1c_04_06 : vn_defaults_tiny {};
	class vn_b_air_uh1c_04_07 : vn_defaults_tiny {};

	//UH1C - Heavy Hog
	class vn_b_air_uh1c_05_01 : vn_defaults_tiny {};
	class vn_b_air_uh1c_05_02 : vn_defaults_tiny {};
	class vn_b_air_uh1c_05_03 : vn_defaults_tiny {};
	class vn_b_air_uh1c_05_04 : vn_defaults_tiny {};
	class vn_b_air_uh1c_05_05 : vn_defaults_tiny {};
	class vn_b_air_uh1c_05_06 : vn_defaults_tiny {};
	class vn_b_air_uh1c_05_07 : vn_defaults_tiny {};

	//UH1C - ARA
	class vn_b_air_uh1c_06_01 : vn_defaults_tiny {};
	class vn_b_air_uh1c_06_02 : vn_defaults_tiny {};

	//UH1B - Slick
	class vn_b_air_uh1c_07_01 : vn_defaults_small {};

	//UH1B - Dustoff 
	class vn_b_air_uh1b_01_01 : vn_defaults_small {};

	//UH1E - Slick
	class vn_b_air_uh1e_03_04 : vn_defaults_small {};

	//UH1E - Gunship
	class vn_b_air_uh1e_01_04 : vn_defaults_tiny {};

	//Choctaw - Transport
	class vn_b_air_ch34_01_01 : vn_defaults_small {};
	class vn_b_air_ch34_03_01 : vn_defaults_small {};
	class vn_i_air_ch34_01_02 : vn_defaults_small {};
	class vn_i_air_ch34_02_02 : vn_defaults_small {};
	//Choctaw - Armed (Stinger variants)
	class vn_b_air_ch34_04_01 : vn_defaults_tiny {};
	class vn_b_air_ch34_04_02 : vn_defaults_tiny {};
	class vn_b_air_ch34_04_03 : vn_defaults_tiny {};
	class vn_b_air_ch34_04_04 : vn_defaults_tiny {};

	//OH6
	class vn_b_air_oh6a_01 : vn_defaults_tiny {};
	class vn_b_air_oh6a_02 : vn_defaults_tiny {};
	class vn_b_air_oh6a_03 : vn_defaults_tiny {};
	class vn_b_air_oh6a_04 : vn_defaults_tiny {};
	class vn_b_air_oh6a_05 : vn_defaults_tiny {};
	class vn_b_air_oh6a_06 : vn_defaults_tiny {};
	class vn_b_air_oh6a_07 : vn_defaults_tiny {};

	//UH-1D Bushranger
	class vn_b_air_uh1d_03_06 : vn_defaults_tiny {};

	//UH1E - Heavy Gunship
	class vn_b_air_uh1e_02_04 : vn_defaults_tiny {};

	//UH1F - Slick
	class vn_b_air_uh1f_01_03 : vn_defaults_small {};

	//Jets
	// 	Jets don't get any storage.

	// CH-47 Chinook
	class vn_b_air_ch47_01_01: vn_defaults_large {};
	class vn_b_air_ch47_02_01: vn_defaults_large {};
	class vn_b_air_ch47_03_01: vn_defaults_large {};
	class vn_b_air_ch47_04_01: vn_defaults_large {};
	class vn_b_air_ch47_01_02: vn_defaults_large {};
	class vn_b_air_ch47_02_02: vn_defaults_large {};
	class vn_b_air_ch47_03_02: vn_defaults_large {};
	class vn_b_air_ch47_04_02: vn_defaults_large {};
	class vn_b_air_ach47_01_01: vn_defaults_medium {};
	class vn_b_air_ach47_02_01: vn_defaults_medium {};
	class vn_b_air_ach47_03_01: vn_defaults_medium {};
	class vn_b_air_ach47_04_01: vn_defaults_medium {};
	class vn_b_air_ach47_05_01: vn_defaults_medium {};
	class vn_i_air_ch47_01_01: vn_defaults_large {};
	class vn_i_air_ch47_02_01: vn_defaults_large {};
	class vn_i_air_ch47_03_01: vn_defaults_large {};
	class vn_i_air_ch47_04_01: vn_defaults_large {};

	// M151
	class vn_b_wheeled_m151_01_usmc: vn_defaults_small {};
	class vn_b_wheeled_m151_02_usmc: vn_defaults_small {};
	class vn_b_wheeled_m151_mg_02_usmc: vn_defaults_tiny {};
	class vn_b_wheeled_m151_mg_03_usmc: vn_defaults_tiny {};
	class vn_b_wheeled_m151_mg_04_usmc: vn_defaults_tiny {};

	// LR2a
	class vn_b_wheeled_lr2a_01_aus_army: vn_defaults_small {};
	class vn_b_wheeled_lr2a_01_nz_army: vn_defaults_small {};
	class vn_b_wheeled_lr2a_02_aus_army: vn_defaults_small {};
	class vn_b_wheeled_lr2a_02_nz_army: vn_defaults_small {};
	class vn_b_wheeled_lr2a_03_aus_army: vn_defaults_small {};
	class vn_b_wheeled_lr2a_03_nz_army: vn_defaults_small {};
	class vn_b_wheeled_lr2a_mg_01_aus_army: vn_defaults_tiny {};
	class vn_b_wheeled_lr2a_mg_01_nz_army: vn_defaults_tiny {};
	class vn_b_wheeled_lr2a_mg_02_aus_army: vn_defaults_tiny {};
	class vn_b_wheeled_lr2a_mg_02_nz_army: vn_defaults_tiny {};
	class vn_b_wheeled_lr2a_mg_03_aus_army: vn_defaults_tiny {};
	class vn_b_wheeled_lr2a_mg_03_nz_army: vn_defaults_tiny {};
	class vn_i_wheeled_lr2a_mg_01_fank_71: vn_defaults_tiny {};

	// M274 Mule
	class vn_b_wheeled_m274_01_01: vn_defaults_small {};
	class vn_b_wheeled_m274_01_02: vn_defaults_small {};
	class vn_b_wheeled_m274_01_03: vn_defaults_small {};
	class vn_b_wheeled_m274_02_01: vn_defaults_small {};
	class vn_b_wheeled_m274_02_02: vn_defaults_small {};
	class vn_b_wheeled_m274_02_03: vn_defaults_small {};
	class vn_b_wheeled_m274_mg_01_01: vn_defaults_tiny {};
	class vn_b_wheeled_m274_mg_01_02: vn_defaults_tiny {};
	class vn_b_wheeled_m274_mg_02_01: vn_defaults_tiny {};
	class vn_b_wheeled_m274_mg_02_02: vn_defaults_tiny {};
	class vn_b_wheeled_m274_mg_03_01: vn_defaults_tiny {};
	class vn_b_wheeled_m274_mg_03_02: vn_defaults_tiny {};

	// M113A1
	class vn_b_armor_m125_01: vn_defaults_small {};
	class vn_b_armor_m132_01: vn_defaults_small {};
	class vn_b_armor_m577_01: vn_defaults_medium {};
	class vn_b_armor_m577_02: vn_defaults_medium {};

	//////////////////
	////  UNSUNG  ////
	//////////////////
	class uns_willys : vn_defaults_small {};
	class uns_willys_2 : vn_defaults_small {};
	class uns_willysmg50 : vn_defaults_tiny {};
	class uns_willysm40 : vn_defaults_tiny {};
	class uns_willysmg : vn_defaults_tiny {};
	class uns_willys_2_usmp : vn_defaults_small {};
	class uns_willys_2_usmc : vn_defaults_small {};
	class uns_willys_2_m60 : vn_defaults_small {};
	class uns_willys_2_m1919 : vn_defaults_tiny {};

	//Armoured Cars
	class uns_xm706e1 : vn_defaults_small {};
	class uns_xm706e2 : vn_defaults_small {};

	//Huey
	class uns_UH1D_raaf_m60 : vn_defaults_tiny {};
	class uns_UH1C_M21_M200 : vn_defaults_tiny {};

	//Chinook
	class uns_ch47_m60_army : vn_defaults_medium {};

	//Boats
	class uns_pbr : vn_defaults_medium {};
	class uns_pbr_m10 : vn_defaults_small {};
	class uns_pbr_mk18 : vn_defaults_small {};

	//Trucks
	class uns_m37b1 : vn_defaults_medium {};
	class uns_m37b1_m1919 : vn_defaults_small {};
	class uns_M35A2 : vn_defaults_large {};
	class uns_M35A2_Open : vn_defaults_large {};
    };
    class item_data
    {
		//Building supplies crate
        class vn_b_ammobox_supply_05
        {
            item_weight = 200;
            item_size = 2.5;
            spawn_distance = 5;
            rotation_offset = 0;
        };

		//Building supplies container
		class Land_Cargo10_brick_red_F
		{
			item_weight = 600;
			item_size = 10;
			spawn_distance = 9;
			rotation_offset = 0;
		};

		//Small komex containers
		class vn_us_komex_small_01 : Land_Cargo10_brick_red_F {};
		class vn_us_komex_small_02 : Land_Cargo10_brick_red_F {};
		class vn_us_komex_small_03 : Land_Cargo10_brick_red_F {};

		//Workshop supplies
		class vn_b_ammobox_supply_06 : vn_b_ammobox_supply_05 {};

		//Sandbag supplies
		class vn_b_ammobox_supply_10 : vn_b_ammobox_supply_05 {};

		//Small US ammo
		class vn_b_ammobox_supply_04
		{
			item_weight = 50;
			item_size = 1;
			spawn_distance = 2;
			rotation_offset = 0;
		};

		//SOG ammo
		class vn_b_ammobox_sog // ammo
        {
            item_weight = 100;
            item_size = 2.5;
            spawn_distance = 3;
            rotation_offset = 0;
        };
		//US Ammo
		class vn_b_ammobox_supply_01 : vn_b_ammobox_sog {};
		//Medical supplies
		class vn_b_ammobox_supply_03 : vn_b_ammobox_sog {};
		//Food supplies
		class vn_b_ammobox_supply_02 : vn_b_ammobox_supply_03 {};

		//Resupply Fuel/Repair/Ammo
		class vn_b_ammobox_supply_07 : vn_b_ammobox_supply_05
		{
				item_weight = 400;
				item_size = 10;
		};
		class vn_b_ammobox_supply_08 : vn_b_ammobox_supply_07 {};

		class vn_b_ammobox_supply_09 : vn_b_ammobox_supply_07 {};

		/* Huron cargo container used to package wrecked vehicles */
		class B_Slingload_01_Cargo_F
		{
			item_weight = 600;
			item_size = 7.5;
			spawn_distance = 8;
			rotiation_offset = 0;
		};

		//Medium komex containers
		class vn_us_komex_medium_01 : B_Slingload_01_Cargo_F {};
		class vn_us_komex_medium_02 : vn_us_komex_medium_01 {};
		class vn_us_komex_medium_03 : vn_us_komex_medium_01 {};

		///////////////////
		////  STATICS  ////
		///////////////////
		class vn_static_tiny
		{
			item_weight = 50;
			item_size = 1;
			spawn_distance = 2;
			rotation_offset = 0;
		};

		class vn_static_small
		{
			item_weight = 100;
			item_size = 2.5;
			spawn_distance = 3;
			rotation_offset = 0;
		};

		class vn_static_medium
		{
			item_weight = 200;
			item_size = 2.5;
			spawn_distance = 4;
			rotation_offset = 0;
		};

		class vn_static_large
		{
			item_weight = 600;
			item_size = 7.5;
			spawn_distance = 4;
			rotation_offset = 0;
		};

		class vn_b_army_static_mortar_m2 : vn_static_tiny {};
		class vn_b_army_static_mortar_m29 : vn_static_tiny {};
		class vn_b_sf_static_mortar_m2 : vn_static_tiny {};
		class vn_b_sf_static_mortar_m29 : vn_static_tiny {};
		class vn_b_army_static_m1919a6 : vn_static_tiny {};
		class vn_b_sf_static_m1919a6 : vn_static_tiny {};
		class vn_b_army_static_m1919a4_low : vn_static_tiny {};
		class vn_b_army_static_m1919a4_high : vn_static_tiny {};
		class vn_b_sf_static_m1919a4_low : vn_static_tiny {};
		class vn_b_sf_static_m1919a4_high : vn_static_tiny {};
		class vn_b_army_static_m2_low : vn_static_tiny {};
		class vn_b_sf_static_m2_low : vn_static_tiny {};
		class vn_b_army_static_m2_high : vn_static_tiny {};
		class vn_b_sf_static_m2_high : vn_static_tiny {};
		class vn_b_army_static_m60_low : vn_static_tiny {};
		class vn_b_sf_static_m60_low : vn_static_tiny {};
		class vn_b_army_static_m60_high : vn_static_tiny {};
		class vn_b_sf_static_m60_high : vn_static_tiny {};
		class vn_b_sf_static_m40a1rr : vn_static_small {};
		class vn_b_army_static_tow : vn_static_small {};
		class vn_b_sf_static_tow : vn_static_small {};
		class vn_b_army_static_m40a1rr : vn_static_medium {};
		class vn_b_army_static_mk18 : vn_static_small {};
		//TODO - Bump these to large when slingloading is added to M45s
		class vn_b_army_static_m45 : vn_static_small {};
		class vn_b_sf_static_m45 : vn_static_small {};
		class vn_b_army_static_m101_01 : vn_static_large {};
		class vn_b_army_static_m101_02 : vn_static_large {};
		class vn_b_sf_static_m101_01 : vn_static_large {};
		class vn_b_sf_static_m101_02 : vn_static_large {}
		class vn_i_static_m101_01 : vn_static_large {};
		class vn_i_static_m101_02 : vn_static_large {};
		class vn_i_marines_static_m101_01 : vn_static_large {};
		class vn_i_marines_static_m101_02 : vn_static_large {};
		class vn_b_navy_static_l60mk3 : vn_static_large {};
		class vn_b_navy_static_l70mk2 : vn_static_large {};

		class vn_i_static_mortar_m2: 	vn_b_army_static_mortar_m2 {};
		class vn_i_static_mortar_m29: 	vn_b_army_static_mortar_m29 {};
		class vn_i_static_m1919a6: 	vn_b_army_static_m1919a6 {};
		class vn_i_static_m1919a4_low: 	vn_b_army_static_m1919a4_low {};
		class vn_i_static_m1919a4_high:	vn_b_army_static_m1919a4_high {};
		class vn_i_static_m2_low: 	vn_b_army_static_m2_low {};
		class vn_i_static_m2_high: 	vn_b_army_static_m2_high {};
		class vn_i_static_m60_low: 	vn_b_army_static_m60_low {};
		class vn_i_static_m60_high: 	vn_b_army_static_m60_high {};
		class vn_i_army_static_m45: 	vn_b_army_static_m45 {};

		class vn_o_nva_static_rpd_high: 	vn_b_army_static_m60_high {};
		class vn_o_nva_static_dshkm_high_01:	vn_b_army_static_m2_high {};
		class vn_o_nva_static_dshkm_high_02: 	vn_b_army_static_m2_high {};
		class vn_o_nva_static_dshkm_low_01:	vn_b_army_static_m2_low {};
		class vn_o_nva_static_dshkm_low_02:	vn_b_army_static_m2_low {};
		class vn_o_nva_static_mortar_type53: 	vn_b_army_static_mortar_m29 {};
		class vn_o_nva_static_mortar_type63: 	vn_b_army_static_mortar_m2 {};

		class vn_o_nva_navy_static_rpd_high: 		vn_b_army_static_m60_high {};
		class vn_o_nva_navy_static_dshkm_high_01:	vn_b_army_static_m2_high {};
		class vn_o_nva_navy_static_dshkm_high_02: 	vn_b_army_static_m2_high {};
		class vn_o_nva_navy_static_dshkm_low_01:	vn_b_army_static_m2_low {};
		class vn_o_nva_navy_static_dshkm_low_02:	vn_b_army_static_m2_low {};
		class vn_o_nva_navy_static_mortar_type53: 	vn_b_army_static_mortar_m29 {};
		class vn_o_nva_navy_static_mortar_type63: 	vn_b_army_static_mortar_m2 {};

		class vn_o_vc_static_rpd_high: 		vn_b_army_static_m60_high {};
		class vn_o_vc_static_dp28_high: 	vn_b_army_static_m60_high {};
		class vn_o_vc_static_dshkm_high_01:	vn_b_army_static_m2_high {};
		class vn_o_vc_static_dshkm_high_02: 	vn_b_army_static_m2_high {};
		class vn_o_vc_static_dshkm_low_01:	vn_b_army_static_m2_low {};
		class vn_o_vc_static_dshkm_low_02:	vn_b_army_static_m2_low {};
		class vn_o_vc_static_mortar_type53: 	vn_b_army_static_mortar_m29 {};
		class vn_o_vc_static_mortar_type63: 	vn_b_army_static_mortar_m2 {};

		//--------------
		// 1.3 content
		//--------------

		// ZGU-1
		class vn_o_nva_static_zgu1_01: vn_static_small {};
		class vn_o_nva_65_static_zgu1_01: vn_static_small {};
		class vn_o_nva_navy_static_zgu1_01: vn_static_small {};
		class vn_o_vc_static_zgu1_01: vn_static_small {};
		class vn_o_pl_static_zgu1_01: vn_static_small {};

		//M1910
		class vn_o_nva_static_m1910_low_01: vn_static_small {};
		class vn_o_nva_static_m1910_low_02: vn_static_small {};
		class vn_o_nva_static_m1910_high_01: vn_static_small {};
		class vn_o_nva_65_static_m1910_low_01: vn_static_small {};
		class vn_o_nva_65_static_m1910_low_02: vn_static_small {};
		class vn_o_nva_65_static_m1910_high_01: vn_static_small {};
		class vn_o_nva_navy_static_m1910_low_01: vn_static_small {};
		class vn_o_nva_navy_static_m1910_low_02: vn_static_small {};
		class vn_o_nva_navy_static_m1910_high_01: vn_static_small {};
		class vn_o_vc_static_m1910_low_01: vn_static_small {};
		class vn_o_vc_static_m1910_low_02: vn_static_small {};
		class vn_o_vc_static_m1910_high_01: vn_static_small {};

		//M2
		class vn_b_army_static_m2_scoped_high: vn_static_small {};
		class vn_b_army_static_m2_scoped_low: vn_static_small {};
		class vn_b_sf_static_m2_scoped_high: vn_static_small {};
		class vn_b_sf_static_m2_scoped_low: vn_static_small {};

		//USMC
		class vn_b_usmc_static_m2_low: vn_static_small {};
		class vn_b_usmc_static_m2_high: vn_static_small {};
		class vn_b_usmc_static_m2_scoped_high: vn_static_small {};
		class vn_b_usmc_static_m2_scoped_low: vn_static_small {};
		class vn_b_usmc_static_m60_low: vn_static_small {};
		class vn_b_usmc_static_m60_high: vn_static_small {};
		class vn_b_usmc_static_mortar_m2: vn_static_small {};
		class vn_b_usmc_static_mortar_m29: vn_static_small {};
		class vn_b_usmc_static_m101_01: vn_static_small {};
		class vn_b_usmc_static_m101_02: vn_static_small {};
		class vn_b_usmc_static_m40a1rr: vn_static_small {};

		//FANK
		class vn_i_fank_71_static_m1919a6: vn_static_small {};
		class vn_i_fank_71_static_m1919a4_low: vn_static_small {};
		class vn_i_fank_71_static_m1919a4_high: vn_static_small {};
		class vn_i_fank_71_static_m2_low: vn_static_small {};
		class vn_i_fank_71_static_m2_high: vn_static_small {};
		class vn_i_fank_71_static_m45: vn_static_small {};
		class vn_i_fank_71_static_m60_low: vn_static_small {};
		class vn_i_fank_71_static_m60_high: vn_static_small {};
		class vn_i_fank_71_static_mortar_m2: vn_static_small {};
		class vn_i_fank_71_static_mortar_m29: vn_static_small {};
		class vn_i_fank_71_static_m40a1rr: vn_static_small {};
		class vn_i_fank_71_static_l70mk2: vn_static_small {};

		class vn_i_fank_70_static_dp28_high: vn_static_small {};
		class vn_i_fank_70_static_rpd_high: vn_static_small {};
		class vn_i_fank_70_static_dshkm_high_01: vn_static_small {};
		class vn_i_fank_70_static_dshkm_high_02: vn_static_small {};
		class vn_i_fank_70_static_dshkm_low_01: vn_static_small {};
		class vn_i_fank_70_static_dshkm_low_02: vn_static_small {};
		class vn_i_fank_70_static_sgm_low_01: vn_static_small {};
		class vn_i_fank_70_static_sgm_low_02: vn_static_small {};
		class vn_i_fank_70_static_sgm_high_01: vn_static_small {};
		class vn_i_fank_70_static_mortar_type53: vn_static_small {};
		class vn_i_fank_70_static_mortar_type63: vn_static_small {};
		class vn_i_fank_70_static_type56rr: vn_static_small {};
		class vn_i_fank_70_static_zgu1_01: vn_static_small {};
		class vn_i_fank_70_static_l60mk3: vn_static_small {};

		//KR
		class vn_o_kr_static_rpd_high: vn_static_small {};
		class vn_o_kr_static_dp28_high: vn_static_small {};
		class vn_o_kr_static_dshkm_high_01: vn_static_small {};
		class vn_o_kr_static_dshkm_high_02: vn_static_small {};
		class vn_o_kr_static_dshkm_low_01: vn_static_small {};
		class vn_o_kr_static_dshkm_low_02: vn_static_small {};
		class vn_o_kr_static_mortar_type53: vn_static_small {};
		class vn_o_kr_static_mortar_type63: vn_static_small {};
		class vn_o_kr_static_type56rr: vn_static_small {};
		class vn_o_kr_static_sgm_low_01: vn_static_small {};
		class vn_o_kr_static_sgm_low_02: vn_static_small {};
		class vn_o_kr_static_sgm_high_01: vn_static_small {};
		class vn_o_kr_static_h12: vn_static_small {};
		class vn_o_kr_static_zgu1_01: vn_static_small {};
		class vn_o_kr_static_m1910_low_01: vn_static_small {};
		class vn_o_kr_static_m1910_low_02: vn_static_small {};
		class vn_o_kr_static_m1910_high_01: vn_static_small {};
    };
};
