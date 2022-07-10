/*
	class CLASSNAME
	{
		name = "";
		icon = "";
		description = "";
		variables[] = {}; // String array of code
	};
*/

class Settings
{
	distance = 6;
	liveText = 1;
	defaultKey = 7;
};

class DutyOfficer
{
	name = $STR_vn_mf_overlay_duty_officer_name;
	icon = "";
	description = $STR_vn_mf_overlay_duty_officer_description;
	variables[] = {};
};

class FastTravel
{
	name = $STR_vn_mf_overlay_fast_travel_name;
	icon = "";
	description = $STR_vn_mf_overlay_fast_travel_description;
	variables[] = {};
};

class SupplyOfficer
{
	name = $STR_vn_mf_overlay_supply_officer_name;
	icon = "";
	description = $STR_vn_mf_overlay_supply_officer_description;
	variables[] = {};
};

class Land_vn_b_prop_mapstand_01
{
	name = "Map on a piece of wood";
	icon = "";
	description = "Health: <t color='#FF0000'>%2%1</t><br/>Distance: %3m";
	variables[] = { "'%'", "round (100 - (damage _object) * 100)", "round (_object distance player)" };
};