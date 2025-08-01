/*
    File: fn_garage_create_ui_callback.sqf
    Author: Spoffy
    Date: 2023-05-19
    Last Update: 2023-05-19
    Public: No
    
    Description:
		Helper function for creating ctrl and display callbacks in the arsenal and garage.
    
    Parameter(s):
        _params - Parameters to pass to the function, as a string [STRING]
        _funcName - Function name, as a string [STRING]
        _namespace - Namespace, default uiNamespace [STRING]
        _callType - 'call' or 'spawn' as a string [STRING]
    
    Returns:
        String of code for ctrlAddEventHandler or displayaddeventhandler [STRING]
    
    Example(s):
        ["['My test']", 'vn_mf_func', 'uiNamespace', 'spawn'] call vn_mf_fnc_garage_create_ui_callback;
*/

params [["_params", "[]", [""]], ["_funcName", "''", [""]], ["_namespace", 'uiNamespace', [""]], ["_callType", 'call', [""]]];

format ["with %1 do { %2 %3 (missionNamespace getVariable '%4') }", _namespace, _params, _callType, _funcName]