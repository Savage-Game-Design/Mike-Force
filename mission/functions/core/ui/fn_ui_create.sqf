/*
    File: fn_ui_create.sqf
    Author: Savage Game Design
    Public: No

    Description:
	Initialize player stats progress bars and interaction overlay.

    Parameter(s):
	NA

    Returns:
    	NOTHING

    Example(s):
	0 spawn vn_mf_fnc_ui_create;
*/

#include "..\..\..\config\ui\ui_def_base.inc"
disableSerialization;

waitUntil { uiSleep 0.1; !isNull (findDisplay 46) };

// Initializes the interactionOverlay
private _intHudInitalized = call para_c_fnc_interactionOverlay_init;
private _kbmId = call para_c_fnc_initEscapeMenu;
private _ntfId = call para_c_fnc_notificationInit;

// init new empty display
"vn_mf_healthGUILayer" cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
private _display = uiNamespace getVariable "RscTitleDisplayEmpty";
private _ctrlBasePosition = [safeZoneX + safezoneW - UIW(9.5), safeZoneY + safezoneH - UIH(10), UIW(9.5), UIH(1)];
private _config = (missionConfigFile >> "gamemode" >> "health");
private _stats = getArray(_config >> "gui_progress_bars");
private _states = getArray(_config >> "gui_state_indicators");

/* Ratios */
private _gutterRatio = 0.1;
private _progressHeightRatio = 0.3; // Percentage based on the iconSize

private _gutterWidth = (_ctrlBasePosition#3) * _gutterRatio;
private _gutterHeight = _gutterWidth * (4 / 3);
private _heightMultiplier = 0;

{
	_x params ["_name", "_color"];

	_ctrlBasePosition set [1, (_ctrlBasePosition#1) + (_ctrlBasePosition#3) * _forEachIndex];
	_ctrlBasePosition params ["_staminaX", "_staminaY", "_staminaW", "_staminaH"];

	/* Background */
	private _bgControl = _display ctrlCreate ["IGUIBack", -1];
	private _bgPosition = _ctrlBasePosition;
	_bgControl ctrlSetPosition _bgPosition;
	_bgControl ctrlCommit 0;

	/* Icon */
	private _iconControl = _display ctrlCreate ["vn_mf_RscPicture", -1];
	private _iconSize = _staminaH * (1 - _gutterRatio * 2);
	private _iconPosition = [_staminaX + _gutterWidth, _staminaY + _gutterHeight, _iconSize * (3 / 4), _iconSize];
	private _icon = format ["\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_hud_%1_ca.paa", _name];
	_iconControl ctrlSetPosition _iconPosition;
	_iconControl ctrlSetText _icon;
	_iconControl ctrlCommit 0;

	/* Progress Shared */
	private _progressWidth = _staminaW - (_iconSize * (3 / 4)) - _gutterWidth * 5;
	private _progressHeight = _iconSize * _progressHeightRatio;
	private _progressPosition = [
		_staminaX + (_iconSize * (3 / 4)) + _gutterWidth * 3,
		_staminaY + _gutterHeight + (_staminaH - _gutterHeight * 2 - _progressHeight) / 2,
		_progressWidth,
		_progressHeight
	];

	/* Progress Background */
	private _pbgControl = _display ctrlCreate ["IGUIBack", -1];
	uiNamespace setVariable [format ["#VN_MF_HngerThirstHUD_ProgressBackground_%1", _forEachIndex], _pbgControl];
	// missionNamespace setVariable ["#VN_MF_HngerThirstHUD_ProgressBackground", _pbgControl];
	_pbgControl ctrlSetPosition _progressPosition;
	_pbgControl ctrlSetBackgroundColor [1, 1, 1, 0.5];
	_pbgControl ctrlCommit 0;

	/* Progress Bar */
	private _pControl = _display ctrlCreate ["vn_mf_RscStatProgressHUD", -1];
	uiNamespace setVariable [format["vn_mf_db_%1_ctrl",_name], _pControl];
	_pControl ctrlSetPosition _progressPosition;
	_pControl ctrlSetTextColor _color;
	_pControl ctrlCommit 0;
	_pControl progressSetPosition (player getVariable [format["vn_mf_db_%1",_name], 0.5]);
	_heightMultiplier = _forEachIndex;
} forEach _stats;

_ctrlBasePosition set [1, (_ctrlBasePosition#1) + (_ctrlBasePosition#3) * (_heightMultiplier)];
private _newCtrlXOrigin = (_ctrlBasePosition#0) + UIW(7.5);
{
	_x params ["_name", "_icon"];

	_ctrlBasePosition set [2, UIW(2)];
	_ctrlBasePosition set [3, UIH(2)];
	_ctrlBasePosition set [0, _newCtrlXOrigin - ((_ctrlBasePosition#2) * (_forEachIndex))];
	_ctrlBasePosition params ["_staminaX", "_staminaY", "_staminaW", "_staminaH"];

	/* Icon */
	private _iconControl = _display ctrlCreate ["vn_mf_RscPicture", -1];
	private _iconSize = _staminaH * (1 - _gutterRatio * 2);
	private _iconPosition = [_staminaX + _gutterWidth, _staminaY + _gutterHeight, _iconSize * (3 / 4), _iconSize];
	uiNamespace setVariable [format ["#VN_MF_attributes_status_icon_%1", _name], _iconControl];
	_iconControl ctrlSetPosition _iconPosition;
	_iconControl ctrlSetText _icon;
	_iconControl ctrlShow false;
	_iconControl ctrlCommit 0;


} forEach _states;