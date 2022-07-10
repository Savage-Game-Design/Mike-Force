class task
{
	taskcategory = "";
	tasktitle = "";
	taskname = "";
	//Code that produces variables that are applied to the task name using the 'format' command
	taskformatdata = "[(_this getVariable 'taskMarker') call vn_mf_fnc_zone_marker_to_name]";
	taskdesc = "This should not be seen. If you are seeing this, something is mis-configured.";
	taskimage = "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_secondary.paa";
	taskgroups[] = {"MikeForce","SpikeTeam","ACAV","GreenHornets"}; // all
	requestgroups[] = {};
	tasktype = "walk";
	rankpoints = 0;
	taskprogress = 0;

	//The script called when the task is created.
	taskScript = "{}";

	//Data for the script to use to customise behaviour
	class parameters {};
};

//Bare minimum for a simple task system task to prevent it from erroring.
class simple_task_system_task : task
{
	//The script called when the task is created.
	taskScript = "vn_mf_fnc_simple_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		initialSubtasks[] = {};
	};
};

class support_task : task
{
	taskcategory = "SUP";
	tasktitle = "";
	taskname = "";
	taskformatdata = "private _player = _this getVariable 'supportRequestPlayer'; [name _player]";

	//The function called to create the support task.
	//The default creation function always the creates the task, and gives the player that created it a notification.
	//Override this to change how a support task is created.
	creationfunction = "vn_mf_fnc_create_support_default";
};

class zone_connector : task
{
	taskcategory = "PRI";
	tasktitle = "Secure the Road to %1";
	taskname =	"Secure the Road to %1";
	taskformatdata = "[_this getVariable 'newZone']";
	taskdesc = "Build a watch tower at the given location. %1 will become the new active zone.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_zone_connector";
	};

	class build_checkpoint
	{
		taskName = "Build a Watch Tower";
		taskDesc = "Build a watch tower to begin the next zone.";
	};
};

//Primary tasks for each location
#include "primary\tasks.hpp"

//Secondary tasks for each location
#include "secondary\tasks.hpp"

//Support tasks created between players
#include "support\tasks.hpp"

//Tasks to defend against enemy attacks
#include "defend\tasks.hpp"

//Tasks to destroy enemy assets
#include "destroy\tasks.hpp"
