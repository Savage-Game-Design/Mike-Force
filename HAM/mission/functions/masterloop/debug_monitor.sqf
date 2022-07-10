/*
    File: debug_monitor.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Call the debug montiro function if the debug monitor is not enabled
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s): none
*/

if !(isNil "vn_mf_enable_debug_monitor") then
{
	call vn_mf_fnc_debug_monitor;
};
