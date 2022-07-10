/*
    File: fn_timerOverlay_removeGlobalTimer.sqf
    Author: Savage Game Design
    Public: Yes
    
    Description:
		Removes a global timer, in the same way `removeTimer` removes a local timer.
    
    Parameter(s):
		None

    Returns:
		None
    
    Example(s):
		[] call vn_mf_fnc_timerOverlay_removeGlobalTimer
*/

[] remoteExec ["vn_mf_fnc_timerOverlay_removeTimer", 0];
remoteExec ["", "TIMER"];