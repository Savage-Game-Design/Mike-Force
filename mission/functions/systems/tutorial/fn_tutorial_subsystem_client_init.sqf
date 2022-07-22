/*
    File: fn_tutorial_subsystem_client_init.sqf
    Author: Gus Schultz
    Date: 2022-06-04
    Last Update: 
    Public: Yes
    
    Description:
        Starts the client portion of the tutorial subsystem.
    
    Parameter(s):
        None
    
    Returns:
        None
    
    Example(s):
        [] call vn_mf_fnc_tutorial_subsystem_client_init


		player setVariable ["vn_mf_db_seenIntro", false];
		player setVariable ["vn_mf_db_playedACAV", false];
		player setVariable ["vn_mf_db_playedGH", false];
		player setVariable ["vn_mf_db_playedMF", false];
		player setVariable ["vn_mf_db_playedEng", false];
		player setVariable ["vn_mf_db_playedRTO", false];
		player setVariable ["vn_mf_db_gotHungOrThir", false];
		player setVariable ["vn_mf_db_placedBuilding", false];
		player setVariable ["vn_mf_db_enteredWheelMenu", false];
		player setVariable ["vn_mf_db_AddPackageWreck", false];
		player setVariable ["vn_mf_db_GotInVehicle", false];
		player setVariable ["vn_mf_db_RespawnedAtCheckpoint", false];
		player setVariable ["vn_mf_db_wasIncapacitated", false];
		player setVariavle ["vn_mf_db_hasLookedAtLogVeh", false];

		[] call vn_mf_fnc_tutorial_subsystem_client_init;

*/

private _tutorialEnabled = ["para_enableTutorial"] call para_c_fnc_optionsMenu_getValue;

// Early exit if the tutorial is disabled
if (!_tutorialEnabled) exitWith {
	//systemChat "Tutorial Disabled";
	false;
};

[] call para_c_fnc_ui_hints_setup;

// This doesn't use the event system because client init is the event we need and thats where this script is called from.
private _seenIntro = player getVariable ["vn_mf_db_seenIntro", false];
if (!_seenIntro) then {
	["Overview", "Tutorial"] call para_c_fnc_ui_hints_show_hint;
	["Overview", "Task_Roster"] call para_c_fnc_ui_hints_show_hint;
	["Deployment", "Duty_Officer"] call para_c_fnc_ui_hints_show_hint;
	["Overview", "Gearing_Up"] call para_c_fnc_ui_hints_show_hint;
	["Overview", "Fast_Travel"] call para_c_fnc_ui_hints_show_hint;
	player setVariable ["vn_mf_db_seenIntro", true];
};

// Team Switching Tutorials
["changedTeams", [{
		params ["_handlerParams", "_eventParams"];
		_handlerParams params [];
		_eventParams params ["_player", "_groupID"];
		private _playedACAV = _player getVariable ["vn_mf_db_playedACAV", false];
		private _playedGH = _player getVariable ["vn_mf_db_playedGH", false];
		private _playedMF = _player getVariable ["vn_mf_db_playedMF", false];
		switch (_groupID) do {
			case "ACAV": {
				if (!_playedACAV) then {
				["Team", "ACAV"] call para_c_fnc_ui_hints_show_hint;
				["Logistics", "Supplies"] call para_c_fnc_ui_hints_show_hint;
				_player setVariable ["vn_mf_db_playedACAV", true];
				};
			};
			case "GreenHornets": {
				if (!_playedGH) then {
				["Team", "Green_Hornets"] call para_c_fnc_ui_hints_show_hint;
				["Logistics", "Supplies"] call para_c_fnc_ui_hints_show_hint;
				_player setVariable ["vn_mf_db_playedGH", true];
				};
			};
			case "MikeForce": {
				if (!_playedMF) then {
				["Team", "Mike_Force"] call para_c_fnc_ui_hints_show_hint;
				_player setVariable ["vn_mf_db_playedMF", true];
				};
			};
		};
		if (_playedACAV && _playedGH && _playedMF) then {
			private _handler = _currentEventHandler;
			["changedTeams", _handler] call para_g_fnc_event_remove_handler;
		};

		// Call Example: ["changedTeams", [player, vn_tr_groupID]] call para_g_fnc_event_dispatch;
		// Currently called from: ./mission/functions/ui/taskroster/fn_tr_selectTeam_set.sqf

	}, []]] call para_g_fnc_event_add_handler;

