class construction
{
	name = "STR_vn_mf_building_supplies";
	icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_sup_build_ca.paa";

	class BuildingSuppliesCrate
	{
		name = "STR_vn_mf_building_supplies_crate";
		className = "vn_b_ammobox_supply_05";
		icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_sup_build_ca.paa";
		supplyType = "BuildingSupplies";
		supplyQuantity = 500;
	};

	class BuildingSuppliesContainer
	{
		name = "STR_vn_mf_building_supplies_container";
		className = "vn_us_komex_small_02";
		icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_sup_build_ca.paa";
		supplyType = "BuildingSupplies";
		supplyQuantity = 2000;
	};

	class SandbagSupplies
	{
		name = "STR_vn_mf_sandbag_supplies";
		className = "vn_b_ammobox_supply_10";
		icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_sup_build_ca.paa";
	};
};

class vehicles
{
	name = "STR_vn_mf_vehicle_supplies";
	icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_truck_ca.paa";

	class WorkshopSupplies
	{
		name = "STR_vn_mf_workshop_supplies";
		className = "vn_b_ammobox_supply_06";
		icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_sup_work_ca.paa";
	};
};

class support
{
	name = "STR_vn_mf_support_supplies";
	icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_sup_med_ca.paa";

	class FoodSupplies
	{
		name = "STR_vn_mf_food_supplies";
		className = "vn_b_ammobox_supply_02";
		icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_sup_food_ca.paa";
		//crateName = "FoodCrate";
	};

	class MedicalSupplies
	{
		name = "STR_vn_mf_medical_supplies";
		className = "vn_b_ammobox_supply_03";
		icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_sup_med_ca.paa";
		crateConfig = "MedicalCrate";
	};
};

class ammo
{
	name = "STR_vn_mf_ammo_supplies";
	icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_sup_ammo_ca.paa";

	class LightAmmoSupplies
	{
		name = "STR_vn_mf_light_ammo_supplies";
		className =	"vn_b_ammobox_supply_01";
		icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_sup_ammo_ca.paa";
		crateConfig = "AmmoCrateLight";
	};
	class SupportSupplies
	{
		name = "STR_vn_mf_support_ammo_supplies";
		className =	"vn_b_ammobox_supply_01";
		icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_sup_ammo_ca.paa";
		crateConfig = "AmmoCrateSupport";
	};
	class ExplosivesSupplies
	{
		name = "STR_vn_mf_explosives_supplies";
		className =	"vn_b_ammobox_supply_01";
		icon = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_sup_ammo_ca.paa";
		crateConfig = "AmmoCrateExplosives";
	};
};
