/*
	File: fn_create_support_default.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Default support task creation script. Creates the support task with no additional checks.

	Parameter(s):
		_taskClass - Task class [String]
		_requestingPlayer - Requesting player [Object]
		_coords - Task Coordinates [Position]
		_targetTeam - Targeted team [Group]

	Returns: nothing

	Example(s):
		Not directly called.
*/

params ["_taskClass", "_requestingPlayer", "_coords", "_targetTeam"];

["TaskCreated", ["", "STR_vn_mf_notification_desc_support_task_created"]] call para_c_fnc_show_notification;

[
  _taskClass,
  "",
  [
	["supportRequestPos", _coords],
	["supportRequestPlayer", _requestingPlayer]
  ],
  _requestingPlayer getVariable ["vn_mf_db_player_group", "FAILED"],
  [_targetTeam]
] call vn_mf_fnc_task_create;