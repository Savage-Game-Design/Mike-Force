class secondary_mf1 : task
{
	taskcategory = "SEC";
	tasktitle = "Reinforce ARVN";
	taskname = "Reinforce ARVN";
	taskdesc = "Reinforce troops at their location";
	tasktype = "defend";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_mf1.jpg";
	taskgroups[] = {"MikeForce"};
	rankprogress = 10;
	taskprogress = 4;

	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_sec_reinforce";
		timeout = 1800;
	}

	class defend_troops
	{
		taskname = "Defend Troops";
		taskdesc = "Reinforce troops at their location";
	};

	class talk_to_commander
	{
		taskname = "Talk to Commander";
		taskdesc = "Talk to Commander";
	};
};


class secondary_mf3 : task
{
	taskcategory = "SEC";
	tasktitle = "Destroy the Camp";
	taskname = "Destroy the Camp";
	taskdesc = "There's rumours of a VC camp in the area. Find it, eliminate it.";
	taskgroups[] = {"MikeForce"}; // all
	tasktype = "attack";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_mf3.jpg";
	rankpoints = 10;
	taskprogress = 10;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_sec_destroy_camp";
		timeout = -1;
	};

	class find_and_destroy_camp 
	{
		taskname = "Find and Destroy the Camp";
		taskdesc = "Find and destroy the camp that's somewhere near this point.";
	};
};

class secondary_destroy_mortar : task
{
	taskcategory = "SEC";
	tasktitle = "Eliminate Mortar";
	taskname = "Eliminate Mortar";
	taskdesc = "Eliminate the mortar set up near this position.";
	tasktype = "box";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_st2.jpg";
	taskgroups[] = {"MikeForce"};
	rankpoints = 10;
	taskprogress = 10;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_sec_destroy_mortar";
		timeout = -1;
	};

	class preparing_mortar
	{
		taskname = "Prevent Mortar Setup";
		taskdesc = "Prevent the team from deploying the mortar.";
	};

	//Data for subtasks. These are specific to the script.
	class destroy_mortar 
	{
		taskname = "Eliminate the Mortar";
		taskdesc = "Eliminate the mortar set up near this position.";
	};
};

class secondary_destroy_supplies : task
{
	taskcategory = "SEC";
	tasktitle = "Destroy Weapon Caches";
	taskname = "Destroy Weapon Caches";
	taskdesc = "Destroy the enemy weapons caches found in this area. Explosives are advised.";
	taskgroups[] = {"MikeForce"}; // all
	tasktype = "attack";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_mf3.jpg";
	rankpoints = 10;
	taskprogress = 15;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_sec_destroy_supplies";
		timeout = -1;
	};

	class destroy_crate_0 
	{
		taskname = "Destroy Weapons Cache Alpha";
		taskdesc = "Destroy the weapons cache found near this point. Explosives are recommended.";
	};

	class destroy_crate_1 
	{
		taskname = "Destroy Weapons Cache Bravo";
		taskdesc = "Destroy the weapons cache found near this point. Explosives are recommended.";
	};

	class destroy_crate_2
	{
		taskname = "Destroy Weapons Cache Charlie";
		taskdesc = "Destroy the weapons cache found near this point. Explosives are recommended.";
	};
};

class secondary_patrol : task
{
	taskcategory = "SEC";
	tasktitle = "Patrol Area";
	taskname = "Patrol Area";
	taskdesc = "Patrol along the designated route and ensure the area is secure.";
	taskgroups[] = {"MikeForce"}; // all
	tasktype = "walk";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_mf3.jpg";
	rankpoints = 10;
	taskprogress = 10;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_sec_patrol";
		timeout = -1;
	};

	class patrol_area
	{
		taskname = "Patrol the Area";
		taskdesc = "Patrol the area to gather intelligence";
	};
};