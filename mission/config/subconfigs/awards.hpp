class deaths
{
	class purple_heart
	{
		// KIA while serving in ACAV / Green Hornets

		required_teams[] = {"ACAV","GreenHornets"};
		levels[] =
		{
			{1}
		};
		// requires 1 death while a member of  ACAV / Green Hornets
	};
	class rvn_wound_medal
	{
		// KIA while operating in Mike Force / Spike team

		required_teams[] = {"MikeForce","SpikeTeam"};
		levels[] =
		{
			{1}
		};
		// requires 1 death while a member of  Mike Force / Spike team
	};

	class distinguished_service_cross
	{
		// KIA while carrying or dragging a wounded comrade. Award levels for repeated actions.

		required_code = "_player getVariable ['vn_revive_dragging',false]";
		levels[] =
		{
			{1},
			{2}, // Bronze Oak Leaf Cluster //
			{3}  // Silver Oak Leaf Cluster //
		};
	};

};

class revives
{
	class vietnam_gallantry_cross
	{
		// Conducted 20 revives per level of award

		levels[] =
		{
			{20},
			{40}, // "Bronze Palm"
			{60}, //"Bronze Star"
			{80}, //"Silver Star"
			{100}, //"Gold Star"
		};
	};

};

class zonesentered
{
	class rvn_defense_medal
	{
		// Entered an active zone

		levels[] =
		{
			{1}  //
		};
	};
};

class kills
{
	class combat_infantryman_badge
	{
		// 1 kill

		levels[] =
		{
			{1}
		};
	};
	class bronze_star
	{
		// 1 kill
		required_teams[] = {"ACAV","MikeForce","SpikeTeam"};

		levels[] =
		{
			{150}
		};
	};
	class silver_star
	{
		// 1 kill
		required_teams[] = {"ACAV","MikeForce","SpikeTeam"};

		levels[] =
		{
			{300}
		};
	};
	class air_medal
	{
		// 300 kills GreenHornets
		required_teams[] = {"GreenHornets"};

		levels[] =
		{
			{300}
		};
	};
	class distinguished_service_order
	{
		// 500 kills

		levels[] =
		{
			{500}
		};
	};
	class congressional_medalofhonor
	{
		// 500 kills

		required_code = "_player getVariable ['vn_mf_db_revives',0] > 100 && _player getVariable ['vn_mf_db_zonescaptured',0] > 5 && _player getVariable ['vn_mf_db_taskscomplete',0] > 100 && _player getVariable ['vn_mf_db_supporttaskscomplete',0] > 50";
		levels[] =
		{
			{500}
		};
	};


};


class atoakills
{
	class air_cross_of_gallantry
	{
		// 10 air to air kills
		required_teams[] = {"GreenHornets"};

		levels[] =
		{
			{10},
			{20},// "Silver Wing"
			{30} // "Gold Wing"
		};
	};
};

class taskscomplete
{
	class vietnam_tet_campaign_commemorative_medal
	{
		// 1 Primary objective completed

		levels[] =
		{
			{1} //
		};
	};
	class rvn_special_service_medal
	{
		// 10 Primary objective completed

		levels[] =
		{
			{10} //
		};
	};
	class national_defense_service_medal
	{
		// 30 Primary objective completed

		levels[] =
		{
			{30}  //
		};
	};
};

class teamtaskscomplete
{
	class distinguished_flying_cross
	{
		// Completion of 5 GH team tasks generates each level of award
		required_teams[] = {"GreenHornets"};

		levels[] =
		{
			{5},
			{10}, //"1x Bronze Oak Leaf Cluster"
			{15}, //"2x Bronze Oak Leaf Cluster"
			{20}, //"3x Bronze Oak Leaf Cluster"
			{25} //"Silver Oak Leaf Cluster"
		};
	};
	class army_commendation_medal
	{
		// Completion of 20 (secondary) Team tasks
		required_teams[] = {"ACAV","SpikeTeam","MikeForce"};

		levels[] =
		{
			{20}
		};
	};
	class air_force_good_conduct_medal
	{
		// Completion of 20 (secondary) Team tasks
		required_teams[] = {"GreenHornets"};

