/*
    File: fn_tr_supportTask_create.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Called by control.
		Gathers all information from missionRequest Page and sends the Mission Request to the Server.
    
    Parameter(s): none
    
    Returns: nothing
    
    Example(s):
		call vn_mf_fnc_tr_supportTask_create
*/

disableSerialization;

systemchat str ["vn_tr_supportMissionInfo: ", vn_tr_supportMissionInfo];
if((vn_tr_supportMissionInfo#2) isEqualTo [])exitWith{systemchat str ["((vn_tr_supportMissionInfo#2) isEqualTo []) = ", ((vn_tr_supportMissionInfo#2) isEqualTo [])]};
//disable the Request Button, after clicking it
VN_TR_SUPREQ_CTASK_IDC ctrlEnable false;
//cleanup the right side
call vn_mf_fnc_tr_cleanRightSheet;

//send request to Server
//["Classname",[Coords],"TeamName"]
["supporttaskcreate", vn_tr_supportMissionInfo] call para_c_fnc_call_on_server;
//clear TempVar
vn_tr_supportMissionInfo = ["",[],[]];

//DEV / ToDo: Get confirmation/Trigger from Server, when mission is created
[] call vn_mf_fnc_tr_missions_fill;
