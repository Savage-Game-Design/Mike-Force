class defend_counterattack : task
{
	taskcategory = "PRI";
	tasktitle = "Defend from Counterattack";
	taskname = "Defend from Counterattack";
	taskdesc = "The enemy is preparing a counterattack, hold the zone at all costs.";
	tasktype = "defend";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_mf3.jpg";
	rankpoints = 10;
	taskprogress = 10;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_defend_counterattack";
		timeout = -1;
	};

	class prepare_zone 
	{
		taskname = "Prepare for Attack";
		taskdesc = "The enemy will launch their attack soon. Set up defenses.";
	};

	class defend_zone
	{
		taskname = "Defend the Zone";
		taskdesc = "Defend the zone until all hostiles have been eliminated.";
	};
};

class defend_base : task
{
	taskcategory = "PRI";
	tasktitle = "Defend FOB from Attack";
	taskname = "Defend FOB from Attack";
	taskdesc = "The enemy is preparing to attack an FOB. Prepare to defend it!";
	tasktype = "defend";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_mf3.jpg";
	rankpoints = 10;
	taskprogress = 10;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_defend_base";
		timeout = -1;
	};

	class prepare_base 
	{
		taskname = "Prepare for Attack";
		taskdesc = "The enemy will launch their attack soon. Set up defenses.";
	};

	class defend_base
	{
		taskname = "Defend the FOB";
		taskdesc = "Defend the FOB until all hostiles have been eliminated.";
	};
};


