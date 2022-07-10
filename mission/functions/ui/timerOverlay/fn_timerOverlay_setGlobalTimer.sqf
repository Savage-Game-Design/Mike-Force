/*
	File: fn_timerOverlay_setGlobalTimer.sqf
	Author: Savage Game Design
	Public: Yes
	
	Description:
		Sets a on-screen timer using setTimer, globally, JIP'd
	
	Parameter(s):
		_title - Timer title [String]
		_time - Timer duration, or expiry time [Number]
		_isCountdown - Is timer a countdown timer (Optional, default false) [Boolean]
	
	Returns:
		None
	
	Example(s):
		[
			"Hit",
			40
		] call VN_MF_fnc_timerOverlay_setGlobalTimer;
*/

_this remoteExec ["vn_mf_fnc_timerOverlay_setTimer", 0, "TIMER"];