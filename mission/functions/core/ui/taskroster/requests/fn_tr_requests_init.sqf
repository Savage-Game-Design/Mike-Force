#include "..\..\..\..\..\config\ui\ui_def_base.inc"

// Cleanup everything
call vn_mf_fnc_tr_cleanRightSheet;
[VN_TR_TABREQUESTS_CTRL] call vn_mf_fnc_tr_tabs_toggle;
VN_TR_REQUESTS_TAB_CTRL ctrlShow true;
VN_TR_REQUESTS_TAB_BG_CTRL ctrlShow true;

[VN_TR_REQUESTS_DATA_LIST_UNSORTED] call vn_mf_fnc_tr_requests_load;