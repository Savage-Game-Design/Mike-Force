/*
    File: fn_log_performance_data.sqf
    Author: Savage Game Design
    Public: No

    Description:
    Logs a line of performance data

    Parameter(s): None

    Returns: Nothing

    Example(s):
		call vn_mf_fnc_init_performance_logging
*/

private _allUnits = allUnits;
private _deadUnitCount = {!alive _x} count _allUnits;
private _enemyUnitCount = {side _x == east} count _allUnits;
private _vehicleCount = count vehicles;
private _groups = allGroups;
private _groupsWestCount = {side _x == west} count _groups;
private _groupsEast = _groups select {side _x == east};
private _combatGroupCount = {combatBehaviour _x == "COMBAT"} count _groupsEast;


private _message = format [
  "ServerFPS:%1, Players:%2, DeadUnits:%3, EnemyUnits:%4, AllUnits:%5, AllVehicles:%6, GroupsWest:%7, GroupsEast:%8, GroupsTotal:%9, EnemyGroupsCombatBehaviour:%10",
  diag_fps,
  count allPlayers,
  _deadUnitCount,
  _enemyUnitCount,
  count _allUnits,
  _vehicleCount,
  _groupsWestCount,
  count _groupsEast,
  count _groups,
  _combatGroupCount
];

["INFO", _message] call para_g_fnc_log;