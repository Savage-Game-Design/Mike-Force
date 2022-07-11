/*
    File: fn_enable_debug_monitor.sqf
    Author: Savage Game Design
    Public: No

    Description:
	    Enables/disables debug monitor.

    Parameter(s): none

    Returns: nothing

    Example(s):
	    call vn_mf_fnc_enable_debug_monitor
*/

if (isNil "vn_mf_enable_debug_monitor") then
{
	vn_mf_enable_debug_monitor = true;
}
else
{
	vn_mf_enable_debug_monitor = nil;
	hintSilent "Debug Monitor: disabled";
};
false