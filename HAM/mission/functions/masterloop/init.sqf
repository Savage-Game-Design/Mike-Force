/*
    File: init.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Initializes variables.
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

private _lastDebugMonitor = diag_tickTime;
private _lastCursorTarget = diag_tickTime;

private _lastBuildState = 0;

private _config = (missionConfigFile >> "gamemode");
private _buildables_config = (_config >> "buildables");

private _action_id = -1;
private _action_id_pt = -1;

vn_mf_cursor_object_pt = objNull;
vn_mf_cursor_object = objNull;
