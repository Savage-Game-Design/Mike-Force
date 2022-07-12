#include "\a3\ui_f\hpp\definedikcodes.inc"

//--- Key down actions:
class vn_mf_keydown_escape_action
{
	defaultKey = DIK_ESC;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_abort_building";
	down = 1;
	displayName = "";
	access = 0;
};
class para_keydown_open_wheel_menu
{
	defaultKey = DIK_6;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_wheel_menu_open_keybind";
	down = 1;
	displayName = $STR_vn_mf_keybindings_selector;
	access = 1;
};
class para_vote_1
{
	defaultKey = DIK_F1;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_vote_1";
	down = 1;
	displayName = "Vote for Option #1";
	access = 1;
};
class para_vote_2
{
	defaultKey = DIK_F2;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_vote_2";
	down = 1;
	displayName = "Vote for Option #2";
	access = 1;
};
class para_vote_3
{
	defaultKey = DIK_F3;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_openVoteMenu";
	down = 1;
	displayName = "Open Voting Menu";
	access = 1;
};
class vn_mf_interactionOverlay_toggle
{
	defaultKey = DIK_7; // 7
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_interactionOverlay_toggle";
	down = 1;
	displayName = $STR_vn_mf_keybindings_interactionOverlay_toggle;
	access = 1;
};


//--- Key up actions:
class vn_mf_debug_monitor_action
{
	defaultKey = DIK_GRAVE;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_enable_debug_monitor";
	down = 0;
	displayName = $STR_vn_mf_keybindings_debug_monitor;
	access = 1;
};
class vn_mf_task_roster_action
{
	defaultKey = DIK_H;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "vn_mf_fnc_enable_task_roster";
	down = 0;
	displayName = $STR_vn_mf_keybindings_task_roster;
	access = 1;
};
class vn_mf_ack_hint_card {
	defaultKey = DIK_8;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_ui_hints_acknowledgeHintKeypress";
	down = 0;
	displayName = "Acknowledge Hint";
	access = 1;
}
class vn_mf_build_mode_action_up
{
	defaultKey = DIK_N;
	shift = "false";
	ctrl = "false";
	alt = "false";
	function = "para_c_fnc_toggle_buildmode";
	down = 0;
	displayName = $STR_vn_mf_keybindings_build_mode;
	access = 1;
};
class vn_mf_quick_build
{
	defaultKey = DIK_N;
	shift = "false";
	ctrl = "true";
	alt = "false";
	function = "para_c_fnc_buildingMenu_quickBuild";
	down = 0;
	displayName = "Quick Build /loc";
	access = 1;
};
