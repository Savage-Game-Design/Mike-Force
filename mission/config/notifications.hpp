class CfgNotifications
{
	#include "..\paradigm\Client\configs\notifications.hpp"

	class BaseAttackImminent
	{
		title = $STR_vn_mf_notification_title_base_attack;
		description = $STR_vn_mf_notification_desc_base_attack_imminent;
		priority = 7;
		color[] = {0.8,0.06,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class BaseAttackPreparing
	{
		title = $STR_vn_mf_notification_title_base_attack;
		description = $STR_vn_mf_notification_desc_base_attack_preparing;
		priority = 7;
		color[] = {0.8,0.5,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class CounterAttackImminent
	{
		title = $STR_vn_mf_notification_title_counter_attack;
		description = $STR_vn_mf_notification_desc_counter_attack_imminent;
		priority = 7;
		color[] = {0.8,0.06,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class CounterAttackPreparing
	{
		title = $STR_vn_mf_notification_title_counter_attack;
		description = $STR_vn_mf_notification_desc_counter_attack_preparing;
		priority = 7;
		color[] = {0.8,0.5,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class CounterAttackShortened
	{
		title = $STR_vn_mf_notification_title_counter_attack;
		description = $STR_vn_mf_notification_desc_counter_attack_shortened;
		priority = 7;
		color[] = {0.8,0.5,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class CounterAttackLost
	{
		title = $STR_vn_mf_notification_title_counter_attack;
		description = $STR_vn_mf_notification_desc_counter_attack_lost;
		priority = 7;
		color[] = {0.8,0.5,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};

	class NewSupportRequest
	{
		title = $STR_vn_mf_notification_title_new_support_request;
		description = "%2";
		priority = 6;
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_ca.paa";
	};

	class Support_Transport_AllOnboard
	{
		title = $STR_vn_mf_notification_title_support_transport;
		description = $STR_vn_mf_notification_desc_support_transport_all_onboard;
		priority = 8;

		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
	};

	class Support_Transport_Complete
	{
		title = $STR_vn_mf_notification_title_support_transport;
		description = $STR_vn_mf_notification_desc_support_transport_complete;
		priority = 8;
		color[] = {0.7,1,0.3,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
	};

	class Support_Transport_PlayersDead
	{
		title = $STR_vn_mf_notification_title_support_transport;
		description = $STR_vn_mf_notification_desc_support_transport_players_dead;
		priority = 8;

		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class Support_Transport_TooClose
	{
		title = $STR_vn_mf_notification_title_support_transport;
		description = $STR_vn_mf_notification_desc_support_transport_too_close;
		priority = 8;
		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class Support_Transport_WrongLocation
	{
		title = $STR_vn_mf_notification_title_support_transport;
		description = $STR_vn_mf_notification_desc_support_transport_wrong_location;
		priority = 8;

		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class TrainingSucceeded
	{
		title = $STR_vn_mf_notification_title_training;
		description = $STR_vn_mf_trainingcomplete;
		priority = 8;
		color[] = {0.7,1,0.3,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
	};

	class TrainingFailedOneTraitPerTeam
	{
		title = $STR_vn_mf_notification_title_training;
		description = $STR_vn_mf_onetraitperteam;
		priority = 8;

		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class TrainingFailedOneTraitPerPlayer
	{
		title = $STR_vn_mf_notification_title_training;
		description = $STR_vn_mf_onetraitperplayer;
		priority = 8;

		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class VehicleLockedToTeam
	{
		title = $STR_vn_mf_notification_title_vehicle_locked;
		description = $STR_vn_mf_vehicle_locked_to_team;
		priority = 8;
		color[] = {1,0.3,0.2,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_ca.paa";
	};

	class ZoneCompleted
	{
		title = $STR_vn_mf_notification_title_zone_completed;
		description = "%1";
		priority = 8;
		color[] = {0.7,1,0.3,1};
		iconPicture = "\A3\ui_f\data\map\mapcontrol\taskIconDone_ca.paa";
	};
	class EmptyFoodItem
	{
		title = $STR_vn_mf_notification_title_empty_food_item;
		description = $STR_vn_mf_notification_desc_empty_food_item;
		priority = 7;
		color[] = {0.8,0.5,0,1};
		iconPicture = "\A3\ui_f\data\Map\Markers\Military\warning_ca.paa";
	};
};
