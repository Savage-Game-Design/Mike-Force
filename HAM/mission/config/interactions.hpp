class CfgItemInteractions
{
	class AllAmmoSettings // this is a fake class that holds the settings for the ammo repack feature.
	{
		interactActions[] =
		{
			{"STR_vn_mf_repack", "call vn_mf_fnc_ammo_repack;" } // To disable set this to an empty array here or in description.ext. interactActions[] = {};
		};
	};
	class remove_attributes // Hacky way of removeing player attributes on respawn.
	{
		cures[] =
		{
			{"poison", 1.0},
			{"posion", 1.0},
			{"diarrhea", 1.0}
		};
	};
	class snake_bite
	{
		attributes[] =
		{
			{"poison", 1.0} //
		};
	};
	class dirty_water
	{
		attributes[] =
		{
			{"diarrhea", 0.5} // diuretic, diarrhea
		};
	};
	class vn_prop_med_antivenom
	{
		disallowRepack = 1;
		removeonempty = 0;
		consume = 50;
		water = 0;
		food = 0;
		interactActions[] = 
		{
			{
				"STR_vn_mf_take_medicine",
				"call vn_mf_fnc_consume;"
			};
		};
		attributes[] = 
		{
			// N/A
		};
		cures[] =
		{
			{"poison", 1}
		};
	};
	class vn_prop_med_dysentery : vn_prop_med_antivenom
	{
		cures[] =
		{
			{"diarrhea", 1}
		};
	};
	class vn_prop_drink_01 // canteen 0.75l
	{
		disallowRepack = 1;
		removeonempty = 0;
		consume = 34;	// ammount consumed on each use (all food/drink items have 100 ammo)
		water = 0.1;	// ammount added to thirst if able to be fully consumed
		food = 0;	// ammount added to hunger if able to be fully consumed
		interactActions[] =
		{
			{
				"STR_vn_mf_drink",
				"call vn_mf_fnc_consume;"
			}
			/*,
			{
				"STR_vn_mf_refill",
				"call vn_mf_fnc_consume;"
			}
			*/
		};
		attributes[] =
		{
			// {"diuretic", 1} // diuretic, diarrhea
		};
		cures[] =
		{
			{"alcohol", 1},
			//{"diarrhea", 1}, // diuretic, diarrhea
			{"diuretic", 1}
		};
	};
	class vn_prop_drink_02 : vn_prop_drink_01
	{
		consume = 25;
	}; // canteen 1.00l
	class vn_prop_drink_03 : vn_prop_drink_01 {}; // canteen 0.75l
	class vn_prop_drink_04 : vn_prop_drink_02 {}; // canteen 1.00l
	class vn_prop_drink_05 : vn_prop_drink_01 // bottle 0.50l
	{
		consume = 50;
	};
	class vn_prop_drink_06 : vn_prop_drink_01 // bottles 2.00l (canteen)
	{
		consume = 12.5;
	};

	class vn_prop_drink_07_01 : vn_prop_drink_01 // Tilts Hot Sauce
	{
		consume = 1;
		drink = 0.01;
		removeonempty = 1;
	};
	class vn_prop_drink_07_02 : vn_prop_drink_01 // Hoangs Muoc Mam
	{
		consume = 1;
		drink = 0.01;
		removeonempty = 1;
	};
	class vn_prop_drink_07_03 : vn_prop_drink_01 // Napalm Sauce
	{
		consume = 1;
		drink = 0.01;
		removeonempty = 1;
	};
	class vn_prop_drink_08_01 : vn_prop_drink_01 // Savage Bia (Beer)
	{
		consume = 25;
		drink = 0.5;
		food = 0.05;
		removeonempty = 1;
		attributes[] =
		{
			{"alcohol", 1} // diuretic, diarrhea
		};
	};
	class vn_prop_drink_09_01 : vn_prop_drink_01 // Whiskey
	{
		consume = 100;
		drink = 0.1;
		removeonempty = 1;
		attributes[] =
		{
			{"alcohol", 1} // diuretic, diarrhea
		};
	};

	class vn_prop_drink_10 : vn_prop_drink_01 // Water pack 2L
	{
		consume = 12.5;
		removeonempty = 1;
	};
	class vn_prop_food_meal_01  //  (Ration 0.75Kg) Etc
	{
		disallowRepack = 1;
		removeonempty = 1;
		consume = 34;
		water = 0;
		food = 0.1;
		interactActions[] =
		{
			{
				"STR_vn_mf_eat",
				"call vn_mf_fnc_consume;"
			}
		};
		attributes[] =
		{
			{"diarrhea", 0.05} // diuretic, diarrhea
		};
	};
	class vn_prop_food_meal_01_01 : vn_prop_food_meal_01 // Fox Hole Dinner for Two. Chicken and Noodles + Turkey Loaf + Cheese Spread + Hot sauce
	{
		consume = 50;
		water = 0.5;
		food = 1;
	};
	class vn_prop_food_meal_01_02 : vn_prop_food_meal_01 // Soup Du Jour. Ham and Lima Beans + Crackers + Hot sauce
	{
		consume = 100;
		water = 0.5;
		food = 1;
	};
	class vn_prop_food_meal_01_03 : vn_prop_food_meal_01 // Breast of Chicken Under Bullets. Boned Chicken + Cheese Spread + White Bread + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_04 : vn_prop_food_meal_01 // Battlefield Fufu. Boned Chicken + Peanut Butter + Milk + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_05 : vn_prop_food_meal_01 // Ham with Spiced Apricots. Fried Ham + Apricots + Jam + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_06 : vn_prop_food_meal_01 // Pork Mandarin. Pork-steak + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_07 : vn_prop_food_meal_01 // Tin Can Casserole. Frank and Beans + Beefsteak + Crackers + Cheese Spread + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_08 : vn_prop_food_meal_01 // Creamed Turkey on Toast. Turkey loaf + White Bread + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_09 : vn_prop_food_meal_01 // Fish with Front line Stuffing. Crackers + Ham and Egg Chopped + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_10 : vn_prop_food_meal_01 // Combat Zone Burgoo. Spiced Beef + Ham and Lima Beans + Crackers + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_11 : vn_prop_food_meal_01 // Patrol Chicken Soup. Fresh Chicken + Crackers + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_12 : vn_prop_food_meal_01 // Guard Relief Eggs Benedict. White Bread + Ham and Eggs Chopped + Cheese Spread + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_13 : vn_prop_food_meal_01 // Beefsteak En Croute. White Bread + Beefsteak + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_14 : vn_prop_food_meal_01 // Curried Meat Balls Over Rice. Meat Balls and Beans + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_15 : vn_prop_food_meal_01 // Cease Fire Casserole. Beefsteak + Spiced Beef + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_16 : vn_prop_food_meal_01 // Rice Paddy Shrimp. Fresh Shrimp + Cheese Spread + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_17 : vn_prop_food_meal_01 // Battlefield Birthday Cake. Pound Cake + Chocolate Candy + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_01_18 : vn_prop_food_meal_01 // Pecan Cake Roll with Peanut Butter Sauce. Pecan Cake Roll + Peanut Butter + Hot sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_02_01 : vn_prop_food_meal_01 // Con ho. Rice + Tiger + Vegetables + Fish Sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_02_02 : vn_prop_food_meal_01 // Con voi. Rice + Elephant + Vegetables + Fish Sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_02_03 : vn_prop_food_meal_01 // Con ran. Rice + Snake + Vegetables + Fish Sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_02_04 : vn_prop_food_meal_01 // Cha ca la vong. Rice + Fish + Vegetables + Fish Sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_02_05 : vn_prop_food_meal_01 // Con tom. Rice + Shrimp + Vegetables + Fish sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_meal_02_06 : vn_prop_food_meal_01 // Pho ga. Rice + Chicken + Vegetables + Fish sauce
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};

	class vn_prop_food_pir_01_01 : vn_prop_food_meal_01 // PIR Rations. Contains 1Kg of high energy food: PIR ration (Beef)
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_pir_01_02 : vn_prop_food_meal_01 // PIR Rations. Contains 1Kg of high energy food: PIR ration (Fish and Squid)
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_pir_01_03 : vn_prop_food_meal_01 // PIR Rations. Contains 1Kg of high energy food: PIR ration (Shrimp and Mushroom)
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_pir_01_04 : vn_prop_food_meal_01 // PIR Rations. Contains 1Kg of high energy food: PIR ration (Mutton)
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_pir_01_05 : vn_prop_food_meal_01 // PIR Rations. Contains 1Kg of high energy food: PIR ration (Sausage)
	{
		consume = 100;
		water = -0.1;
		food = 1;
	};

	class vn_prop_food_box_01_01 : vn_prop_food_meal_01 // Boxed Rations. Contains 10Kg of food: Ration box (LRP Ration Box)
	{
		consume = 10;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_box_01_02 : vn_prop_food_meal_01 // Boxed Rations. Contains 10Kg of food: Ration box (PIR Ration Box)
	{
		consume = 10;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_box_01_03 : vn_prop_food_meal_01 // Boxed Rations. Contains 10Kg of food: Ration box (MCI Ration Box)
	{
		consume = 10;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_box_02_01 : vn_prop_food_meal_01 // Boxed Rations. Contains 2Kg of food: Ration box (Ham and Eggs Chopped)
	{
		consume = 50;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_box_02_02 : vn_prop_food_meal_01 // Boxed Rations. Contains 2Kg of food: Ration box (Ham Fried)
	{
		consume = 50;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_box_02_03 : vn_prop_food_meal_01 // Boxed Rations. Contains 2Kg of food: Ration box (Beans w/ Frankfurter Chunks)
	{
		consume = 50;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_box_02_04 : vn_prop_food_meal_01 // Boxed Rations. Contains 2Kg of food: Ration box (Spaghetti w/ Ground Meat)
	{
		consume = 50;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_box_02_05 : vn_prop_food_meal_01 // Boxed Rations. Contains 2Kg of food: Ration box (Turkey Loaf)
	{
		consume = 50;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_box_02_06 : vn_prop_food_meal_01 // Boxed Rations. Contains 2Kg of food: Ration box (Pork Steak)
	{
		consume = 50;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_box_02_07 : vn_prop_food_meal_01 // Boxed Rations. Contains 2Kg of food: Ration box (Beef w/ Spiced Sauce)
	{
		consume = 50;
		water = -0.1;
		food = 1;
	};
	class vn_prop_food_box_02_08 : vn_prop_food_meal_01 // Boxed Rations. Contains 2Kg of food: Ration box (Chicken Boned)
	{
		consume = 50;
		water = -0.1;
		food = 1;
	};

	class vn_prop_food_can_01_01 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (Beefsteak)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_02 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (Spiced Sauce)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_03 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (Turkey Loaf)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_04 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (Ham, Fried)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_05 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (Ham and Eggs Chopped)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_06 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (Tuna)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_07 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (Chicken and Noodles)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_08 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (Chicken Boned)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_09 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (Pork Slices with Juices)
	{
		consume = 100;
		water = 0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_10 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (B-1A Unit Crackers and Candy)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_11 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (B-2 Unit Crackers and Cheese Spread)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_12 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (Pound Cake)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_13 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (Pecan Cake Roll)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_14 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (Chocolate Nut Roll)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_15 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (Fruitcake)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};
	class vn_prop_food_can_01_16 : vn_prop_food_meal_01 // Canned Rations. Contains 0.5Kg of food: Ration can (White Bread)
	{
		consume = 100;
		water = -0.1;
		food = 0.5;
	};

	class vn_prop_food_can_02_01 : vn_prop_food_meal_01 // Canned Rations. Contains 0.75Kg of food: Ration can (Beans w/ Meat Balls in Tomato Sauce)
	{
		consume = 100;
		water = -0.1;
		food = 0.75;
	};
	class vn_prop_food_can_02_02 : vn_prop_food_meal_01 // Canned Rations. Contains 0.75Kg of food: Ration can (Ham and Lima Beans)
	{
		consume = 100;
		water = -0.1;
		food = 0.75;
	};
	class vn_prop_food_can_02_03 : vn_prop_food_meal_01 // Canned Rations. Contains 0.75Kg of food: Ration can (Beans w/ Frankfurter Chunks in Tomato Sauce)
	{
		consume = 100;
		water = -0.1;
		food = 0.75;
	};
	class vn_prop_food_can_02_04 : vn_prop_food_meal_01 // Canned Rations. Contains 0.75Kg of food: Ration can (Spaghetti w/ Ground Meat)
	{
		consume = 100;
		water = -0.1;
		food = 0.75;
	};
	class vn_prop_food_can_02_05 : vn_prop_food_meal_01 // Canned Rations. Contains 0.75Kg of food: Ration can (B-3 Unit Cookies, Jam and Cocoa Beverage Powder)
	{
		consume = 100;
		water = -0.1;
		food = 0.65;
	};
	class vn_prop_food_can_02_06 : vn_prop_food_meal_01 // Canned Rations. Contains 0.75Kg of food: Ration can (Apricots)
	{
		consume = 100;
		water = 0.1;
		food = 0.25;
	};
	class vn_prop_food_can_02_07 : vn_prop_food_meal_01 // Canned Rations. Contains 0.75Kg of food: Ration can (Peaches)
	{
		consume = 100;
		water = 0.25;
		food = 1;
	};
	class vn_prop_food_can_02_08 : vn_prop_food_meal_01 // Canned Rations. Contains 0.75Kg of food: Ration can (Pears)
	{
		consume = 100;
		water = 0.1;
		food = 0.25;
	};
	class vn_prop_food_can_03_01 : vn_prop_food_meal_01 // Canned Rations. Contains 0.3Kg of food: Ration can (Peanut Butter)
	{
		consume = 100;
		water = -0.1;
		food = 0.1;
	};
	class vn_prop_food_can_03_02 : vn_prop_food_meal_01 // Canned Rations. Contains 0.3Kg of food: Ration can (Jam, Seedless Blackberry)
	{
		consume = 100;
		water = -0.1;
		food = 0.1;
	};
	class vn_prop_food_can_03_03 : vn_prop_food_meal_01 // Canned Rations. Contains 0.3Kg of food: Ration can (Pineapple Jam)
	{
		consume = 100;
		water = -0.1;
		food = 0.1;
	};
	class vn_prop_food_can_03_04 : vn_prop_food_meal_01 // Canned Rations. Contains 0.3Kg of food: Ration can (Cheese Spread)
	{
		consume = 100;
		water = -0.1;
		food = 0.1;
	};
	// fresh food
	class vn_prop_food_fresh_01  : vn_prop_food_meal_01  // Orange
	{
		consume = 100;
		water = 0.1;
		food = 0.1;
	};

	class vn_prop_food_fresh_02 : vn_prop_food_meal_01  // Pumpkin 3Kg
	{
		consume = 34;
		water = 0;
		food = 0.1;
	};
	class vn_prop_food_fresh_03 : vn_prop_food_meal_01 // Chicken 3Kg
	{
		consume = 34;
		water = 0;
		food = 0.1;
		attributes[] =
		{
			{"diarrhea", 0.5}, // diuretic, diarrhea
			// {"salmonellosis", 0.1}
		};
	};
	class vn_prop_food_fresh_04 : vn_prop_food_meal_01 // Shrimp 3Kg
	{
		consume = 34;
		water = 0;
		food = 0.1;
		attributes[] =
		{
			{"diarrhea", 0.1} // diuretic, diarrhea
		};
	};
	class vn_prop_food_fresh_05 : vn_prop_food_meal_01 // Fish 3Kg
	{
		consume = 34;
		water = 0;
		food = 0.1;
		attributes[] =
		{
			{"diarrhea", 0.01} // diuretic, diarrhea
		};
	};
	class vn_prop_food_fresh_06 : vn_prop_food_meal_01 // Pork 3Kg
	{
		consume = 34;
		water = 0;
		food = 0.1;
		attributes[] =
		{
			{"diarrhea", 0.5} // diuretic, diarrhea
		};
	};
	class vn_prop_food_fresh_07 : vn_prop_food_meal_01 // Snake 3Kg
	{
		consume = 34;
		water = 0;
		food = 0.1;
		attributes[] =
		{
			{"diarrhea", 0.5}, // diuretic, diarrhea
			{"poison", 0.5} // todo add effects
		};
	};
	class vn_prop_food_fresh_08 : vn_prop_food_meal_01 // Tiger 3Kg
	{
		consume = 34;
		water = 0;
		food = 0.1;
		attributes[] =
		{
			{"diarrhea", 0.5} // diuretic, diarrhea
		};
	};
	class vn_prop_food_fresh_09 : vn_prop_food_meal_01 // Elephant 3Kg
	{
		consume = 34;
		water = 0;
		food = 0.1;
		attributes[] =
		{
			{"diarrhea", 0.5} // diuretic, diarrhea
		};
	};
	class vn_prop_food_fresh_10 : vn_prop_food_meal_01 // Rau Ma 3Kg
	{
		consume = 34;
		water = 0;
		food = 0.1;
	};

	class vn_prop_food_lrrp_01_01 : vn_prop_food_meal_01 // LRRP Rations. Contains 1Kg of high energy food: LRRP ration (Beef Hash)
	{
		consume = 100;
		water = 0;
		food = 1;
	};
	class vn_prop_food_lrrp_01_02 : vn_prop_food_lrrp_01_01 {}; // LRRP Rations. Contains 1Kg of high energy food: LRRP ration (Chili Con Carne)
	class vn_prop_food_lrrp_01_03 : vn_prop_food_lrrp_01_01 {}; // LRRP Rations. Contains 1Kg of high energy food: LRRP ration (Spaghetti w/ Meat Sauce)
	class vn_prop_food_lrrp_01_04 : vn_prop_food_lrrp_01_01 {}; // LRRP Rations. Contains 1Kg of high energy food: LRRP ration (Beef and Rice)
	class vn_prop_food_lrrp_01_05 : vn_prop_food_lrrp_01_01 {}; // LRRP Rations. Contains 1Kg of high energy food: LRRP ration (Chicken Stew)
	class vn_prop_food_lrrp_01_06 : vn_prop_food_lrrp_01_01 {}; // LRRP Rations. Contains 1Kg of high energy food: LRRP ration (Pork w/ Escalloped Potatoes)
	class vn_prop_food_lrrp_01_07 : vn_prop_food_lrrp_01_01 {}; // LRRP Rations. Contains 1Kg of high energy food: LRRP ration (Beef Stew)
	class vn_prop_food_lrrp_01_08 : vn_prop_food_lrrp_01_01 {}; // LRRP Rations. Contains 1Kg of high energy food: LRRP ration (Chicken and Rice)

	// dry goods
	class vn_prop_food_sack_01 : vn_prop_food_meal_01 // Rice 1kg
	{
		consume = 16.67;
		water = -0.2;
		food = 0.1;
	};
	class vn_prop_food_sack_02  : vn_prop_food_sack_01 // Rice 4kg
	{
		consume = 4;
		water = -0.2;
		food = 0.1;
	};

	class FirstAidKit
	{
		interactActions[] =
		{
			// Test actions - requires the player to have a watch equipped for "Check Pulse" action to show on double click of the First Aid Kit.
			{"STR_vn_mf_check_pulse", "private _target = player; if (cursorTarget isKindof 'Man') then {_target = cursorTarget}; if ((damage _target) > 0.1) then { hintSilent format['%1 Needs Medical Attention!',name _target];} else {hintSilent format['%1, Does Not Need Medical Attention.',name _target];};", "!('ItemWatch' in (assignedItems player))", 1 , "hintSilent 'Watch Needed';" }
			// {"Debug 1", "hintSilent str[_thisItem,_thisItemType];" },
		};
	};
};
