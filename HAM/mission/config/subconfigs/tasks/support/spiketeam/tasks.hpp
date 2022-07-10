class support_st_brightlight : support_task
{
	taskcategory = "SUP";
	tasktitle = "Brightlight";
	taskname = "Brightlight";
	taskdesc = "Rescue the crew of the downed helicopter, %1.";
	tasktype = "box";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\su\vn_ui_mf_task_sts1.jpg";
	taskgroups[] = {"SpikeTeam"};
	requestgroups[] = {"GreenHornets"};
	rankpoints = 10;
	taskprogress = 0;

	requesterDesc = "Request reinforcement and extraction from a specific position";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_brightlight";
		posToReturnTo[] = {"marker", "mf_respawn_greenhornets"};
	};

	//Data for subtasks. These are specific to the script.
	class find_aircrew
	{
		taskname = "Find the crew";
		taskdesc = "Find the stranded crew of the downed helicopter at the position they've specified.";

		//Data to customise
		//These are specific to each subtask for each mission - see mission documentation.
		class parameters
		{
		};
	};

	class protect_aircrew
	{
		taskname = "Protect Aircrew";
		taskdesc = "Protect the stranded crew until they're safely back at base.";

		//Data to customise
		//These are specific to each subtask for each mission - see mission documentation.
		class parameters
		{
		};
	};
};

class support_st_searchAndDestroy : support_task
{
	taskcategory = "SUP";
	tasktitle = "Destroy Gun Emplacements";
	taskname = "Destroy Gun Emplacements";
	taskdesc = "%1 has requested you destroy the gun emplacements at this position.";
	tasktype = "box";
	taskgroups[] = {"SpikeTeam"};
	requestgroups[] = {"GreenHornets", "MikeForce", "SpikeTeam"};
	rankpoints = 10;
	taskprogress = 0;

	requesterDesc = "Request the gun emplacements in this area be destroyed.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_destroy_target";
		targetTypes[] = {"StaticWeapon"};
	};

	//Data for subtasks. These are specific to the script.
	class destroy_targets
	{
		taskname = "Destroy emplacements";
		taskdesc = "Destroy all weapon emplacements within 50m of this position.";
	};
};
