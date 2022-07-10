/*
	File: fn_init_comms.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Sets up the appropriate communications suite for the mission.

	Parameter(s): none

	Returns: nothing

	Example(s):
		Not called directly
*/

// Run only for tfar legacy. Tfar beta uses CBA settings file.
if (!isClass (configFile >> "CfgPatches" >> "tfar_core") && isClass (configFile >> "CfgPatches" >> "task_force_radio")) exitWith {
	["TFAR: Beginning Initialisation"] call BIS_fnc_log;
	//Wait until ServerInit has done from TFAR, so we don't set these overrides too soon.
	waitUntil {sleep 0.1; !isNil "TF_Radio_Count"};

	["TFAR: Detected TFAR Initialised, setting overrides"] call BIS_fnc_log;

	tf_radio_channel_name = getText (missionConfigFile >> "TFAR" >> "radio_channel_name"); publicVariable "tf_radio_channel_name";
	tf_radio_channel_password = getText (missionConfigFile >> "TFAR" >> "radio_channel_password"); publicVariable "tf_radio_channel_password";

	tf_no_auto_long_range_radio_server = true;
	publicVariable "tf_no_auto_long_range_radio_server";
	tf_no_auto_long_range_radio = tf_no_auto_long_range_radio_server;
	publicVariable "tf_no_auto_long_range_radio";
	tf_give_personal_radio_to_regular_soldier_server = false;
	publicVariable "tf_give_personal_radio_to_regular_soldier_server";
	tf_give_personal_radio_to_regular_soldier = tf_give_personal_radio_to_regular_soldier_server;
	publicVariable "tf_give_personal_radio_to_regular_soldier";

	tf_same_sw_frequencies_for_side_server = true;
	publicVariable "tf_same_sw_frequencies_for_side_server";
	tf_same_sw_frequencies_for_side = tf_same_sw_frequencies_for_side_server;
	publicVariable "tf_same_sw_frequencies_for_side";
	tf_same_lr_frequencies_for_side_server = true;
	publicVariable "tf_same_lr_frequencies_for_side_server";
	tf_same_lr_frequencies_for_side = tf_same_lr_frequencies_for_side_server;
	publicVariable "tf_same_lr_frequencies_for_side";
	tf_same_dd_frequencies_for_side_server = true;
	publicVariable "tf_same_dd_frequencies_for_side_server";
	tf_same_dd_frequencies_for_side = tf_same_dd_frequencies_for_side_serveR;
	publicVariable "tf_same_dd_frequencies_for_side";

	tf_freq_west = call TFAR_fnc_generateSwSettings;
	tf_freq_west_lr = call TFAR_fnc_generateLrSettings;

	tf_freq_west set [2, ["61.1", "61.2", "61.3", "61.4", "61.5", "61.6", "61.7", "61.8","61.9"]];
	tf_freq_west_lr set [2, ["84.1", "84.2", "84.3", "84.4", "84.5", "84.6", "84.7", "84.8","84.9"]];
	tf_freq_west_dd = "38.4";

	publicVariable "tf_freq_west";
	publicVariable "tf_freq_west_lr";
	publicVariable "tf_freq_west_dd";

	{
		_x setVariable ["tf_sw_frequency", tf_freq_west, true];
		_x setVariable ["tf_lr_frequency", tf_freq_west_lr, true];
		_x setVariable ["tf_dd_frequency", tf_freq_west_dd, true];
	} forEach (allGroups select {side _x == west});

	TF_defaultWestBackpack = "";
	publicVariable "TF_defaultWestBackpack";
	TF_defaultWestAirborneBackpack = "";
	publicVariable "TF_defaultWestAirborneBackpack";
	TF_defaultWestPersonalRadio = "";
	publicVariable "TF_defaultWestPersonalRadio";

	TF_defaultEastBackpack = "";
	publicVariable "TF_defaultEastBackpack";
	TF_defaultEastAirborneBackpack = "";
	publicVariable "TF_defaultEastAirborneBackpack";
	TF_defaultEastPersonalRadio = "";
	publicVariable "TF_defaultEastPersonalRadio";

	TF_defaultGuerBackpack = "";
	publicVariable "TF_defaultGuerBackpack";
	TF_defaultGuerAirborneBackpack = "";
	publicVariable "TF_defaultGuerAirborneBackpack";
	TF_defaultGuerPersonalRadio = "";
	publicVariable "TF_defaultGuerPersonalRadio";
};
if (isClass (configFile >> "CfgPatches" >> "tfar_core") && !isClass (configFile >> "CfgPatches" >> "task_force_radio")) exitWith {
	["TFAR: Beginning Initialisation"] call BIS_fnc_log;
};
if (isClass (configFile >> "CfgPatches" >> "acre_main")) exitWith {
	["ACRE2: Beginning Initialisation"] call BIS_fnc_log;
	[false, false] call acre_api_fnc_setupMission;
};
