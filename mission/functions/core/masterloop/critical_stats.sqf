/*
    File: critical_stats.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Updates the critical stats HUD (Thirst/Hunger/...)
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

private _config = (missionConfigFile >> "gamemode" >> "health");
private _stats = getArray(_config >> "gui_progress_bars");
private _states = getArray(_config >> "gui_state_indicators");
{
	_x params ["_name", "_color"];

	private _ctrl = uiNamespace getVariable [format["vn_mf_db_%1_ctrl",_name],controlNull];
	if !(isNull _ctrl) then
	{
		_var = player getVariable [format["vn_mf_db_%1",_name], 1];

		private _pbgControl = uiNamespace getVariable [format ["#VN_MF_HngerThirstHUD_ProgressBackground_%1", _forEachIndex], controlNull];
		if (_var <= 0.25) then
		{
			_pbgControl ctrlSetBackgroundColor [1, 0, 0, 0.25];
			_pbgControl ctrlCommit 0;
			// Hungry or Thirsty, hit that tutorial card
			["gotHungryThirsty", [player, []]] call para_g_fnc_event_dispatch;
			[_ctrl,_color] spawn {
				params ["_ctrl","_color"];
				_ctrl ctrlSetTextColor [1,0,0,0.5];
				uiSleep 0.5;
				_ctrl ctrlSetTextColor _color;
				uiSleep 0.5;
				_ctrl ctrlSetTextColor [1,0,0,0.5];
				uiSleep 0.5;
				_ctrl ctrlSetTextColor _color;
			};
		} else {
			_pbgControl ctrlSetBackgroundColor [1, 1, 1, 0.5];
			_pbgControl ctrlCommit 0;
		};
	};
} forEach _stats;

private _attributes = player getVariable "vn_mf_db_attributes";
// TODO Add state icons showing what attributes are in effect. 
if (!isNil "_attributes") then {
	{
		_x params ["_name", "_icon"];
		private _ctrl = uiNamespace getVariable [format ["#VN_MF_attributes_status_icon_%1", _name], controlNull];

		if (_name in _attributes) then {
			_ctrl ctrlShow true;
		} 
		else
		{
			_ctrl ctrlShow false;
		};
	}forEach _states;
};