["tookTraining", [{
		params ["_handlerParams", "_eventParams"];
		_handlerParams params [];
		_eventParams params ["_player", "_training"];
		private _playedEng = _player getVariable ["vn_mf_db_playedEng", false];
		private _playedRTO = _player getVariable ["vn_mf_db_playedRTO", false];
		switch (_training) do {
			case "engineer": {
				if (!_playedEng) then {
					["Building", "Construction"] call para_c_fnc_ui_hints_show_hint;
					_player setVariable ["vn_mf_db_playedEng", true];
				};
			};
			case "vn_artillery": {
				if (!_playedRTO) then {
					["Artillery", "RTO"] call para_c_fnc_ui_hints_show_hint;
					_player setVariable ["vn_mf_db_playedRTO", true];
				};
			};
			// Add more cases if we need to for other training types
		};

		// Add cases as needed so that if all cases in switch have been shown we remove the handler.				
		if (_playedEng && _playedRTO) then {
			private _handler = _currentEventHandler;
			["tookTraining", _handler] call para_g_fnc_event_remove_handler;
		};

		// Call Example: ["tookTraining", [player, trait]] call para_g_fnc_event_dispatch;
		// Currently called from: ./mission/functions/rehandler/fn_settrait.sqf

	}, []]] call para_g_fnc_event_add_handler;

["gotHungryThirsty", [{
		params ["_handlerParams", "_eventParams"];
		_handlerParams params [];
		_eventParams params ["_player", "_trash"];
		private _gotHungOrThir = _player getVariable ["vn_mf_db_gotHungOrThir", false];
		if (!_gotHungOrThir) then {
			["Gameplay", "Needs"] call para_c_fnc_ui_hints_show_hint;
			_player setVariable ["vn_mf_db_gotHungOrThir", true];
		};
		if (_gotHungOrThir) then  {
			private _handler = _currentEventHandler;
			["gotHungryThirsty", _handler] call para_g_fnc_event_remove_handler;
		};

		// Call Example: ["gotHungryThirsty", [player, []]] call para_g_fnc_event_dispatch;
		// Currently called from: ./mission/functions/masterloop/critical_stats.sqf

	}, []]] call para_g_fnc_event_add_handler;


["placedBuilding", [{
		params ["_handlerParams", "_eventParams"];
		_handlerParams params [];
		_eventParams params ["_player", "_trash"];
		private _placedBuilding = _player getVariable ["vn_mf_db_placedBuilding", false];
		if (!_placedBuilding) then {
			["Building", "Finishing"] call para_c_fnc_ui_hints_show_hint;
			_player setVariable ["vn_mf_db_placedBuilding", true];
		};
		if (_placedBuilding) then {
			private _handler = _currentEventHandler;
			["placedBuilding", _handler] call para_g_fnc_event_remove_handler;
		};

		// Call Example: ["placedBuilding", [player, []]] call para_g_fnc_event_dispatch;
		// Currently called from: PARADIGM//client/functions/basebuilding/fn_place_object.sqf

	}, []]] call para_g_fnc_event_add_handler;

["enteredWheelMenu", [{
	params ["_handlerParams", "_eventParams"];
	_handlerParams params [];
	_eventParams params ["_player", "_target"];
	
	private _buildingWheelMenu = _player getVariable ["vn_mf_db_buildingWheelMenu", false];

	if (!_buildingWheelMenu && !isNull (_target getVariable ["para_g_building", objNull])) then {
		["Building", "Resupplying"] call para_c_fnc_ui_hints_show_hint;
		_player setVariable ["vn_mf_db_buildingWheelMenu", true];
	};

	
	if (_buildingWheelMenu) then  {
		private _handler = _currentEventHandler;
		["enteredWheelMenu", _handler] call para_g_fnc_event_remove_handler;
	};
	
	// Call Example: ["enteredWheelMenu", [player, []]] call para_g_fnc_event_dispatch;
	// Currently called from: PARADIGM//client/functions/ui/wheel_menu/fn_wheel_menu_open_with_configured_actions.sqf
	
}, []]] call para_g_fnc_event_add_handler;

["AddPackageWreck", [{
	params ["_handlerParams", "_eventParams"];
	_handlerParams params [];
	_eventParams params ["_player", "_trash"];
	private _AddPackageWreck = _player getVariable ["vn_mf_db_AddPackageWreck", false];
	if (!_AddPackageWreck) then {
		["Logistics", "Wrecks"] call para_c_fnc_ui_hints_show_hint;
		_player setVariable ["vn_mf_db_AddPackageWreck", true];
	};
	if (_AddPackageWreck) then  {
		private _handler = _currentEventHandler;
		["AddPackageWreck", _handler] call para_g_fnc_event_remove_handler;
	};
	
	// Call Example: ["AddPackageWreck", [player, []]] call para_g_fnc_event_dispatch;
	// Currently called from: mission/functions/game/subsystem/vehicle_asset_manager/fn_veh_asset_add_package_wreck_action_local.sqf
	
}, []]] call para_g_fnc_event_add_handler;

["GotInVehicle", [{
	params ["_handlerParams", "_eventParams"];
	_handlerParams params [];
	_eventParams params ["_player", "_role"];
	private _GotInVehicle = _player getVariable ["vn_mf_db_GotInVehicle", false];
	if (!_GotInVehicle && _role == "driver") then {
		["Module", "Master_arm"] call para_c_fnc_ui_hints_show_hint;
		_player setVariable ["vn_mf_db_GotInVehicle", true];
	};
	if (_GotInVehicle) then  {
		private _handler = _currentEventHandler;
		["GotInVehicle", _handler] call para_g_fnc_event_remove_handler;
	};
	
	// Call Example: ["GotInVehicle", [player, role]] call para_g_fnc_event_dispatch;
	// Currently called from:This file with new event handler
	
}, []]] call para_g_fnc_event_add_handler;

