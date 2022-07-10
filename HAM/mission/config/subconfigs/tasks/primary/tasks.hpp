class capture_zone : task
{
	taskcategory = "PRI";
	tasktitle = "Capture %1";
	taskname = "Capture %1";
	taskdesc = "Defeat hostile forces in %1, and destroy their HQ's equipment stockpiles.";
	tasktype = "attack";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\p\vn_ui_mf_task_p1.jpg";
	rankpoints = 50;

	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_pri_capture";
		timeout = -1;
	};

	//Data for subtasks. These are specific to the script.
	class hold_hq
	{
		taskname = "Capture and Hold HQ";
		taskdesc = "Enter the enemy HQ and prevent enemies recapturing it.";
	};

	class destroy_sites
	{
		taskname = "Destroy Sites";
		taskdesc = "Destroy all HQs, AA and artillery sites within 1200m.";
	};

	class destroy_enemy_supplies
	{
		taskname = "Destroy Enemy Supplies";
		taskdesc = "Destroy the supplies found at the enemy HQ. Explosives are recommended.";
	};
};

class build_fob : task
{
	taskcategory = "PRI";
	tasktitle = "Build FOB";
	taskname = "Build FOB";
	taskdesc = "Build an FOB to begin claiming zones within %1ms of it.";
	taskformatdata = "[mf_s_baseZoneUnlockDistance]";
	tasktype = "repair";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\p\vn_ui_mf_task_p1.jpg";
	rankpoints = 10;

	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_pri_build_fob";
		timeout = -1;
	};

	//Data for subtasks. These are specific to the script.
	class build
	{
		taskname = "Build a HQ";
		taskdesc = "Construct a HQ building to create a base.";
	};
};