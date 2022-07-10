#define CONDITION_HAS_RANK { $STR_vn_mf_buildingMenu_condition_hasRank, "player getVariable ['vn_mf_db_rank',0] >= getNumber(_config >> 'rank')"}
#define CONDITION_IS_ENGINEER { $STR_vn_mf_buildingMenu_condition_isEngineer, "player getUnitTrait 'engineer'"}
#define CONDITION_IS_ON_FOOT { $STR_vn_mf_buildingMenu_condition_rnFoot, "isNull objectParent player"}
#define CONDITION_NOT_IN_RESTRICTED_ZONE {  $STR_vn_mf_buildingMenu_condition_inRestrictedZone, "vn_mf_markers_blocked_areas findIf {_pos inArea _x} isEqualTo -1"}
#define CONDITION_IS_ACAV { $STR_vn_mf_buildingMenu_condition_inACav, "player getVariable ['vn_mf_db_player_group', 'MikeForce'] isEqualTo 'ACAV'"}

//Takes "Capacity" in supply units, and "Lifetime" in seconds.
#define DAYS_TO_SECONDS(days) (days * 86400)
#define HOURS_TO_SECONDS(hours) (hours * 3600)
#define MINUTES_TO_SECONDS(minutes) (minutes * 60)
#define SUPPLY_CAPACITY(capacity, lifetime) \
	supply_capacity = capacity; \
	supply_consumption = __EVAL(capacity / lifetime)

class vn_b_wheeled_m54_mg_01
{
	name = "";
	type = "wheeled";
	categories[] = {"armed", "us", "acav"};
	rank = 0;
	SUPPLY_CAPACITY(500, DAYS_TO_SECONDS(1));

	// resupply = "BuildingSupplies";
	conditions[] = {
		CONDITION_HAS_RANK,
		CONDITION_IS_ENGINEER,
		CONDITION_IS_ON_FOOT,
		CONDITION_NOT_IN_RESTRICTED_ZONE,
		CONDITION_IS_ACAV
	};

	class features
	{
		class respawn {};
	};
};
