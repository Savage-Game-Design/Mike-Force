class CfgHints
{
	class Overview {
		displayName = "Overview";

		class Tutorial {
			displayName = "Tutorial";
			displayNameShort = "Tutorial";
			description = "Welcome to the Mike Force tutorial. As you play, these survival cards will show up to provide you with helpful hints about the various aspects of the gamemode. Cards be re-read in the Field Manual, accessible from the escape menu. The tutorial can be disabled in the gamemode settings menu.";
			// image = ""; 
			// Note: No Image
		};

		class Gamemode {
			displayName = "Your goal";
			displayNameShort = "Your goal";
			description = "As a member of one of four elite units, your mission is to capture and hold all of the marked areas in Vietnam, Laos and Cambodia through any means necessary.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\mission_strategy.paa";
		};

		class Task_Roster {
			displayName = "Task Roster";
			displayNameShort = "Task Roster";
			description = "The task roster is your first point of contact in Mike Force, accessed by pressing the H key (default). Here you can select your team, track your tasks, request support and check your rank and medals.";
			//image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\<cardname>.paa";
			//Note: No image
		};

		class Gearing_Up {
			displayName = "Gearing Up";
			displayNameShort = "Gear Up";
			description = "You can gear up by accessing an arsenal at one of the main bases. Make sure you grab some food and water, first aid kits and a shovel for building. Take as much gear as you can carry: you dont want to run out of bullets in the middle of a firefight!";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\arsenal.paa";
		};

		class Fast_Travel {
			displayName = "Fast Travel";
			displayNameShort = "Fast Travel";
			description = "Fast travel is a quick way to travel around the main US bases for each team. You can fast travel by standing next to the map stand in game and pressing the 6 key (default). Travelling in this way is free and instant!";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\map.paa";
		};

	};

	class Building {
		displayName = "Building";

		class Overview {
			displayName = "Overview";
			displayNameShort = "Overview";
			description = "Construction! To start building, open the building menu using the N key (default). You will see the available buildings and objects on the left hand menu, and a description of each building or object on the right. Most buildings can only be built when certain conditions are met!";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\build_menu.paa";
		};

		class Placing {
			displayName = "Placing Buildings";
			displayNameShort = "Placing Buildings";
			description = "You're now placing a building! While placing, you can adjust position, height and rotation by using the left and right mouse buttons to cycle through different modes. Then the ghost building is green, you can place it by using the 'Build' hold action.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\ghost_building.paa";
		};

		class Finishing {
			displayName = "Finishing a Structure";
			displayNameShort = "Finishing";
			description = "When a building is placed, it is only partially built. To finish construction, you need to equip a shovel from the arsenal and use it on the building. After several hits, the building will be finished.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\ghost_building.paa";
		}

		class Resupplying {
			displayName = "Resupplying Buildings";
			displayNameShort = "Resupplying Buildings";
			description = "Buildings and constructed objects require building supplies to prevent them from decaying. To resupply a building, you'll need a resupply crate nearby or sandbags in your inventory. Then open the building's wheel menu with 6 (default) and press resupply. Buildings that are of an FOB share the same supplies, while standalone buildings have their own supply pool.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\decay.paa";
		};

		class Decay {
			displayName = "Decay";
			displayNameShort = "Decay";
			description = "When a building runs out of supplies, it begins to decay! A decaying building will be destroyed when no players are nearby. These buildings are also inactive - special features such as respawning or vehicle creation will be disabled.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\decay.paa";
			//Note: The doc said the radial menu image, but I couldn't find one that made sense, so I just inserted the decay image.
		};

		class Bases {
			displayName = "FOBs";
			displayNameShort = "Starting FOBs";
			description = "Situation rooms are the heart of an FOB. They connect all of the surrounding buildings to a single supply pool, and enable the building of FOB specific structures. Most of the building you do should be part of an FOB! <br/><br/>To build a situation room, open the build menu with the N key (default) and then select 'Feature: HQ' as a category. Building an FOB near to existing structures will automatically make them part of the FOB.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\situation_room.paa";
		};
		
		class Medical_Tent {
			displayName = "Medical Tent";
			displayNameShort = "Medical Tent";
			description = "Medical tents are vital to ensuring your team can stay in the fight. They enable your team to heal up at the FOB, without consuming precious first aid kits.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\medical_tent.paa";
		};

		class Checkpoint {
			displayName = "Checkpoint";
			displayNameShort = "Checkpoint";
			description = "The building next to you is a checkpoint. You can respawn at these buildings, although that depletes the building's supplies. Running out of supplies will disable redeployment to that checkpoint, so remember to keep resupplying to ensure you can always get back in the fight.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\checkpoint.paa";
		};

		class Construction {
			displayName = "Construction";
			displayNameShort = "Construction";
			description = "Engineers can place building and structures to help their team. Engineers on ACAV have access to more structures than engineers on other teams. To start building, open the building menu using the N key (default).";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\build_menu.paa";
		};

	};
		
	class Deployment {
		displayName = "Deployment";

		class Duty_Officer {
			displayName = "Team and Training Selection";
			displayNameShort = "Duty Officer!";
			description = "Duty officers allow you to change your team and train a speciality. To change teams, open your task roster with the H key (default), and select your team insignia. To train a speciality, press 6 (default) while looking at the duty officer to open the wheel menu. ";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\duty_officer.paa";
		};
	};

	class Environment {
		displayName = "Environment";

		class Snakes {
			displayName = "Snakes";
			displayNameShort = "Snake Bite!";
			description = "Snake Bite! Snakes are a major hazard in jungles of Vietnam. Make sure to keep an eye out, as a snake bite at the wrong time could have some serious consequences. For now, consume some food and drink to get your strength back.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\snake.paa";
		};

		class Night {
			displayName = "Night Fighting";
			displayNameShort = "Night Fighting";
			description = "Night fighting! In order to fight effectively at night, you'll have to use all of the tools at your disposal. Flare launchers and flare grenades are available in the arsenal, as well as on almost all vehicles! Be sure to ask your RTO can call in illuminations - the flare ship lasts all night!";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\FOB_flare.paa";
		};

	};

	class Gameplay {
		displayName = "Gameplay";

		class Respawning_Checkpoint {
			displayName = "Respawning at Checkpoint";
			displayNameShort = "Redeployment!";
			description = "You have re-deployed back to a checkpoint! This action depletes the checkpoint or FOB's supplies. Running out of supplies will disable redeployment to that checkpoint, so remember to keep resupplying to ensure you can always get back in the fight. Remember your teammates need those supplies too!";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\checkpoint_supplies.paa";
		};

		class Needs {
			displayName = "Food and Water";
			displayNameShort = "Food and Water";
			description = "Food and water allow you to keep your strength up in the field. Without food or water, your ability to move and fight will be severely hindered, leaving you an open target for the VC or NVA. Make sure you don't leave base without at least a canteen and some rations, or you'll need to borrow some from a friend.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\drink_food.paa";
		};

		class Counterattack {
			displayName = "Counterattack";
			displayNameShort = "Counterattack";
			description = "The enemy have located your FOB and dispatched a counterattack! Make sure you have a fire team in the FOB to dig in for the defense, and enough ammo and med supplies to hold out. Keep your checkpoint resupplied to ensure quick reinforcements if the FOB is overrun. The strength of the enemy counter attack is determined by the strength of the enemy in the current AO.";
			//image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\<cardname>.paa";
			//Note: No image.
		};

		class Tasks {
			displayName = "Tasks";
			displayNameShort = "Task Menu";
			description = "The task list in the task roster shows you the tasks currently assigned to your team. Support tasks and other objectives will also be shown when they're available. Tasks can also be viewed in the map screen.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\AA.paa";
		};

		class Logistics {
			displayName = "Logistics Inventory";
			displayNameShort = "Logistics Inventory";
			description = "The logistics inventory allows vehicles to carry a variety of supplies and static weapons. You can access this by looking at a vehicle and selecting 'Logistics Inventory'. Vehicles have differing maximum capacities, so it is worth familiarising yourself with each vehicle. You can place objects into vehicles by picking up the items, looking at the vehicle andusing the scroll wheel option 'load item into vehicle'. Be advised - loading items into a vehicle increases its weight, so don't be surprised if it doesn't perform as you'd expect!";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\logistic_menu.paa";
		};

	};

	class Logistics {
		displayName = "Logistics";

		class Supplies {
			displayName = "Supplies";
			displayNameShort = "Supplies";
			description = "A good supply line is an important aspect of gameplay. Without building, ammo, food and medical supplies, your team won't stand a chance against the NVA. Supplies can be ordered from a supply officer at the Green Hornets or ACAV base, then driven or slingloaded to their destination.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\supply_officer.paa";
		};

		class Vehicles {
			displayName = "Vehicle Creation";
			displayNameShort = "Vehicle Creation";
			description = "Vehicle workshops allow you to create new vehicles in the field, at the cost of supplies. In order to create a vehicle, press the 6 key (default) while looking at the building and select the vehicle or static weapon you wish to create. Once you make your selection, the vehicle will spawn inside the vehicle maintenance shed, if the inside of the shed is empty.";
			//image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\<cardname>.paa";
			//Note: No image.
		};

		class Wrecks {
			displayName = "Wreck Recovery";
			displayNameShort = "Wreck Recovery";
			description = "When certain vehicles are damaged beyond repair in combat, a wreck is left behind. This wreck can be packaged up into a crate, and slingloaded by Green Hornets or loaded into a truck. Make sure to make a support task so that teams know where to find the wreck! Once collected, take to the wreck recovery zone at the Pleiku. The vehicle will then respawn at its previous base.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\wreck_packing.paa";
		};

		class Support_Tasks {
			displayName = "Support Tasks";
			displayNameShort = "Support Tasks";
			description = "You'll need support from your team to survive in the jungle. To make a support request, open the task roster (H) and click on the support request section. On the right hand menu, you'll see a list of available requests for your team. Select a task and the team you want help from. Finally, select a position by clicking 'select position' and clicking on the map. Remember to click accept to lock in the position!  To dispatch your support request, click 'create new support task'. Now kick back and wait for the other team to help!";
			//image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\<cardname>.paa";
			//Note: No image.
		};

	};

	class Module {
		displayName = "Module";

		class Downed {
			displayName = "Downed";
			displayNameShort = "Withstand and keep on fighting!";
			description = "Withstand and keep on fighting! Withstand will allow you patch yourself back up and get back in the fight, if you're downed during combat. After being downed, wait a minute and a withstand option will appear. Be advised withstanding will consume multiple medical kits, so it's better to get your teammates to help where possible!";
			//image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\<cardname>.paa";
			//Note: No image.
		};

		class Master_Arm {
			displayName = "Master Arm";
			displayNameShort = "Lock and Load!";
			description = "Lock and Load! The master arm gives you the ability to fully rearm, repair and refuel a vehicle or aircraft. Simply park near one of the vehicle bays in pleiku, and select the master arm action! However, bear in mind this option is only available to the driver of the vehicle. In addition to refuelling, rearming and repairing, you can change the skin and armaments of your vehicle.";
			//image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\<cardname>.paa";
			//Note: No image.
		};

	};

	class Player {
		displayName = "Player Information";
		
		class Rank {
			displayName = "Rank";
			displayNameShort = "Promotion!";
			description = "Congratuations, you've just been promoted! You now have access to more equipment and vehicles. Make sure to check the arsenal when you get back to base!";
			//image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\<cardname>.paa";
			//Note: No image.
		};

	};

	class Team {
		displayName = "Team";

		class Mike_Force {
			displayName = "Mike Force";
			displayNameShort = "Mike Force, attack and clear those objectives.";
			description = "Mike Force, attack and clear those objectives! Mike Force's primary mission is to clear hostiles from the zone and eliminate enemy sites such as AA and artillery. You'll be in the thick of it, supported by ACAV on the ground and Green Hornets in the air.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\mike_force.paa";
		};

		class Green_Hornets {
			displayName = "Green Hornets";
			displayNameShort = "Green Hornets, Supply, Transport and CAS.";
			description = "Transport, supplies and CAS. These are the primary mission goals of Green Hornets. As a pilot for the Green Hornets, you should prioritise getting people to where they need to go, as well as providing critical supplies to distant outposts. However, when your team calls a Prairie Fire emergency - don't hesitate to provide some heavy fire support!";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\green_hornet.paa";
		};

		class ACAV {
			displayName = "ACAV";
			displayNameShort = "ACAV, Build, Supply, Win!";
			description = "You'll never get anywhere without a base. With unlimited numbers of engineers, ACAV are perfectly positioned to build all of the necessary structures to allow all your team to capture, hold and deploy from the current zone. ACAV also fill the role of heavy fire support on the ground, wading into battle with tanks and gun trucks.";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\acav.paa";
		};

		class Close_Air {
			displayName = "Close Air Support";
			displayNameShort = "Close Air Support!";
			description = "Close Air Support. When providing close air support as Green Hornets, remember to only engage targets designated by support tasks. Helping the team is your main job, getting kills is not.";
			//image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\<cardname>.paa";
			//Note: No image.
		};

	};

	class Artillery {
		displayName = "Artillery";

		class RTO {
			displayName = "RTO";
			displayNameShort = "Bring the Iron Rain!";
			description = "Bring the Iron Rain! The Radio Telephone Operator is critical to providing heavy fire support to the team. As an RTO you have the power to control the battlefield through a variety of air and artillery strikes. Illuminations are key to being able to operate during the night. You'll need a radio backpack though in order to call for support!";
			image = "\vn\ui_f_vietnam\ui\mikeforce\survivalcards\arty_support.paa";
		};

	};
};