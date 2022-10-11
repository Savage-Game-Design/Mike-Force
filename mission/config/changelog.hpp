class Changelog {
	class 1_00_02 {
		version = "1.00.02";
		date = "9th October 2022";
		changes[] = {
			"[New] Adds masterarm functionality to vehicle spawn building",
			"[Change] Makes HQ defense complete faster",
			"[Change] Updates dynamic view distance to have more configuration options",
			"[Change] AI will no longer despawn when last player is downed in the AO",
			"[Fix] Sites will no longer fall through the map and be un-completable",
			"[Fix] Players will no longer get 'Mission Failed' if the server loads take a long time",
			"[Fix] Player numbers will update correctly after players disconnect",
			"[Fix] Zeus'd in vehicles will now have the correct skin, instead of US default"
		};
	};
	class 1_00_01 {
		version = "1.00.01";
		date = "16th July 2022";
		changes[] = {
			"[Fix] Wrecks will no longer reappear at the bottom left of the map",
			"[Fix] Sites won't spawn near to the main base",
			"[Fix] 1.2 magazines not showing in arsenal or in supply crates",
			"[Fix] Duty officers now face in the right direction",
			"[Fix] Logistic menu popup no longer appears",
			"[Fix] Trash can on Altis now clears equipment",
			"[Fix] Fog turned down on The Bra",
			"[Fix] Call-in time increased for RTO on The Bra",
			"[Fix] Added trash can to Green Hornets on The Bra",
			"[Fix] Howitzers not respawning on The Bra"
		};
	};
	class 1_00_00 {
		version = "1.00.00";
		date = "12th July 2022";
		changes[] = {
			"[New] Spike team implementation. The new special purpose team meant for scouting sites.",
			"[New] Tutorial to teach the basics of the game.",
			"[New] Wreck recovery buildable. Allows the ability to recover wrecks at FOBs.",
			"[New] Added support for the new 'The Bra' map.",
			"[New] Added the dynamic group system (default keybind is U).",
			"[New] Improved wheel menu implementation for vehicles and supplies.",
			"[New] Ported MF to Altis map. Grab the compatibility patch from the SGD workshop!",
			"[Change] 1.2 content added to the arsenal, workshop, and docks.",
			"[Change] Icon-based scouting.",
			"[Change] Refactored teams(MF,ACAV,...) to not use the group system.",
			"[Change] Update welcome menu to only show after update by default",
			"[Change] Add M101 Howitzers to configurable logistics.",
			"[Fix] Players not being able to get in team-locked vehicles.",
			"[Fix] Runtime error when building if no blocked areas."
		};
	};
	class 0_67_00 {
		version = "0.67.00";
		date = "27th May 2022";
		changes[] = {
			"[New] Sites must now be found by infantry, using the 'Scout' action to help them close in on the site.",
			"[New] 'Docks' building that allows boats to be spawned when placed on water.",
			"[New] Extra attacks will be periodically sent against in-use FOBs.",
			"[New] Additional options for player stamina are available in mission parameters.",
			"[Change] Vehicles are now locked using their classname in the mission config.",
			"[Change] Site quantities per zone can now be configured in the map config."
		};
	};
	class 0_66_05 {
		version = "0.66.05";
		date = "17th March 2022";
		changes[] = {
			"[New] Added supply depots that expand base supply cap",
			"[New] Players in boats can package nearby underwater wrecks",
			"[Change] Simulation disabled on all of the cleanup bins",
			"[Change] Rebuilt how reinforcements are allocated to objectives",
			"[Fix] Fixed tasks not completing since Arma 2.08"
		};
	};
	class 0_66_04 {
		version = "0.66.04";
		date = "22nd February 2022";
		changes[] = {
			"[Fix] Cleanup system now correctly tidies up dead bodies."
		};
	};
	class 0_66_03 {
		version = "0.66.03";
		date = "21st February 2022";
		changes[] = {
			"[New] Added new zone defense mechanic. Failing this counterattack will result in the zone being reset!",
			"[New] Added feedback message when placing buildings in a FOB",
			"[New] Added trash cans to all spawn areas that can be used to trigger a local cleanup",
			"[New] Added food and drink information in the arsenal",
			"[Change] Rebuilt cleanup system to maintain better FPS, with mission parameters",
			"[Change] Rebuilt the snake damage system to make use of medications. In addition snake bites now do damage over time to hunger and thirst levels instead of instantly reducing them to zero.",
			"[Fix] Fixed radio regroup message spam",
			"[Fix] Fixed missing role information in the task roster",
			"[Fix] Added missing ammo types to the arsenal",
			"[Fix] Wheel menu will now close when moving away from the object being interacted with",
			"[Fix] Duty officers now face the correct direction"
		};
	};
	class 0_66_02 {
		version = "0.66.02";
		date = "16th December 2021";
		changes[] = {
			"[New] Mission will end and restart when all zones are captured",
			"[New] Added map markers for bases",
			"[New] Added expanded info for zones and bases",
			"[New] Trees that are chopped down will be removed on mission start",
			"[New] Configured additional Respawn and HQ buildings",
			"[New] Added new markers showing players class",
			"[New] Expanded list of vehicle markers",
			"[New] Added ACRE radio mod support",
			"[New] Added toggle for the welcome menu",
			"[New] Added feedback when attempting to consume an empty item",
			"[New] Added parameter for disabling player map markers",
			"[New] Added parameters for the snake system",
			"[New] Added parameters for the medical system",
			"[New] Added parameters to disable/enable RTO supports",
			"[New] Added parameters for limiting the number of players on a team",
			"[New] Added parameters for controlling hunger and thirst",
			"[Change] Zone names are now properly displayed in task names",
			"[Change] Rebalanced arsenal ranks and added missing bag for SCUBA gear",
			"[Change] Removed unused counter attack message",
			"[Change] You can no longer build inside a vehicle workshop",
			"[Change] Removed 2035 equipment from the arsenal",
			"[Change] Made explosive specialists a unique class instead of giving everyone the trait",
			"[Change] [Admin] Removed most RPT logging",
			"[Fix] Respawn points no longer occasionally disappear on mission start",
			"[Fix] Supply no longer disappears on mission start",
			"[Fix] Fixed vehicles getting stuck in a infinite respawn loop if destroyed on their spawn point",
			"[Fix] Fixed vehicles being able to be used as a building anchor",
			"[Fix] Fixed exploit with transport requests",
			"[Fix] Fixed players getting stuck in a locking vehicle",
			"[Fix] Admins now have access to the arsenal",
			"[Fix] NVA Mortar backpack removed due to exploit",
			"[Fix] The escape menu now closes when the welcome menu is opened",
			"[Fix] Fixed improperly placed jeep on Cam Lao Nam",
			"[Fix] Potentially fixed rare issue where a packaged wreck cannot be picked up",
			"[Fix] Fixed typo in options menu",
			"[Fix] Added missing respawn and logistics configs for some vehicles on Khe Sanh",
			"[Fix] Changed the mission image filepath to prevent a clickthrough error",
			"[Fix] Supply officers should no longer be attacked by the AI"
		};
	};
	class 0_66_01 {
		version = "0.66.01";
		date = "25th September 2021";
		changes[] = {
			"[New] Added content from SOG:PF 1.1 update to arsenal",
			"[New] Icons added for vehicles created at the workshop",
			"[New] FM radio now plays music when built",
			"[New] Customisation options for the view distance helper",
			"[New] Static weapon crates can be spawned",
			"[New] Trees can now be cut using axes",
			"[Change] Rebalanced arsenal ranks and added missing gear",
			"[Change] Updated default loadouts for players",
			"[Change] Contents of the medical supply crate improved",
			"[Change] Contents of the ammo crates improved",
			"[Change] Building categories are reworked",
			"[Fix] Sites are much less likely to spawn underwater or underground",
			"[Fix] Medikits not working to revive people correctly",
			"[Fix] Leghorn removed on Cam Lao Nam",
			"[Fix] Headless clients should connect correctly",
			"[Fix] Slingloading locked vehicles",
			"[Fix] Copilot seats are now correctly locked to team",
			"[Fix] AI will no longer mount static weapons loaded into vehicles"
		};
	};
	class 0_65_03 {
		version = "0.65.03";
		date = "7th May 2021";
		changes[] = {
			"[New] Added 3 headless client slots",
			"[New] Added parameter to change the AI limit",
			"[Fix] Scaled up the task roster"
		};
	};
	class 0_65_02 {
		version = "0.65.02";
		date = "7th May 2021";
		changes[] = {
			"[Change] Reduced the mission to 32 slots (the number the mission is designed for)"
		};
	};
	class 0_65_01 {
		version = "0.65.01";
		date = "6th May 2021";
		changes[] = {
			"Initial Beta Release"
		};
	};
};
