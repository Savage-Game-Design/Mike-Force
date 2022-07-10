class secondary_st2 : task
{
	taskcategory = "SEC";
	tasktitle = "Destroy Gun Emplacement";
	taskname = "Destroy Gun Emplacement";
	taskdesc = "Destroy the hostile gun emplacement near to the given position.";
	tasktype = "destroy";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_st2.jpg";
	taskgroups[] = {"SpikeTeam", "MikeForce"};
	rankpoints = 10;
	taskprogress = 5;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_sec_destroy_emplacement";
		timeout = -1;
	};

	class preparing_emplacement
	{
		taskname = "Prevent Emplacement Build";
		taskdesc = "Prevent the gun emplacement from being built";
	};

	//Data for subtasks. These are specific to the script.
	class destroy_emplacement 
	{
		taskname = "Find and Destroy Emplacement";
		taskdesc = "Find and destroy the hostile gun emplacement in this area";
	};
};

class secondary_st3 : task
{
	taskcategory = "SEC";
	tasktitle = "Kill Enemy Officer";
	taskname = "Kill Enemy Officer";
	taskdesc = "Kill the enemy officer near to the target position";
	tasktype = "attack";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_st3.jpg";
	taskgroups[] = {"SpikeTeam"};
	rankpoints = 10;
	taskprogress = 10;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_sec_kill_officer";
	};

	//Data for subtasks. These are specific to the script.
	class kill_officer 
	{
		taskname = "Find and Kill the Officer";
		taskdesc = "Find and kill the enemy officer in this area";
	};
};

class secondary_spike_wiretap : task
{
	taskcategory = "SEC";
	tasktitle = "Wiretap";
	taskname = "Wiretap";
	taskdesc = "Mount a recording device to an enemy communications line.";
	tasktype = "attack";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_st3.jpg";
	taskgroups[] = {"SpikeTeam"};
	rankpoints = 10;
	taskprogress = 30;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters 
	{
		stateMachineCode = "vn_mf_fnc_task_sec_spike_wiretap";
	};

	//Data for subtasks. These are specific to the script.
	class enter_ao 
	{
		taskname = "Enter AO";
		taskdesc = "Enter the area of operations on foot.";
	};

	class start_wiretap
	{

		taskname = "Start wiretap";
		taskdesc = "Mount the recording device.";
	};

	class RTB
	{
		taskname = "Return to base";
		taskdesc = "Return to base. At least one team member must survive.";
	};
};


