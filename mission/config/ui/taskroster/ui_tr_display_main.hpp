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
		
		/* class vn_sheet_overview: vn_sheet_overview_accepted_base */
		/* { */
		/* 	idc = -1; */
		/* }; */
		
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
		class Overview: vn_mf_RscControlsGroupNoScrollbarHV
		{
			show = 0;
			idc = VN_TR_OVERVIEW_IDC;
			x = VN_TR_SHEET_L_X;
			y = VN_TR_SHEET_L_Y;
			w = VN_TR_SHEET_L_W;
			h = VN_TR_SHEET_L_H;
			class Controls
			{
				class Background: vn_mf_RscPicture
				{
					text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_overview_accepted.paa";
					x = 0;
					y = 0;
					w = VN_TR_SHEET_L_W;
					h = VN_TR_SHEET_L_H;
				};
				class team_logo: vn_mf_RscPicture
				{
					idc = VN_TR_TEAMLOGO_IDC;
					
					x = UIW(6.5);
					y = UIH(2);
					w = UIW(2.5);
					h = UIH(2.5);
					
					colorText[] = {1,1,1,1};
					colorBackground[] = {1,1,1,1};
					text = "";
				};
				class team_logo_btn: vn_mf_RscButton
				{
					idc = VN_TR_TEAMLOGO_BTN_IDC;
					x = UIW(6.5);
					y = UIH(2);
					w = UIW(2.5);
					h = UIH(2.5);
					
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,0,0};
					colorFocused[] = {0,0,0,0};
					colorShadow[] = {0,0,0,0};
					colorBorder[] = {0,0,0,0};
					
					tooltip = "";
					text = "";
					onButtonClick = "call vn_mf_fnc_tr_cleanRightSheet; createDialog 'vn_tr_disp_selectTeam';";
				};
				
				class username: vn_mf_RscButton
				{
					idc = VN_TR_USERNAME_IDC;
					style = "0x10";	//LEFT: "0x10" | Center: "0x02 + 0x10"
					
					x = UIW(9.7);
					y = UIH(2.2);
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
					
					x = UIW(9.7);
					y = UIH(3.8);
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
					
					x = UIW(3);
					y = UIH(5.9);
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
					
					x = UIW(2);
					y = UIH(5.9);
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
					
					x = UIW(10.7);
					y = UIH(5.9);
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
					x = UIW(9.7);
					y = UIH(5.9);
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
					
					x = UIW(3);
					y = UIH(7.6);
					w = UIW(14);
					h = UIH(1);
					
					colorText[] = {0,0,0,1};
					colorBackground[] = {0,0,1,0.0};
					sizeEx = TXT_S;
					// onButtonClick = "call vn_mf_fnc_tr_cleanRightSheet; call vn_mf_fnc_tr_supportTask_show;";
					
					MouseButtonDown = "";	//No _this param given
					text = "Request a support task";
				};
				class requestMission_flag: vn_mf_RscPicture
				{
					idc = VN_TR_TASK_REQ_FLAG_IDC;
					
					x = UIW(2);
					y = UIH(7.6);
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
					
					x = UIW(3);
					y = UIH(9.5);
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
					
					x = UIW(2);
					y = UIH(9.5);
					w = UIW(1);
					h = UIH(1);
					
					colorText[] = {0,0,0,1};
					colorBackground[] = {1,1,1,1};
					text = "";
				};
				
				
				class missionList: vn_mf_RscListNBox //vn_mf_RscListBox
				{
					idc = VN_TR_MISSIONLIST_IDC;
					
					x = UIW(2);
					y = UIH(11.55);
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
			};
		};

		class Requests: vn_mf_RscControlsGroupNoScrollbarHV
		{
			idc = VN_TR_REQUESTS_IDC;
			show = 0;
			x = VN_TR_SHEET_L_X;
			y = VN_TR_SHEET_L_Y;
			w = VN_TR_SHEET_L_W;
			h = VN_TR_SHEET_L_H;
			class Controls
			{
				class BackgroundImage: vn_sheet_overview_base
				{
					text = "img\TaskRoster\Page_NoTabs.paa";
					x = 0;
					y = 0;
				};
			};
		};
		class Tasks: Requests
		{
#define COLOR_BACKGROUND_FOLDER {0.91, 0.82, 0.67, 1}
#define COLOR_PAPER {0.9, 0.9, 0.9, 1}
			idc = VN_TR_TASKS_IDC;
			show = 1;
			x = VN_TR_SHEETS_X;
			y = VN_TR_SHEETS_Y;
			w = VN_TR_SHEETS_W;
			h = VN_TR_SHEETS_H;
			class Controls: Controls
			{
				class BackgroundImage: BackgroundImage
				{
					text = "img\TaskRoster\Tasks.paa";
				};
				class LabelMainTasks: vn_mf_RscStructuredText
				{
					idc = -1;
					text = "$STR_vn_mf_tr_tasks_label_main_tasks_text";
					x = UIW(2.3);
					y = UIH(2.2);
					w = UIW(5);
					h = UIH(1);
					class Attributes
					{
						font = USEDFONT;
						color = "#000000";
						colorLink = "#D09B43";
						align = "left";
						shadow = 1;
					};
				};
				class BtnChooseNewZone: vn_mf_RscButton
				{
					idc = -1;
					text = "$STR_vn_mf_tr_tasks_btn_choose_new_zone_text";
					sizeEx = TXT_S;
					x = VN_TR_SHEET_L_W - UIW(7.5);
					y = UIH(2.25);
					w = UIW(5.5);
					h = UIH(0.9);
					colorText[] = {0,0,0,1};
				};
#define _H 7
				class TreeMainTaskList: vn_mf_RscTree
				{
					idc = VN_TR_TASKS_TREEMAINTASKLIST_IDC;
					x = UIW(2.2);
					y = UIH(4);
					w = VN_TR_SHEET_L_W - UIW(4.4);
					h = UIH(_H);
					// colorBackground[] = COLOR_PAPER;
					colorText[] = {0,0,0,1};
					borderSize = 1;
					/* colorBorder[] = {0,0,0,1}; */
					colorLines[] = {0,0,0,1};
					colorSelect[] = {0.9,0.9,0.2,0.5};
					colorArrow[] = {0,0,0,1};
					colorPicture[] = {0,0,0,1};
					hiddenTexture = "";
					expandedTexture = "";
				};
				class LabelAcceptedSupportTasks: LabelMainTasks
				{
					idc = -1;
					text = "$STR_vn_mf_tr_tasks_label_accepted_support_tasks_text";
					y = UIH((4 + _H));
					w = UIW(6);
				};
				class PendingRequests: BtnChooseNewZone
				{
					idc = -1;
					text = "$STR_vn_mf_tr_tasks_pending_requests_text";
					x = VN_TR_SHEET_L_W - UIW(7.5);
					y = UIH((4.1 + _H));
					w = UIW(5.5);
				};
				// class BackgroundSupportTasks: BackgroundMainTasks
				// {
				// 	y = UIH((3.8 + _H));
				// };
				class SupportTasks: vn_mf_RscListbox
				{
					idc = VN_TR_TASKS_SUPPORTTASKS_IDC;
					x = UIW(2.2);
					y = UIH((5.6 + _H));
					w = VN_TR_SHEET_L_W - UIW(4.5);
					h = UIH((_H + 1.2));
					colorBackground[] = {0,0,0,0};
					colorText[] = {0,0,0,1};
					colorSelect[] = {0,0,0,1};
					colorSelect2[] = {0,0,0,1};
					colorSelectBackground[] = {0.9,0.9,0.2,0.5};
					colorSelectBackground2[] = {0.9,0.9,0.2,0.5};
					colorPicture[] = {1,1,1,1};
					colorPictureSelected[] = {1,1,1,1};
					period = 0;
				};
#undef _H
				// Right page
				class BackgroundImageRight: BackgroundImage
				{
					text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_missionsheet_P_M_1.paa";
					x = VN_TR_SHEET_L_W;
					y = 0;
					w = VN_TR_SHEET_R_W;
					h = VN_TR_SHEET_R_H;
				};
				class Polaroid: vn_mf_RscPicture
				{
					idc = VN_TR_TASKS_POLAROID_IDC;
					x = VN_TR_SHEET_L_W + UIW(1);
					y = UIH(17.1);
					w = UIW(9.9);
					h = UIH(6.9);
					text = "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_secondary.paa";
				};
				class ZoneMap: vn_mf_RscMapControl
				{
					idc = VN_TR_TASKS_ZONEMAP_IDC;
					x = VN_TR_SHEET_L_W + UIW(9.2);
					y = UIH(17.5);
					w = UIW(7.4);
					h = UIH(6.95);
					type = 101;
					style = "0x10+ 0x20";
				};
				class TaskTitle: vn_mf_RscStructuredText
				{
					idc = VN_TR_TASKS_TASKTITLE_IDC;
					text = "Task Title";
					x = VN_TR_SHEET_L_W + UIW(2);
					y = UIH(3.5);
					w = VN_TR_SHEET_R_W - UIW(4);
					h = UIH(1);
					size = TXT_L;
					class Attributes
					{
						font = USEDFONT;
						color = "#000000";
						colorLink = "#D09B43";
						align = "left";
						shadow = 0;
					};
				};
				class TaskDescription: TaskTitle
				{
					idc = VN_TR_TASKS_TASKDESCRIPTION_IDC;
					text = "A lot of text";
					y = UIH(4.6);
					h = UIH(5);
					size = TXT_S;
				};
				class Distance: vn_mf_RscStructuredText
				{
					idc = VN_TR_TASKS_TASKDISTANCE_IDC;
					text = "3.0 km";
					x = VN_TR_SHEET_L_W + UIW(2);
					y = UIH(15.5);
					w = UIW(5);
					h = UIH(1);
					size = TXT_L;
				};
			};
		};

		class TabProfile: vn_mf_RscActivePicture
		{
			idc = VN_TR_TABPROFILE_IDC;
			text = "img\TaskRoster\Profile_Tab.paa";
			x = VN_TR_SHEET_L_X - UIW(1.1);
			y = VN_TR_SHEET_L_Y + UIH(0.7);
			w = UIW(1.5);
			h = UIH(4);
			color[] = {0.9,0.9,0.9,1};
			colorActive[] = {1,1,1,1};
			onButtonClick = "[] call vn_mf_fnc_tr_overview_init;";
		};
		class TabRequests: TabProfile
		{
			idc = VN_TR_TABSUPPORT_IDC;
			text = "img\TaskRoster\Requests_Tab.paa";
			y = VN_TR_SHEET_L_Y + UIH(4.6);
			onButtonClick = "[] call vn_mf_fnc_tr_requests_init;";
		};
		class TabTasks: TabProfile
		{
			idc = VN_TR_TABTASKS_IDC;
			text = "img\TaskRoster\Tasks_Tab.paa";
			y = VN_TR_SHEET_L_Y + UIH(8.5);
			onButtonClick = "[] call vn_mf_fnc_tr_tasks_init;";
		};
		
		//ALWAYS AT THE BOTTOM/LAST OF THE CONTROLS!
		class folder_cordels: vn_tr_cordels{};
	};
};
