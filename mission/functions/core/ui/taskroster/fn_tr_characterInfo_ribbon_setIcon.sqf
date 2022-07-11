/*
    File: fn_tr_characterInfo_ribbon_setIcon.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Called by clicking on the Ribbon control.
		Updates the Ribbon Info Control and stores it in there, so it can be re-set to this one in "tr_char_ribbon_exit".
    
    Parameter(s):
		0:	CONTROL		-	Control to get the "text" and other info from.
		0:	BOOL		-	CURRENTLY NOT USED
    
    Returns: nothing
    
    Example(s): none
*/


#include "..\..\..\..\config\ui\ui_def_base.inc"
params["_ctrl_src","_isRibbon"];

// _selected_medal = (ctrlText _ctrl_src);
_ctrl_preview = VN_TR_CHARINFO_MEDAL_RIBBON_CTRL;
_selected_medal = _ctrl_src getVariable ["medal",""];
_ctrl_preview setVariable ["curIcon", _selected_medal];
_ctrl_preview ctrlSetText _selected_medal;

_tooltip = _ctrl_src getVariable ["name",""];
_tooltip = if(isLocalized _tooltip)then{localize _tooltip}else{_tooltip};
_ctrl_preview ctrlSetToolTip _tooltip;
_ctrl_preview setVariable ["name", _tooltip];

_text = _ctrl_src getVariable ["text",""];
_ctrl_text ctrlSetStructuredText parseText format["<t size='0.65' >%1</t>", _text];
_ctrl_preview setVariable ["text", _text];

_ctrl_size = ctrlPosition _ctrl_preview;
_ctrl_preview setVariable ["size_cur",[_ctrl_size#1,_ctrl_size#3]];