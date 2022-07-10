/*
    File: fn_sites_aa_reveal_targets.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
        Starts and runs a loop to transmit player controlled aircraft to AA sites.
    
    Parameter(s):
        None
    
    Returns:
        None
    
    Example(s):
        [] call vn_mf_fnc_sites_aa_reveal_targets
*/

vn_mf_fnc_nearest_obj = {
  private _a = _this # 1 apply {[_x distance2D _this # 0, _x]};
  _a sort true;
  _a pushBack [nil, objNull];
  _a # 0 # 1
};

["sites_aa_reveal_targets", {
    { // forEach looping over AA sites
        { // forEach looping over AA guns
			private _gunner = gunner _x;
			if (!isNull _gunner) then {
				private _nearestAircraft = [getPos _x, getPos _x nearEntities ["air", 1500] select {alive _x && !(crew _x isEqualTo [])}] call vn_mf_fnc_nearest_obj;
				[_gunner, [_nearestAircraft, 3]] remoteExec ["reveal", _gunner];
				_gunner disableAI "AUTOTARGET";
				[_gunner, _nearestAircraft] remoteExec ["doTarget", _gunner];
				_gunner setSkill 1;
			};
        } forEach (_x getVariable ["aaGuns",[]]);
    } forEach (missionNamespace getVariable ["sites_aa", []]);
}, [], 3] call para_g_fnc_scheduler_add_job