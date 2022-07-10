//included by "ui_tr_base.hpp"

class vn_tr_disp_taskRoster_Main
{
	name = "vn_tr_disp_taskRoster_Main";
	//scriptName = "vn_tr_disp_taskRoster_Main";
	//scriptPath = "GUI";
	//If already opened -> Recalling it -> Reloading the Dialog (e.g. like updating the view, without "closing" it)
	onLoad = "[""onLoad"",_this,""vn_tr_disp_taskRoster_Main"",''] call 	(uinamespace getvariable 'BIS_fnc_initDisplay'); [] call vn_mf_fnc_tr_overview_init;";
	onUnload = "[""onUnload"",_this,""vn_tr_disp_taskRoster_Main"",''] call 	(uinamespace getvariable 'BIS_fnc_initDisplay');";
	idd = VN_IDD_TR_TASKROSTER;
	movingEnable = 1;
	enableSimulation = 1;
	
	
	class ControlsBackground
	{
		// Prevent the ListNBox from using any control with the idc -1 as its left and right control
		class LNBCatcher: vn_mf_RscText
		{
			idc = -1;
		};
		class folderBackground: vn_mf_RscPicture
		{
			idc = -1;
			x = VN_TR_FOLDER_X;
			y = VN_TR_FOLDER_Y;
			w = VN_TR_FOLDER_W;
			h = VN_TR_FOLDER_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_folder_background_sheetL.paa";
			tooltip = "";
		};
		
		class vn_sheet_overview: vn_sheet_overview_accepted_base
		{
			idc = -1;
		};
		
		//Background Image
		class vn_sheet_clean_R: vn_sheet_clean_R_base
		{
			idc = -1;
		};
		
		//Must be here... remember the popup nonsense...
		class vn_tr_missionInfoPolaroid: vn_tr_missionInfoPolaroid_base
		{
			idc = VN_TR_MISSIONSHEET_IDC;
		};
		//Support Request Sheet
		class vn_tr_supportRequest: vn_tr_supportRequest_base
		{
			idc = VN_TR_SUPREQ_IDC;
		};
		//Character Informations
		class vn_tr_characterInfo: vn_tr_characterInfo_base
		{
			idc = VN_TR_CHARINFO_IDC;
		};
		
		//MUST be last entry, so it's above all other Sheets!
		//Main Info
		class vn_tr_MainInfo: vn_tr_MainInfo_base
		{
			idc = VN_TR_MAININFO_IDC;
		};
		
	};
	
	class Controls
	{
		
		class team_logo: vn_mf_RscPicture
		{
			idc = VN_TR_TEAMLOGO_IDC;
			
			x = UIX_CL(12.5);
			y = UIY_CU(10);
			w = UIW(2.5);
			h = UIH(2.5);
			
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			text = "";
		};
		class team_logo_btn: vn_mf_RscButton
		{
			idc = VN_TR_TEAMLOGO_BTN_IDC;
			x = UIX_CL(12.5);
			y = UIY_CU(10);
			w = UIW(2.5);
			h = UIH(2.5);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			
			tooltip = "";
			text = "";
			onButtonClick = "systemchat str [player getVariable ['vn_mf_db_player_group','MikeForce']]; call vn_mf_fnc_tr_cleanRightSheet; createDialog 'vn_tr_disp_selectTeam';";
		};
		
		class username: vn_mf_RscButton
		{
			idc = VN_TR_USERNAME_IDC;
			style = "0x10";	//LEFT: "0x10" | Center: "0x02 + 0x10"
			
			x = UIX_CL(9.3);
			y = UIY_CU(9.8);
			w = UIW(7.5);
			h = UIH(1);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,1,0.0};
			sizeEx = TXT_S;
			onButtonClick = "call vn_mf_fnc_tr_cleanRightSheet; call vn_mf_fnc_tr_characterInfo_show";
			MouseButtonDown = "";	//No _this param given
			text = "Username";
		};
		class team: vn_mf_RscButton
		{
			idc = VN_TR_TEAMNAME_IDC;
			style = "0x10";	//LEFT: "0x10" | Center: "0x02 + 0x10"
			