["RespawnedAtCheckpoint", [{
	params ["_handlerParams", "_eventParams"];
	_handlerParams params [];
	_eventParams params ["_player", "_trash"];
	private _RespawnedAtCheckpoint = _player getVariable ["vn_mf_db_RespawnedAtCheckpoint", false];
	if (!_RespawnedAtCheckpoint) then {
		["Building", "Checkpoint"] call para_c_fnc_ui_hints_show_hint;
		_player setVariable ["vn_mf_db_RespawnedAtCheckpoint", true];
	};
	if (_RespawnedAtCheckpoint) then  {
		private _handler = _currentEventHandler;
		["RespawnedAtCheckpoint", _handler] call para_g_fnc_event_remove_handler;
	};
	
	// Call Example: ["RespawnedAtCheckpoint", [player, []]] call para_g_fnc_event_dispatch;
	// Currently called from: PARADIGM//server/functions/building_features_respawn/fn_bf_respawn_register_respawn.sqf
	
}, []]] call para_g_fnc_event_add_handler;

["wasIncapacitated", [{
	params ["_handlerParams", "_eventParams"];
	_handlerParams params [];
	_eventParams params ["_player", "_trash"];
	private _wasIncapacitated = _player getVariable ["vn_mf_db_wasIncapacitated", false];
	if (!_wasIncapacitated) then {
		["Module", "Downed"] call para_c_fnc_ui_hints_show_hint;
		_player setVariable ["vn_mf_db_wasIncapacitated", true];
	};
	if (_wasIncapacitated) then  {
		private _handler = _currentEventHandler;
		["wasIncapacitated", _handler] call para_g_fnc_event_remove_handler;
	};
	
	// Call Example: ["wasIncapacitated", [player, []]] call para_g_fnFc_event_dispatch;
	// Currently called from: This file in a new event handler.
	
}, []]] call para_g_fnc_event_add_handler;

["hasLookedAtLogVeh", [{
	params ["_handlerParams", "_eventParams"];
	_handlerParams params [];
	_eventParams params ["_player", "_trash"];
	private _hasLookedAtLogVeh = _player getVariable ["vn_mf_db_hasLookedAtLogVeh", false];
	if (!_hasLookedAtLogVeh) then {
		["Gameplay", "Logistics"] call para_c_fnc_ui_hints_show_hint;
		_player setVariable ["vn_mf_db_hasLookedAtLogVeh", true];
	};
	if (_hasLookedAtLogVeh) then  {
		private _handler = _currentEventHandler;
		["hasLookedAtLogVeh", _handler] call para_g_fnc_event_remove_handler;
		["checkLookedAtLogVeh"] call para_g_fnc_scheduler_remove_job;
	};
	
	// Call Example: ["hasLookedAtLogVeh", [player, []]] call para_g_fnc_event_dispatch;
	// Currently called from: this file
	
}, []]] call para_g_fnc_event_add_handler;

player addEventHandler ["GetInMan", {
	if (player getVariable ["vn_mf_db_GotInVehicle", false]) then {
		player removeEventHandler ["GetInMan", _thisEventHandler];		
	};
	params ["_unit", "_role", "_vehicle", "_turret"];
	["GotInVehicle", [_unit, _role]] call para_g_fnc_event_dispatch;
	player removeEventHandler ["GetInMan", _thisEventHandler];
}];

player addEventHandler ["AnimStateChanged" , {
	if (player getVariable ["vn_mf_db_wasIncapacitated", false]) then {
		player removeEventHandler ["AnimStateChanged", _thisEventHandler];
	};
	if (player getVariable ["vn_revive_incapacitated", false] || lifeState player == "INCAPCITATED") then {
		["wasIncapacitated", [player, []]] call para_g_fnc_event_dispatch;
		player removeEventHandler ["AnimStateChanged", _thisEventHandler];
	};
}];


["checkLookedAtLogVeh", {
	if (player getVariable ["vn_mf_db_hasLookedAtLogVeh", false]) then {
		["checkLookedAtLogVeh"] call para_g_fnc_scheduler_remove_job;
	};
	private _cursorobject = cursorTarget;
	//if (!isNull _cursorobject && (tolower typeof _cursorobject) in vn_log_vehicle_list) then {
	if ((!isNull _cursorobject && (tolower typeof _cursorobject) in vn_log_vehicle_list) || ((cursorTarget distance player) < 5.5 && {alive cursorTarget && {vehicle player isEqualTo player && {crew cursorTarget isEqualTo [] && {vn_log_item_list findIf {_x == typeof cursorTarget} > -1 && {!vn_log_moving_object}}}}})) then {
		["hasLookedAtLogVeh", [player, []]] call para_g_fnc_event_dispatch;
	}; 
}, [], 10] call para_g_fnc_scheduler_add_job;

true