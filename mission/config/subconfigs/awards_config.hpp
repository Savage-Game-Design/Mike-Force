// NOTES: awards array format: [["purple_heart",-1],["distinguished_service_cross",0],...]
// 	  -1 = greyed out version of level 0 image.

class purple_heart
{
	title = "STR_vn_mf_purple_heart";
	desc = "KIA while serving in ACAV / Green Hornets";

	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_01_01.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_01_01.paa"} // 0
	};
};
class rvn_wound_medal
{
	title = "STR_vn_mf_rvn_wound_medal";
	desc = "KIA while operating in Mike Force / Spike team";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_01_02.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_01_02.paa"} // 0
	};
};
class distinguished_service_cross
{
	title = "STR_vn_mf_distinguished_service_cross";
	desc = "KIA while carrying or dragging a wounded comrade. Award levels for repeated actions.";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_03_01_c1.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_03_01_c1.paa"}, // 0
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_03_01_c2.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_03_01_c2.paa"}, // 1 Bronze Oak Leaf Cluster
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_03_01_c3.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_03_01_c3.paa"}  // 2 Silver Oak Leaf Cluster
	};
};
// TODO finish below and match up check if missing icons
class vietnam_gallantry_cross
{
	title = "STR_vn_mf_vietnam_gallantry_cross";
	desc = "Conducted 20 revives per level of award";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_02_01_c1.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_02_01_c1.paa"},
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_02_01_c2.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_02_01_c2.paa"}, // "Bronze Palm",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_02_01_c3.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_02_01_c3.paa"}, //"Bronze Star",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_02_01_c4.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_02_01_c4.paa"}, //"Silver Star",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_02_01_c5.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_02_01_c5.paa"}, //"Gold Star",
	};
};
class rvn_defense_medal
{
	title = "STR_vn_mf_rvn_defense_medal";
	desc = "Entered an active zone";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_12_01.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_12_01.paa"}
	};
};
class combat_infantryman_badge
{
	title = "STR_vn_mf_combat_infantryman_badge";
	desc = "1 enemy kill";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_04_01.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_04_01.paa"}
	};
};
class bronze_star
{
	title = "STR_vn_mf_bronze_star";
	desc = "150 enemy kills";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_01_01.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_01_01.paa"}
	};
};
class silver_star
{
	title = "STR_vn_mf_silver_star";
	desc = "300 enemy kills";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_01_02.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_01_02.paa"}
	};
};
class air_medal
{
	title = "STR_vn_mf_air_medal";
	desc = "300 enemy kills in the service of Green Hornets";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_01_04.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_01_04.paa"}
	};
};
class distinguished_service_order
{
	title = "STR_vn_mf_distinguished_service_order";
	desc = "500 enemy kills";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_04_01.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_04_01.paa"}
	};
};
class congressional_medalofhonor
{
	// 500 kills +
	title = "STR_vn_mf_congressional_medalofhonor";
	desc = "Entered an active zone";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_01_03.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_01_03.paa"}
	};
};
class air_cross_of_gallantry
{
	title = "STR_vn_mf_air_cross_of_gallantry";
	desc = "10 air to air kills";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_04_02_c1.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_04_02_c1.paa"},
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_04_02_c2.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_04_02_c2.paa"},// "Silver Wing",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_04_02_c3.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_04_02_c3.paa"} // "Gold Wing"
	};
};

class vietnam_tet_campaign_commemorative_medal
{
	title = "STR_vn_mf_vietnam_tet_campaign_commemorative_medal";
	desc = "1 Primary objective completed";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_03_01.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_03_01.paa"}
	};
};
class rvn_special_service_medal
{
	title = "STR_vn_mf_rvn_special_service_medal";
	desc = "10 Primary objective completed";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_03_02.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_03_02.paa"}
	};
};
class national_defense_service_medal
{
	title = "STR_vn_mf_national_defense_service_medal";
	desc = "30 Primary objective completed";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_03_03.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_03_03.paa"}
	};
};

