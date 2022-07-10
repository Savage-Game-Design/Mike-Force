class destroy_aa_site : task
{
	taskcategory = "SEC";
	tasktitle = "Eliminate the AA Site";
	taskname = "Eliminate the AA Site";
	taskdesc = "Enemy AA has been seen firing near this position. Take it out.";
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
		stateMachineCode = "vn_mf_fnc_task_destroy_aa_site";
		timeout = -1;
	};

	class find_and_destroy 
	{
		taskname = "Take out the AA";
		taskdesc = "Find and destroy the AA emplacement that's somewhere near this point.";
	};
};

class destroy_artillery_site : task
{
	taskcategory = "SEC";
	tasktitle = "Eliminate Hostile Artillery";
	taskname = "Eliminate Hostile Artillery";
	taskdesc = "Enemy artillery has been seen firing from this position. Take it out.";
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
		stateMachineCode = "vn_mf_fnc_task_destroy_artillery_site";
		timeout = -1;
	};

	class find_and_destroy 
	{
		taskname = "Find and Destroy Artillery";
		taskdesc = "Eliminate the artillery in the vicinity of this point.";
	};
};

class destroy_camp : task
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
		stateMachineCode = "vn_mf_fnc_task_destroy_camp";
		timeout = -1;
	};

	class find_and_destroy 
	{
		taskname = "Find and Destroy the Camp";
		taskdesc = "Find and destroy the camp that's somewhere near this point.";
	};
};

class destroy_tunnel : task
{
	taskcategory = "SEC";
	tasktitle = "Seal Tunnel Exit";
	taskname = "Seal Tunnel Exit";
	taskdesc = "Intelligence places an enemy tunnel exit in this area. Seal it up.";
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
		stateMachineCode = "vn_mf_fnc_task_destroy_tunnel";
		timeout = -1;
	};

	class find_and_destroy 
	{
		taskname = "Seal Tunnel Exit";
		taskdesc = "Seal the tunnel exit near to this location.";
	};
};

class destroy_vehicle_depot : task
{
	taskcategory = "SEC";
	tasktitle = "Destroy Vehicle Depot";
	taskname = "Destroy Vehicle Depot";
	taskdesc = "An enemy vehicle maintenance point has been placed in this area. Destroy it, and any vehicles you find.";
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
		stateMachineCode = "vn_mf_fnc_task_destroy_vehicle_depot";
		timeout = -1;
	};

	class find_and_destroy 
	{
		taskname = "Find and Destroy Vehicle Depot";
		taskdesc = "Destroy the vehicle supply point near these coordinates.";
	};
};