class support_resupply : support_task
{
	taskcategory = "SUP";
	tasktitle = $STR_vn_mf_task_support_resupply_title;
	taskname = $STR_vn_mf_task_support_resupply_title;
	taskdesc = $STR_vn_mf_task_support_resupply_desc;
	tasktype = "box";
	taskimage = "vn\missions_f_vietnam\data\img\mikeforce\s\vn_ui_mf_task_ac1.jpg";
	taskgroups[] = {"ACAV", "GreenHornets"};
	requestgroups[] = {"MikeForce","SpikeTeam"};
	rankpoints = 10;
	taskprogress = 0;

	requesterDesc = $STR_vn_mf_task_support_resupply_requesterDesc;

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_resupply";
		supplyClass = "ammo";
		supplies = "LightAmmoSupplies";
	};

	class deliver_crate
	{
		taskname = $STR_vn_mf_task_support_resupply_deliver_crate_title;
		taskdesc = $STR_vn_mf_task_support_resupply_deliver_crate_desc;
	};
};

class support_resupply_medical : support_resupply
{

	tasktitle = $STR_vn_mf_task_support_resupply_medical_title;
	taskname = $STR_vn_mf_task_support_resupply_medical_title;

	requesterDesc = $STR_vn_mf_task_support_resupply_medical_requesterDesc;
	
	class parameters : parameters
	{
		supplyClass = "support";
		supplies = "MedicalSupplies";
	};
};

class support_resupply_food : support_resupply
{
	tasktitle = $STR_vn_mf_task_support_resupply_food_title;
	taskname = $STR_vn_mf_task_support_resupply_food_title;

	requesterDesc = $STR_vn_mf_task_support_resupply_food_requesterDesc;
	
	class parameters : parameters
	{
		supplyClass = "support";
		supplies = "FoodSupplies";
	};
};

class support_resupply_building_materials : support_resupply
{
	tasktitle = $STR_vn_mf_task_support_resupply_building_materials_title;
	taskname = $STR_vn_mf_task_support_resupply_building_materials_title;

	requesterDesc = $STR_vn_mf_task_support_resupply_building_materials_requesterDesc;
	
	class parameters : parameters
	{
		supplyClass = "construction";
		supplies = "BuildingSupplies";
	};
};

class support_resupply_workshop : support_resupply
{
	tasktitle = $STR_vn_mf_task_support_resupply_workshop_title;
	taskname = $STR_vn_mf_task_support_resupply_workshop_title;

	requesterDesc = $STR_vn_mf_task_support_resupply_workshop_requesterDesc;
	
	class parameters : parameters
	{
		supplyClass = "vehicles";
		supplies = "WorkshopSupplies";
	};
};

class support_transport : support_task
{
	taskcategory = "SUP";
	tasktitle = "Collect Squad";
	taskname = "Collect Squad";
	taskdesc = "Collect %1 from the given position, and drop them at their desired location.";
	tasktype = "land";
	taskgroups[] = {"ACAV", "GreenHornets"};
	//TODO: Remove GreenHornets and ACAV
	requestgroups[] = {"MikeForce","SpikeTeam", "ACAV", "GreenHornets"};
	rankpoints = 10;
	taskprogress = 0;

	requesterDesc = "Request pickup from a specific location.";

	//The script called when the task is created.
	taskScript = "vn_mf_fnc_state_machine_task_system";

	//Data for the script to use to customise behaviour
	class parameters
	{
		stateMachineCode = "vn_mf_fnc_task_sup_transport";
		RankPointsPerKM = 10;
	};

	//Data for subtasks. These are specific to the script.
	class mount
	{
		taskname = "Pickup Squad";
		taskdesc = "Collect the squad from this position";
	};

	class transport
	{
		taskname = "Transport the Squad";
		taskdesc = "Transport the squad to the location of their choice.";
	};
};

#include "acav\tasks.hpp"
#include "greenhornets\tasks.hpp"
#include "mikeforce\tasks.hpp"
#include "spiketeam\tasks.hpp"