			x = UIX_CL(9.3);
			y = UIY_CU(8.2);
			w = UIW(7.5);
			h = UIH(1);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,1,0.0};
			sizeEx = TXT_S;
			onButtonClick = "call vn_mf_fnc_tr_cleanRightSheet; call vn_mf_fnc_tr_mainInfo_show;";
			MouseButtonDown = "";	//No _this param given
			text = "Team";
		};
		
		class zone_a: vn_mf_RscButton
		{
			idc = VN_TR_ZONE_A_IDC;
			style = "0x10";	//LEFT: "0x10" | Center: "0x02 + 0x10"
			
			x = UIX_CL(16);
			y = UIY_CU(6.1);
			w = UIW(6.5);
			h = UIH(1);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,1,0.0};
			sizeEx = TXT_S;
			onButtonClick = "call vn_mf_fnc_tr_cleanRightSheet; call vn_mf_fnc_tr_mainInfo_show;";
			text = "InsertZonenameAHere";
		};
		class zone_a_flag: vn_mf_RscPicture
		{
			idc = 450104;
			
			x = UIX_CL(17);
			y = UIY_CU(6.1);
			w = UIW(1);
			h = UIH(1);
			
			// colorText[] = {0.3,0.3,0.3,1};
			colorText[] = {VN_TR_MISS_PRIM};
			colorBackground[] = {1,1,1,1};
			text = "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_primary.paa";
		};
		
		class zone_b: vn_mf_RscButton
		{
			idc = VN_TR_ZONE_B_IDC;
			style = "0x10";	//LEFT: "0x10" | Center: "0x02 + 0x10"
			
			x = UIX_CL(8.3);
			y = UIY_CU(6.1);
			w = UIW(6.5);
			h = UIH(1);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,1,0.0};
			sizeEx = TXT_S;
			onButtonClick = "call vn_mf_fnc_tr_cleanRightSheet; call vn_mf_fnc_tr_mainInfo_show;";
			MouseButtonDown = "";	//No _this param given
			text = "InsertZonenameBHere";
		};
		class zone_b_flag: vn_mf_RscPicture
		{
			idc = 450106;
			x = UIX_CL(9.3);
			y = UIY_CU(6.1);
			w = UIW(1);
			h = UIH(1);
			colorText[] = {VN_TR_MISS_SECO};
			colorBackground[] = {1,1,1,1};
			text = "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_primary.paa";
		};
		class requestMission: vn_mf_RscButton
		{
			idc = VN_TR_TASK_REQ_IDC;
			style = "0x10";	//LEFT: "0x10" | Center: "0x02 + 0x10"
			
			x = UIX_CL(16);
			y = UIY_CU(4.4);
			w = UIW(14);
			h = UIH(1);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,1,0.0};
			sizeEx = TXT_S;
			onButtonClick = "call vn_mf_fnc_tr_cleanRightSheet; call vn_mf_fnc_tr_supportTask_show;";
			
			MouseButtonDown = "";	//No _this param given
			text = "Request a support task";
		};
		class requestMission_flag: vn_mf_RscPicture
		{
			idc = VN_TR_TASK_REQ_FLAG_IDC;
			
			x = UIX_CL(17);
			y = UIY_CU(4.4);
			w = UIW(1);
			h = UIH(1);
			
			colorText[] = {VN_TR_MISS_SUPP};
			colorBackground[] = {1,1,1,1};
			text = "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_support.paa";
		};
		
		class mission_active: vn_mf_RscButton
		{
			idc = VN_TR_TASK_ACTIVE_IDC;
			style = "0x10";	//LEFT: "0x10" | Center: "0x02 + 0x10"
			
			x = UIX_CL(16);
			y = UIY_CU(2.45);
			w = UIW(14);
			h = UIH(1);
			
			text = "No active Task";
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,1,0.0};
			sizeEx = TXT_S;
			onButtonClick = "[controlNull, -1] call vn_mf_fnc_tr_missions_show;";
			MouseButtonDown = "";	//No _this param given
		};
		class mission_active_icon: vn_mf_RscPicture
		{
			idc = VN_TR_TASK_ICON_IDC;
			
			x = UIX_CL(17);
			y = UIY_CU(2.45);
			w = UIW(1);
			h = UIH(1);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {1,1,1,1};
			text = "";
		};
		
		
		class missionList: vn_mf_RscListNBox //vn_mf_RscListBox
		{
			idc = VN_TR_MISSIONLIST_IDC;
			
			x = UIX_CL(17);
			y = UIY_CU(0.45);
			w = UIW(16);
			h = UIH(10);
			
			
			//columns[] = {	0,									1,						2,						3 };
			//columns[] = {	(Symbol: Support/Main/Seconday),	(Symbol: MissionType),	(Text: Description),	(Data/Placeholder)};
			columns[] = {0.0,UIW(2.25),UIW(4.25),UIW(5)};
			
			
			//colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,1};
			
			colorText[] = {0,0,0,1}; // Text and frame color
			colorSelect[] = {0,0,0,1}; // Text selection color
			colorSelect2[] = {0,0,0,1}; // Text selection color (oscillates between this and colorSelect)
			colorDisabled[] = {1,1,1,0.5}; // Disabled text color
			colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)
			
			colorPicture[] = {0.2,0.2,0.2,1};
			colorPictureSelected[] = {0.9,0.9,0.9,1};
			colorPictureDisabled[] = {0,0,0,1};
			
			onLBSelChanged = "_this call vn_mf_fnc_tr_missions_show";
			onLBDblClick = "";
		};
		
		//ALWAYS AT THE BOTTOM/LAST OF THE CONTROLS!
		class folder_cordels: vn_tr_cordels{};
	};
};