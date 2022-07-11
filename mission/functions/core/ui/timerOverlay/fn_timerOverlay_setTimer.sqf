/*
	File: fn_timerOverlay_setTimer.sqf
	Author: Savage Game Design
	Public: Yes
	
	Description:
		Shows a timer on the user's screen. Can be of a fixed duration, or a countdown timer.
	
	Parameter(s):
		_title - Timer title [String]
		_time - Timer duration, or expiry time [Number]
		_isCountdown - Is timer a countdown timer (Optional, default false) [Boolean]
	
	Returns:
		True if the timer has been initalized, false if a timer is already running [Boolean]
	
	Example(s):
		[
			"Hit",
			40
		] call VN_MF_fnc_timerOverlay_setTimer;
*/
params ["_title", "_time", ["_isCountdown", false]];

uiNamespace setVariable ["#VN_TimerOverlay_EndTime", if (_isCountdown) then {_time} else {serverTime + _time}];

if (scriptDone (missionNamespace getVariable ["#VN_MF_TimerManager", scriptNull])) then {

	private _manager = _this spawn {
		params [
			"_title"
		];

		private _holder = uiNamespace getVariable ['#VN_MF_TimerOverlay_Holder', controlNull];
		if (_holder isEqualTo controlNull) then {
			"VN_TimerOverlay" cutRsc ["VN_TimerOverlay", "PLAIN", -1, false];
			waitUntil {
				!((uiNamespace getVariable ['#VN_MF_TimerOverlay_Holder', controlNull]) isEqualTo controlNull)
			};
		};

		private _titleControl = uiNamespace getVariable ['#VN_MF_TimerOverlay_Title', controlNull];
		_titleControl ctrlSetText _title;

		call VN_MF_fnc_timerOverlay_showTimer;
		private _timeControl = uiNamespace getVariable ['#VN_MF_TimerOverlay_Message', controlNull];

		// for "_i" from _time to 0 step -1 do {
		// 	_timeControl ctrlSetText format ["%1 remaining", [_i,"MM:SS",false] call BIS_fnc_secondstoString];
		// 	uiSleep 1;
		// };

		private _endTime = 1e39;
		while {serverTime < _endTime} do {
			_endTime = uiNamespace getVariable ["#VN_TimerOverlay_EndTime", serverTime];
			_timeControl ctrlSetText format ["%1 minutes remaining", round ((_endTime - serverTime) / 60)];
			uiSleep 30;
		};

		call VN_MF_fnc_timerOverlay_hideTimer;
	};

	missionNamespace setVariable ["#VN_MF_TimerManager", _manager];
};

true