class distinguished_flying_cross
{
	title = "STR_vn_mf_distinguished_flying_cross";
	desc = "Completion of 5 GH team tasks generates each level of award";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_02_01_c1.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_02_01_c1.paa"},
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_02_01_c2.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_02_01_c2.paa"}, //"1x Bronze Oak Leaf Cluster",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_02_01_c3.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_02_01_c3.paa"}, //"2x Bronze Oak Leaf Cluster",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_02_01_c4.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_02_01_c4.paa"}, //"3x Bronze Oak Leaf Cluster",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_02_01_c5.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_02_01_c5.paa"}, //"Silver Oak Leaf Cluster"
	};
};
class army_commendation_medal
{
	title = "STR_vn_mf_army_commendation_medal";
	desc = "Completion of 20 (secondary) Team tasks";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_07_01.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_07_01.paa"}
	};
};
class air_force_good_conduct_medal
{
	title = "STR_vn_mf_air_force_good_conduct_medal";
	desc = "Completion of 20 (secondary) Team tasks";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_07_02.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_07_02.paa"}
	};
};
class air_force_cross
{
	title = "STR_vn_mf_air_force_cross";
	desc = "Completion of 10 Team tasks at specified rank";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_08_01_c1.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_08_01_c1.paa"},
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_08_01_c2.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_08_01_c2.paa"}, 	// Bronze Oak Leaf Cluster
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_08_01_c3.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_08_01_c3.paa"} 	// Silver OLC
	};
};
class special_operations_medal
{
	title = "STR_vn_mf_special_operations_medal";
	desc = "Completion of 1 Team Task";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_07_03.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_07_03.paa"}
	};
};
class army_presidential_unit_citation
{
	title = "STR_vn_mf_army_presidential_unit_citation";
	desc = "Completion of 30 Spike Team tasks";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_02_03.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_02_03.paa"}
	};
};
class usaf_outstanding_unit_award
{
	title = "STR_vn_mf_usaf_outstanding_unit_award";
	desc = "Completion of 30 GH Team tasks";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_02_04.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_02_04.paa"}
	};
};
class meritorious_unit_citation
{
	title = "STR_vn_mf_meritorious_unit_citation";
	desc = "Completion of 30 Team tasks";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_02_05.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_02_05.paa"}
	};
};
class meritorious_service_medal
{
	title = "STR_vn_mf_meritorious_service_medal";
	desc = "Entered an active zone";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_02_02.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_02_02.paa"}
	};
};
class joint_service_commendation_medal
{
	title = "STR_vn_mf_joint_service_commendation_medal";
	desc = "Completion of 5 support tasks";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_05_01.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_05_01.paa"}
	};
};
class legion_of_merit
{
	title = "STR_vn_mf_legion_of_merit";
	desc = "Completion of 25 support tasks";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_06_01.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_06_01.paa"}
	};
};
class vietnam_service_medal
{
	title = "STR_vn_mf_vietnam_service_medal";
	desc = "A new bronze star for being present when each zone is completed";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_05_01_c1.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_05_01_c1.paa"}, //
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_05_01_c2.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_05_01_c2.paa"}, // "Metal2",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_05_01_c3.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_05_01_c3.paa"}, // "Metal3",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_05_01_c4.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_05_01_c4.paa"}, // "Metal4",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_05_01_c5.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_05_01_c5.paa"}, // "Metal5",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_05_01_c6.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_05_01_c6.paa"}, // "Metal6",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_05_01_c7.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_05_01_c7.paa"}, // "Metal7",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_05_01_c8.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_05_01_c8.paa"}, // "Metal8",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_05_01_c9.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_05_01_c9.paa"}, // "Metal9",
		{"\vn\ui_f_vietnam\data\medals\vn_medal_m_05_01_c10.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_m_05_01_c10.paa"}, // "Metal10"
	};
};
class republic_of_vietnam_campaign_medal
{
	title = "STR_vn_mf_republic_of_vietnam_campaign_medal";
	desc = "present when 5 zones were completed";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_14_01.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_14_01.paa"}
	};
};
class gulf_of_tonkin_vietnam_commemorative_medal
{
	title = "STR_vn_mf_gulf_of_tonkin_vietnam_commemorative_medal";
	desc = "Destruction of 5 enemy boats";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_17_01.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_17_01.paa"}
	};
};
class navy_cross
{
	title = "STR_vn_mf_navy_cross";
	desc = "Destruction of 10 enemy boats";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_18_01_c1.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_18_01_c1.paa"},
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_18_01_c2.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_18_01_c2.paa"}, 	// Silver Star
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_18_01_c3.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_18_01_c3.paa"} 	// Silver OLC
	};
};
class rvn_training_service_medal
{
	title = "STR_vn_mf_rvn_training_service_medal";
	desc = "Achieving LT rank in Mike Force/ Spike Team";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_19_01.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_19_01.paa"}
	};
};
class rvn_technical_service_medal
{
	title = "STR_vn_mf_rvn_technical_service_medal";
	desc = "Achieving LT rank in ACAV Team";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_18_02.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_18_02.paa"}
	};
};
class rvn_military_merit_first_republic_medal
{
	title = "STR_vn_mf_rvn_military_merit_first_republic_medal";
	desc = "Completed destruction of VC HQ task";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_16_01.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_16_01.paa"}
	};
};
class rvn_civil_action_unit_citation
{
	title = "STR_vn_mf_rvn_civil_action_unit_citation";
	desc = "Completed defend the meeting/ checkpoint";
	levels[] =
	{
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_15_01_c1.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_15_01_c1.paa"},
		{"\vn\ui_f_vietnam\data\medals\vn_medal_a_15_01_c2.paa", "\vn\ui_f_vietnam\data\medals\vn_ribbon_a_15_01_c2.paa"},
	};
};
