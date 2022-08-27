private _rootCfg = missionConfigFile >> "CfgFunctions" >> "vn_mf" >> "TaskRoster";
private _configs = configProperties [
  _rootCfg,
  "('tr_requests' in (configName _x)) && ((configName _x) isNotEqualTo 'tr_requests_debug_recompile')",
  false
];

private _functions = _configs apply {
  format ["vn_mf_fnc_%1", configName _x]
};

{
  [_x, 5] call BIS_fnc_recompile;
} forEach _functions;

_functions