/*
class support_mf_reinforce : support_task
{
	taskcategory = "SUP";
	tasktitle = "Reinforce";
	taskname = "Reinforce";
	taskdesc = "Reinforce %1 at their location";
	tasktype = "defend";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\su\vn_ui_mf_task_mfs1.jpg";
	taskgroups[] = {"MikeForce"};
	requestgroups[] = {"SpikeTeam","ACAV"};
	rankpoints = 10;
	taskprogress = 0;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_simple_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		initialSubtasks[] = {"go_to_location"};
	};

	//Data for subtasks. These are specific to the script.
	class go_to_location
	{
		taskname = "Go to location";
		taskdesc = "Reinforce troops at their location";

		//Data to customise
		//These are specific to each subtask for each mission - see mission documentation.
		class parameters
		{
			Init = "";
			CanRun = "!((allUnits inAreaArray [(_taskDataStore getVariable 'supportRequestPos'),50,50,0,false]) select {alive _x && side _x == west && ((group _x) isEqualTo (missionNamespace getVariable 'MikeForce'))} isEqualTo [])";
			RunAtRegularIntervals = "private _pos = _taskDataStore getVariable ['supportRequestPos', [0,0,0]]; [[_pos,10,10,0,false],[[[_pos, 150]],[[_pos, 100]]] call BIS_fnc_randomPos] call vn_mf_fnc_spawn_enemy_units; _hasSucceeded = true";
			FailureCondition = "false";
			OnFailure = "";
			OnSuccess = "";
			NextSubtasks[] = {"defend_troops"};
		};
	};

	class defend_troops
	{
		taskname = "Defend Troops";
		taskdesc = "Reinforce troops at their location";

		//Data to customise
		//These are specific to each subtask for each mission - see mission documentation.
		class parameters
		{
			Init = "";
			CanRun = "private _pos = _taskDataStore getVariable ['supportRequestPos', [0,0,0]];![[_pos,200,200,0,false]] call vn_mf_fnc_check_enemy_units_alive";
			RunAtRegularIntervals = "_hasSucceeded = true;";
			FailureCondition = "false";
			OnFailure = "[_taskDataStore, 'FAILED'] call vn_mf_fnc_task_complete";
			OnSuccess = "[_taskDataStore, 'SUCCEEDED'] call vn_mf_fnc_task_complete";
			NextSubtasks[] = {};
		};
	};
};
*/