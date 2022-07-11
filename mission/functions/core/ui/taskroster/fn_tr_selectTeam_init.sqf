/*
    File: fn_tr_selectTeam_init.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Called in onLoad section of the Display.
		Set's the text for the currently active Team in the Team-selection dialog.
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s):
		[] call vn_mf_fnc_tr_selectTeam_init;
*/

disableSerialization;
#include "..\..\..\..\config\ui\ui_def_base.inc"


VN_TR_SELECTTEAM_TEAM_LOGO_CTRL ctrlSetText "";

// _text = composeText ["The Viet Cong controls this province.", lineBreak, "Your Mobile Strike Force must take control of the populace and destroy the Viet Cong"];
VN_TR_SELECTTEAM_TEAM_DESC_CTRL ctrlSetStructuredText parseText "MISSION STRATEGY</t>";

_text = "
The Viet Cong controls this province.<br/>
Your Mobile Strike Force must take control of the populace and destroy the Viet Congs jungle sanctuaries.<br/>
<br/>
- There are 10 zones to capture and hold.<br/>
- You can operate in 2 zones at the same time.<br/>
There are 4 teams:<br/>
- Mike Force; ACAV; Green Hornets; and Spike Team.<br/>
- Teams work together on Primary Tasks to help capture a zone.<br/>
- Your team - (insert name here) - has unique Team Tasks which help capture a zone. Change teams in the lobby.<br/>
- You can get support from other teams with Request Support (Hyperlink?).<br/>
- Your team can complete Support Tasks for the other teams.<br/>
- Completing Team and Support Tasks helps you gain rank.<br/>
- Higher ranks can access improved weapons, equipment and vehicles.<br/>
- Working together as a unified force will secure the province more quickly.<br/>
- So choose your team. Good luck out there, you’re going to need it!</t>";

VN_TR_SELECTTEAM_TEAM_TEXT_CTRL ctrlSetStructuredText parseText _text;