		levels[] =
		{
			{20}
		};
	};
	class air_force_cross
	{
		// Completion of 10 Team tasks at specified rank
		required_teams[] = {"GreenHornets"};

		levels[] =
		{
			{10, "rank _player isEqualTo 'CAPTAIN'"},
			{20, "rank _player isEqualTo 'MAJOR'"},	 	// Bronze Oak Leaf Cluster
			{30, "rank _player isEqualTo 'COLONEL'"} 	// Silver OLC
		};
	};
	class special_operations_medal
	{
		// Completion of 1 Team Task
		required_teams[] = {"MikeForce","SpikeTeam"};

		levels[] =
		{
			{1}
		};
	};
	class army_presidential_unit_citation
	{
		// Completion of 30 Spike Team tasks
		required_teams[] = {"SpikeTeam"};

		levels[] =
		{
			{30}
		};
	};

	class usaf_outstanding_unit_award
	{
		// Completion of 30 GH Team tasks
		required_teams[] = {"GreenHornets"};

		levels[] =
		{
			{30}
		};
	};
	class meritorious_unit_citation
	{
		// Completion of 30 Team tasks
		required_teams[] = {"MikeForce", "ACAV"};

		levels[] =
		{
			{30}
		};
	};
};


class supplytaskscomplete
{
	class meritorious_service_medal
	{
		// 10 air to air kills
		required_teams[] = {"ACAV","GreenHornets"};

		levels[] =
		{
			{10}
		};
	};
};


class supporttaskscomplete
{
	class joint_service_commendation_medal
	{
		// Completion of 5 support tasks

		levels[] =
		{
			{5}
		};
	};
	class legion_of_merit
	{
		// Completion of 25 support tasks

		levels[] =
		{
			{25}
		};
	};
};

class zonescaptured
{
	class vietnam_service_medal
	{
		// A new bronze star for being present when each zone is completed

		levels[] =
		{
			{1}, //  all 10 levels
			{2}, // "Metal2"
			{3}, // "Metal3"
			{4}, // "Metal4"
			{5}, // "Metal5"
			{6}, // "Metal6"
			{7}, // "Metal7"
			{8}, // "Metal8"
			{9}, // "Metal9"
			{10} // "Metal10"
		};
	};
	class republic_of_vietnam_campaign_medal
	{
		// present when 5 zones were completed

		levels[] =
		{
			{5}  //
		};
	};
};

class boatkills
{
	class gulf_of_tonkin_vietnam_commemorative_medal
	{
		// Destruction of 5 enemy boats

		levels[] =
		{
			{5}
		};
	};
	class navy_cross
	{
		// Destruction of 10 enemy boats

		levels[] =
		{
			{10},
			{20, "rank _player isEqualTo 'CAPTAIN'"}, 	// Silver Star
			{30, "rank _player isEqualTo 'MAJOR'"} 		// Silver OLC
		};
	};
};

class rank
{
	class rvn_training_service_medal
	{
		// Achieving LT rank in Mike Force/ Spike Team
		required_teams[] = {"MikeForce","SpikeTeam"};

		required_code = "rank _player isEqualTo 'LIEUTENANT'";
		levels[] =
		{
			{1}
		};
	};
	class rvn_technical_service_medal
	{
		// Achieving LT rank in ACAV Team
		required_teams[] = {"ACAV"};

		required_code = "rank _player isEqualTo 'LIEUTENANT'";
		levels[] =
		{
			{1}
		};
	};

};

class hqdestroyed
{
	class rvn_military_merit_first_republic_medal
	{
		// Completed destruction of VC HQ task

		levels[] =
		{
			{1} //
		};
	};
};

/* TODO
	class rvn_civil_action_unit_citation
	{
		// Completed defend the meeting/ checkpoint

		levels[] =
		{
			{1, "rank _player in ['PRIVATE','CORPORAL','SERGEANT']"},
			{1, "rank _player in ['LIEUTENANT','CAPTAIN','MAJOR','COLONEL']"},
		};
	};
*/
