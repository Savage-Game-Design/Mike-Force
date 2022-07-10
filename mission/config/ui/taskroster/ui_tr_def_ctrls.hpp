//included by "ui_tr_base.hpp"

//Cordels in the center of the folder. Must be loaded as last item!
class vn_tr_cordels: vn_mf_RscPicture
{
	idc = -1;
	x = VN_TR_CORDLES_X;
	y = VN_TR_CORDLES_Y;
	w = VN_TR_CORDLES_W;
	h = VN_TR_CORDLES_H;
	
	colorText[] = {1,1,1,1};
	colorBackground[] = {1,1,1,1};
	text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_folder_cordels.paa";
	tooltip = "";
	onLoad = "(_this#0) ctrlenable false;";
};
//Clean Sheet, already adjusted to Standard Folder Size and correct position
class vn_sheet_clean_R_base: vn_mf_RscPicture
{
	idc = -1;
	x = VN_TR_SHEET_R_X;
	y = VN_TR_SHEET_R_Y;
	w = VN_TR_SHEET_R_W;
	h = VN_TR_SHEET_R_H;
	
	colorText[] = {1,1,1,1};
	colorBackground[] = {1,1,1,1};
	text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_sheet_clean.paa";
	tooltip = "";
};

class vn_sheet_overview_base: vn_mf_RscPicture
{
	idc = -1;
	x = VN_TR_SHEET_L_X;
	y = VN_TR_SHEET_L_Y;
	w = VN_TR_SHEET_L_W;
	h = VN_TR_SHEET_L_H;

	colorText[] = {1,1,1,1};
	colorBackground[] = {1,1,1,1};
	text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_overview.paa";
	tooltip = "";
};

class vn_sheet_overview_accepted_base: vn_sheet_overview_base
{
	idc = -1;
	text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_overview_accepted.paa";
};

class vn_tr_selectTeam_base : vn_mf_RscControlsGroupNoScrollbarHV
{
	idc = -1;
	//onLoad = "(_this#0) ctrlenable false;";
	onLoad = "";
	
	x = VN_TR_SHEET_R_X;
	y = VN_TR_SHEET_R_Y;
	w = VN_TR_SHEET_R_W;
	h = VN_TR_SHEET_R_H;
	
	class controls
	{
		
		class txtTop: vn_mf_RscStructuredText_c
		{
			idc = -1;
			x = UIW(2);
			y = UIH(2.5);
			w = UIW(15.5);
			h = UIH(0.9);
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0};
			size = TXT_M;
			text = "Choose your team.";	//loc
			tooltip = "";
		};
		
		class txtTop2: vn_mf_RscStructuredText_c
		{
			idc = VN_TR_SELECTTEAM_TEAM_PLAYERCOUNT_IDC;
			x = UIW(2);
			y = UIH(3.5);
			w = UIW(15.5);
			h = UIH(1.6);
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0};
			size = TXT_S;
			text = "Active Players:";	//loc
			tooltip = "";
		};
		
		
		class logoTL: vn_mf_RscButton_ImgSwitch
		{
			idc = VN_TR_SELECTTEAM_TEAM_LOGO_TL_IDC;
			x = UIW(2.75);
			y = UIH(5.5);
			w = UIW(6);
			h = UIH(6);
			
			tooltip = "";
			
			text = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_ACAV.paa";
			textUp = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_ACAV_HL.paa";
			
			onButtonClick = "['ACAV'] call vn_mf_fnc_tr_selectTeam;";
		};
		class logoTR: vn_mf_RscButton_ImgSwitch
		{
			idc = VN_TR_SELECTTEAM_TEAM_LOGO_TR_IDC;
			x = UIW(9.75);
			y = UIH(5.5);
			w = UIW(6);
			h = UIH(6);
			
			tooltip = "";
			
			text = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_Hornets.paa";
			textUp = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_Hornets_HL.paa";
			
			onButtonClick = "['GreenHornets'] call vn_mf_fnc_tr_selectTeam;";
		};
		class logoBL: vn_mf_RscButton_ImgSwitch
		{
			idc = VN_TR_SELECTTEAM_TEAM_LOGO_BL_IDC;
			x = UIW(2.75);
			y = UIH(12);
			w = UIW(6);
			h = UIH(6);
			
			tooltip = "";
			
			text = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_MikeForce.paa";
			textUp = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_MikeForce_HL.paa";
			
			onButtonClick = "['MikeForce'] call vn_mf_fnc_tr_selectTeam;";
		};
		class logoBR: vn_mf_RscButton_ImgSwitch
		{
			idc = VN_TR_SELECTTEAM_TEAM_LOGO_BR_IDC;
			x = UIW(9.75);
			y = UIH(12);
			w = UIW(6);
			h = UIH(6);
			
			tooltip = "";
			
			text = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_SpikeTeam.paa";
			textUp = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_SpikeTeam_HL.paa";
			
			onButtonClick = "['SpikeTeam'] call vn_mf_fnc_tr_selectTeam;";
		};
		
		
		
		class txtTeam: vn_mf_RscStructuredText
		{
			idc = VN_TR_SELECTTEAM_TEAM_NAME_IDC;
			x = UIW(2);
			y = UIH(18.5);
			w = UIW(15.5);
			h = UIH(1.2);
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0};
			size = TXT_M;
			text = "Select a Team";	//loc
			tooltip = "";
		};
		
		class txtBot: vn_mf_RscStructuredText
		{
			idc = VN_TR_SELECTTEAM_TEAM_TEXT_BOTTOM_IDC;
			x = UIW(2);
			y = UIH(19.9);
			w = UIW(15.5);
			h = UIH(2.8);
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0};
			size = TXT_S;
			text = "Take the fight to the VC in close quarter combat. Access to static weapon emplacements";	//loc
			tooltip = "";
		};
	};
};

class vn_tr_supportRequest_miniMap: vn_mf_RscMapControl
{
	idc = VN_TR_SUPREQ_MAP_IDC;
	x = UIX_CL(10);
	y = UIY_CU(10);
	w = UIW(20);
	h = UIH(20);
	
	//onLoad = "(_this#0) ctrlenable false;";
	onLoad = "";
	tooltip = "";
};

class vn_tr_supportRequest_miniMap_accept: vn_mf_RscButton
{
	idc = VN_TR_SUPREQ_ACCEPT_IDC;
	style = "0x02 + 0x10";	//LEFT: "0x10" | Center: "0x02 + 0x10"
	
	x = UIX_CR(2);
	y = UIY_CD(10.5);
	w = UIW(8);
	h = UIH(2);
	
	colorText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,0.5};
	sizeEx = TXT_S;
	
	onButtonClick = "systemchat str [_this, 'ACCEPT']; call vn_mf_fnc_tr_supportTask_selectPosition_accept;";
	MouseButtonDown = "";	//No _this param given
	text = "ACCEPT";
};

class vn_tr_supportRequest_miniMap_abort: vn_mf_RscButton
{
	idc = VN_TR_SUPREQ_ABORT_IDC;
	style = "0x02 + 0x10";	//LEFT: "0x10" | Center: "0x02 + 0x10"
	
	x = UIX_CL(10);
	y = UIY_CD(10.5);
	w = UIW(8);
	h = UIH(2);
	
	colorText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,0.5};
	sizeEx = TXT_S;
	
	onButtonClick = "systemchat str [_this, 'ABORT']; [] spawn vn_mf_fnc_tr_supportTask_map_hide;";
	MouseButtonDown = "";	//No _this param given
	text = "ABORT";
};

class vn_tr_supportRequest_base : vn_mf_RscControlsGroupNoScrollbarHV
{
	idc = VN_TR_SUPREQ_IDC;
	//onLoad = "(_this#0) ctrlenable false;";
	onLoad = "";
		
	x = VN_TR_SHEET_R_X;
	y = VN_TR_SHEET_R_Y;
	w = VN_TR_SHEET_R_W;
	h = VN_TR_SHEET_R_H;
	
	class controls
	{
		class SupportTaskBackground: vn_mf_RscPicture
		{
			idc = -1;
			x = UIW(0);
			y = UIH(0);
			w = VN_TR_SHEET_L_W;
			h = VN_TR_SHEET_L_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_CreateSupportTask.paa";
			tooltip = "";
		};
		
		
		class description_text: vn_mf_RscStructuredText_c
		{
			idc = VN_TR_SUPREQ_DESC_TXT_IDC;
			style = 0x10;
			x = UIW(3);
			y = UIH(3.2);
			w = UIW(12);
			h = UIH(3.4);
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			sizeEx = TXT_CST(0.6);
			text = "";
			tooltip = "";
		};
		
		class supportTask_text: vn_mf_RscStructuredText_c
		{
			idc = VN_TR_SUPREQ_TASK_TXT_IDC;
			x = UIW(3);
			y = UIH(6.7);
			w = UIW(12);
			h = UIH(0.9);
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			size = TXT_S;
			text = "Select Task";
			tooltip = "";
		};
		class supportTask: vn_mf_RscListNBox //vn_mf_RscListBox
		{
			idc = VN_TR_SUPREQ_TASK_IDC;
			
			x = UIW(3);
			y = UIH(7.5);
			w = UIW(12);
			h = UIH(6);
			
			
			//columns[] = {	0,			1,					};
			//columns[] = {	(Symbol:),	(Text: Description)	};
			columns[] = {0,0.06};
			
			sizeEx = TXT_S;
			rowHeight = UIH(0.7);
			
			colorBackground[] = {0,0,1,0.5};
			colorText[] = {0,0,0,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorDisabled[] = {1,1,1,0.5};
			colorShadow[] = {0,0,0,0};
			
			colorPicture[] = {0.0,0.5,0.1,1};
			colorPictureSelected[] = {0.0,0.5,0.1,1};
			colorPictureDisabled[] = {0,0,0,1};
			
			onLBSelChanged = "_this call vn_mf_fnc_tr_supportTask_selectTask; false";
			onLBDblClick = "";
		};
		
		
		class supportTeam_text: vn_mf_RscStructuredText_c
		{
			idc = VN_TR_SUPREQ_TEAM_TXT_IDC;
			x = UIW(3);
			y = UIH(14.3);
			w = UIW(12);
			h = UIH(0.9);
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			size = TXT_S;
			text = "Select Team";
			tooltip = "";
		};
		class supportTeam: supportTask
		{
			idc = VN_TR_SUPREQ_TEAM_IDC;
			
			x = UIW(3);
			y = UIH(15.1); 
			w = UIW(12);
			h = UIH(2.3);
			
			colorPicture[] = {1,1,1,1};
			colorPictureSelected[] = {1,1,1,1};
			colorPictureDisabled[] = {1,1,1,1};
			
			onLBSelChanged = "_this call vn_mf_fnc_tr_supportTask_selectTeam; false";
			onLBDblClick = "";
		};
		class selectPosition: vn_mf_RscButton
		{
			idc = VN_TR_SUPREQ_SELPOS_IDC;
			
			x = UIW(3);
			y = UIH(17.5);
			w = UIW(12);
			h = UIH(0.9);
			
			style = "0x02 + 0x10";	//LEFT "0x10"| Center: "0x02 + 0x10"
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,1,0.0};
			sizeEx = TXT_S;
			onButtonClick = "_this#0 ctrlEnable false; call vn_mf_fnc_tr_supportTask_selectPosition;";
			MouseButtonDown = "";	//No _this param given
			text = "Select Position";
		};
		
		class createTask: vn_mf_RscButton
		{
			idc = VN_TR_SUPREQ_CTASK_IDC;
			
			x = UIW(3);
			y = UIH(18.5);
			w = UIW(12);
			h = UIH(1.2);
			
			style = "0x02 + 0x10";	//LEFT "0x10"| Center: "0x02 + 0x10"
			
			colorText[] = {1,0,0,1};
			colorDisabled[] = {0,0,0,0.5};
			colorBackground[] = {0,0,1,0.0};
			sizeEx = TXT_M;
			onButtonClick = "systemchat str [_this,'4. Support Request']; (_this#0) ctrlEnable false; call vn_mf_fnc_tr_supportTask_create;";
			MouseButtonDown = "";	//No _this param given
			text = "Create new support task";
		};
	};
};

class vn_tr_characterInfo_base : vn_mf_RscControlsGroupNoScrollbarHV
{
	idc = VN_TR_CHARINFO_IDC;
	//onLoad = "(_this#0) ctrlenable false;";
	onLoad = "";
		
	x = VN_TR_SHEET_R_X;
	y = VN_TR_SHEET_R_Y;
	w = VN_TR_SHEET_R_W;
	h = VN_TR_SHEET_R_H;
	
	class controls
	{
		class characterInfoBackground: vn_mf_RscPicture
		{
			idc = -1;
			x = UIW(0);
			y = UIH(0);
			w = VN_TR_SHEET_L_W;
			h = VN_TR_SHEET_L_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_CharacterProfile.paa";
			tooltip = "";
		};
		//////////////////VN_TR_CHARINFO__IDC
		class playername: vn_mf_RscText
		{
			idc = VN_TR_CHARINFO_NAME_IDC;
			x = UIW(2.41);
			y = UIH(4.0);
			w = UIW(5.1);
			h = UIH(0.8);
			
			style = "0x10 + 0x0200";
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			shadow = 0;
			text = "playername";
			font = USEDFONT;
			sizeEx = TXT_S;
			tooltip = "playername";
		};
		
		class serialnumber: vn_mf_RscText
		{
			idc = VN_TR_CHARINFO_SNUM_IDC;
			x = UIW(7.7);
			y = UIH(4.0);
			w = UIW(5.1);
			h = UIH(0.8);
			
			style = "0x10 + 0x0200";
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			shadow = 0;
			text = "serialnumber";
			font = USEDFONT;
			sizeEx = TXT_S;
			tooltip = "serialnumber";
		};
		
		class playerrank: vn_mf_RscText
		{
			idc = VN_TR_CHARINFO_RANK_IDC;
			x = UIW(12.9);
			y = UIH(4.0);
			w = UIW(5.1);
			h = UIH(0.8);
			
			style = "0x10 + 0x0200";
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			shadow = 0;
			text = "playerrank";
			font = USEDFONT;
			sizeEx = TXT_S;
			tooltip = "playerrank";
		};
		
		class curtaskname: vn_mf_RscText
		{
			idc = VN_TR_CHARINFO_TASK_IDC;
			x = UIW(2.41);
			y = UIH(6);
			w = UIW(8.8);
			h = UIH(0.8);
			
			style = "0x10 + 0x0200";
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			shadow = 0;
			text = "curtaskname";
			font = USEDFONT;
			sizeEx = TXT_S;
			tooltip = "curtaskname";
		};
		
		class worldname: vn_mf_RscText
		{
			idc = VN_TR_CHARINFO_WORLD_IDC;
			x = UIW(11.45);
			y = UIH(6);
			w = UIW(6.5);
			h = UIH(0.8);
			
			style = "0x10 + 0x0200";
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			shadow = 0;
			text = "worldname";
			font = USEDFONT;
			sizeEx = TXT_S;
			tooltip = "worldname";
		};
		
		class rankpoints: vn_mf_RscText
		{
			idc = VN_TR_CHARINFO_POINTS_IDC;
			x = UIW(2.41);
			y = UIH(8);
			w = UIW(7.8);
			h = UIH(0.8);
			
			style = "0x10 + 0x0200";
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			shadow = 0;
			text = "-1";
			font = USEDFONT;
			sizeEx = TXT_S;
			tooltip = "rankpoints";
		};
		
		class rankprogress: vn_mf_RscText
		{
			idc = VN_TR_CHARINFO_PROGR_IDC;
			x = UIW(10.31);
			y = UIH(8);
			w = UIW(7.8);
			h = UIH(0.8);
			
			style = "0x10 + 0x0200";
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			shadow = 0;
			text = "-1";
			font = USEDFONT;
			sizeEx = TXT_S;
			tooltip = "rankprogress";
		};
		
		class text_reward_text: vn_mf_RscStructuredText
		{
			idc = VN_TR_CHARINFO_REWARD_TEXT_IDC;
			x = UIW(2.5);
			y = UIH(12.5);
			w = UIW(15.5);
			h = UIH(2.5);
			
			// style = "0x10 + 0x0200";
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			text = "";
			size = TXT_M;
			tooltip = "";
			class Attributes
			{
				align = "left";
				color = "#000000";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};
		
																																																	
		class ribbon_1  : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_1_IDC;  x = UIW((2.5+((2.15+0.2)*0))); y = UIH((15.30+(((2.15/3.3333)+0.2)*0))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_2  : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_2_IDC;  x = UIW((2.5+((2.15+0.2)*1))); y = UIH((15.30+(((2.15/3.3333)+0.2)*0))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_3  : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_3_IDC;  x = UIW((2.5+((2.15+0.2)*2))); y = UIH((15.30+(((2.15/3.3333)+0.2)*0))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_4  : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_4_IDC;  x = UIW((2.5+((2.15+0.2)*3))); y = UIH((15.30+(((2.15/3.3333)+0.2)*0))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_5  : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_5_IDC;  x = UIW((2.5+((2.15+0.2)*4))); y = UIH((15.30+(((2.15/3.3333)+0.2)*0))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
																																																	
		class ribbon_6  : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_6_IDC;  x = UIW((2.5+((2.15+0.2)*0))); y = UIH((15.30+(((2.15/3.3333)+0.2)*1))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_7  : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_7_IDC;  x = UIW((2.5+((2.15+0.2)*1))); y = UIH((15.30+(((2.15/3.3333)+0.2)*1))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_8  : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_8_IDC;  x = UIW((2.5+((2.15+0.2)*2))); y = UIH((15.30+(((2.15/3.3333)+0.2)*1))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_9  : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_9_IDC;  x = UIW((2.5+((2.15+0.2)*3))); y = UIH((15.30+(((2.15/3.3333)+0.2)*1))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_10 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_10_IDC; x = UIW((2.5+((2.15+0.2)*4))); y = UIH((15.30+(((2.15/3.3333)+0.2)*1))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
																																																	
		class ribbon_11 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_11_IDC; x = UIW((2.5+((2.15+0.2)*0))); y = UIH((15.30+(((2.15/3.3333)+0.2)*2))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_12 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_12_IDC; x = UIW((2.5+((2.15+0.2)*1))); y = UIH((15.30+(((2.15/3.3333)+0.2)*2))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_13 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_13_IDC; x = UIW((2.5+((2.15+0.2)*2))); y = UIH((15.30+(((2.15/3.3333)+0.2)*2))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_14 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_14_IDC; x = UIW((2.5+((2.15+0.2)*3))); y = UIH((15.30+(((2.15/3.3333)+0.2)*2))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_15 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_15_IDC; x = UIW((2.5+((2.15+0.2)*4))); y = UIH((15.30+(((2.15/3.3333)+0.2)*2))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
																																																	
		class ribbon_16 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_16_IDC; x = UIW((2.5+((2.15+0.2)*0))); y = UIH((15.30+(((2.15/3.3333)+0.2)*3))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_17 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_17_IDC; x = UIW((2.5+((2.15+0.2)*1))); y = UIH((15.30+(((2.15/3.3333)+0.2)*3))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_18 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_18_IDC; x = UIW((2.5+((2.15+0.2)*2))); y = UIH((15.30+(((2.15/3.3333)+0.2)*3))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_19 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_19_IDC; x = UIW((2.5+((2.15+0.2)*3))); y = UIH((15.30+(((2.15/3.3333)+0.2)*3))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_20 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_20_IDC; x = UIW((2.5+((2.15+0.2)*4))); y = UIH((15.30+(((2.15/3.3333)+0.2)*3))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
																																																	
		class ribbon_21 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_21_IDC; x = UIW((2.5+((2.15+0.2)*0))); y = UIH((15.30+(((2.15/3.3333)+0.2)*4))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_22 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_22_IDC; x = UIW((2.5+((2.15+0.2)*1))); y = UIH((15.30+(((2.15/3.3333)+0.2)*4))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_23 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_23_IDC; x = UIW((2.5+((2.15+0.2)*2))); y = UIH((15.30+(((2.15/3.3333)+0.2)*4))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_24 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_24_IDC; x = UIW((2.5+((2.15+0.2)*3))); y = UIH((15.30+(((2.15/3.3333)+0.2)*4))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_25 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_25_IDC; x = UIW((2.5+((2.15+0.2)*4))); y = UIH((15.30+(((2.15/3.3333)+0.2)*4))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
																																																	
		class ribbon_26 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_26_IDC; x = UIW((2.5+((2.15+0.2)*0))); y = UIH((15.30+(((2.15/3.3333)+0.2)*5))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_27 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_27_IDC; x = UIW((2.5+((2.15+0.2)*1))); y = UIH((15.30+(((2.15/3.3333)+0.2)*5))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_28 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_28_IDC; x = UIW((2.5+((2.15+0.2)*2))); y = UIH((15.30+(((2.15/3.3333)+0.2)*5))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_29 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_29_IDC; x = UIW((2.5+((2.15+0.2)*3))); y = UIH((15.30+(((2.15/3.3333)+0.2)*5))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_30 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_30_IDC; x = UIW((2.5+((2.15+0.2)*4))); y = UIH((15.30+(((2.15/3.3333)+0.2)*5))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
																																																	
		class ribbon_31 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_31_IDC; x = UIW((2.5+((2.15+0.2)*0))); y = UIH((15.30+(((2.15/3.3333)+0.2)*6))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_32 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_32_IDC; x = UIW((2.5+((2.15+0.2)*1))); y = UIH((15.30+(((2.15/3.3333)+0.2)*6))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_33 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_33_IDC; x = UIW((2.5+((2.15+0.2)*2))); y = UIH((15.30+(((2.15/3.3333)+0.2)*6))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_34 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_34_IDC; x = UIW((2.5+((2.15+0.2)*3))); y = UIH((15.30+(((2.15/3.3333)+0.2)*6))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
		class ribbon_35 : vn_mf_ribbon_base { idc = VN_TR_CHARINFO_RIBBON_35_IDC; x = UIW((2.5+((2.15+0.2)*4))); y = UIH((15.30+(((2.15/3.3333)+0.2)*6))); w = UIW(2.15); h = UIH((2.15/3.3333)); };
																																																	
		
		
		
		//Ribbon/Medal - Preview
		class ribbon_medal_preview: vn_mf_RscPicture
		{
			idc = VN_TR_CHARINFO_MEDAL_RIBBON_IDC;

			x = UIW(14.5);
			y = UIH(15.2);
			w = UIW(3.2);
			h = UIH(5.66);
			
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			
			text = "";
			tooltip = "";
		};
	};
};

//Big Sheet with Polaroid and Map at Bottom
class vn_tr_missionInfoPolaroid_base : vn_mf_RscControlsGroupNoScrollbarHV
{
	idc = VN_TR_MISSIONSHEET_IDC;
	// onLoad = "(_this#0) ctrlenable false;";	//No clue anymore, why i added this. Just leaving it in, maybe i remember one day.
	//onLoad = "";
	
	x = VN_TR_MISSIONSHEET_X;
	y = VN_TR_MISSIONSHEET_Y;
	w = VN_TR_MISSIONSHEET_W;
	h = VN_TR_MISSIONSHEET_H;
	
	
	
	class controls
	{
		class vn_tr_missionInfo_previewPic: vn_mf_RscPicture
		{
			idc = VN_TR_MISSION_PIC_IDC;
			x = UIW(0.9);
			y = UIH(17.2);
			w = UIW(9.9);
			h = UIH(6.9);
			
			onLoad = "(_this#0) ctrlenable false;";

			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			text = "\vn\ui_f_vietnam\ui\taskroster\img\icons\vn_icon_task_secondary.paa";
			tooltip = "";
		};
		
		class vn_tr_missionInfo_miniMap: vn_mf_RscMapControl
		{
			
			idc = VN_TR_MISSION_MAP_IDC;
			x = UIX_CR(12.1);
			y = UIH(17.6);
			w = UIW(7.4);
			h = UIH(6.95);
			
			onLoad = "(_this#0) ctrlenable false;";
			type = 101;
			style = "0x10+ 0x20";
			colorBackground[] = {0.969,0.957,0.949,1};
			colorText[] = {0,0,0,1};
			font = "TahomaB";
			sizeEx = 0.04;
			text = "#(argb,8,8,3)color(1,1,1,1)";
		};
		
		//Main
		class overlay_paperPolaroid: vn_mf_RscPicture
		{
			idc = VN_TR_MISSIONSHEET_IMG_IDC;
			x = 0;
			y = 0;
			w = VN_TR_MISSIONSHEET_POLA_W;
			h = VN_TR_MISSIONSHEET_POLA_H;
			
			colorText[] = {0.95,0.95,0.95,1};
			colorBackground[] = {1,1,1,1};
			
			text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_missionsheet_P_M_1.paa";		//TYPE 1
			//text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_missionsheet_P_M_2.paa";	//TYPE 2
			//text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_missionsheet_P_M_3.paa";	//TYPE 3
			tooltip = "";
		};
		
		class mission_name: vn_mf_RscText
		{
			idc = VN_TR_MISSIONSHEET_NAME_IDC;
			x = UIW(2.25);
			y = UIH(3.5);
			w = UIW(15);
			h = UIH(1.8);
			style = "0x10 + 0x0200";
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {1,0,0,0.0};
			shadow = 0;
			text = "Mission Name";
			font = USEDFONT_B;
			sizeEx = TXT_CST(0.9);
			tooltip = "";
		};
		
		class mission_desc: vn_mf_RscText
		{
			idc = VN_TR_MISSIONSHEET_DESC_IDC;
			x = UIW(2.25);
			y = UIH(5.45);
			w = UIW(15);
			h = UIH(3.6);
			style = "0x10 + 0x0200";
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {1,0,0,0.0};
			shadow = 0;
			text = "Mission Description";
			font = USEDFONT;
			sizeEx = TXT_CST(0.75);
			tooltip = "";
		};
		
		class mission_tasks: vn_mf_RscStructuredText
		{
			idc = VN_TR_MISSIONSHEET_TASKS_IDC;
			x = UIW(2.25);
			y = UIH(9.25);
			w = UIW(15);
			h = UIH(1);
			style = "0x10 + 0x0200";
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {1,0,0,0.0};
			shadow = 0;
			text = "";
			font = USEDFONT;
			tooltip = "";
			
			size = TXT_M;
		};
		class mission_tasks_list: vn_mf_RscListBox
		{
			idc = VN_TR_MISSIONSHEET_TASKS_LIST_IDC;
			onLBSelChanged = _this call vn_mf_fnc_tr_listboxtask_select;
			x = UIW(2.25);
			y = UIH(10.25);
			w = UIW(15);
			h = UIH(5.05);
			colorBackground[] = {0,0,0,0};
			colorSelectBackground[] = {0.5,0.5,0.5,0.4}; // Selected item fill color
			colorSelectBackground2[] = {0.5,0.5,0.5,0.4};
			colorText[] = {0,0,0,1};
			colorPicture[] = {0,0,0,1};
			/* sizeEx = TXT_S;
			rowHeight = UIH(1); */
		};
		
		class CoordsText: vn_mf_RscText
		{
			idc = VN_TR_MISSIONSHEET_COORDS_IDC;
			x = UIW(2.25);
			y = UIH(15.25);
			w = UIW(8.5);
			h = UIH(1.1);
			
			style = "0x10 + 0x0200";
			
			colorText[] = {0.1,0.1,0.1,1.0};
			colorBackground[] = {0.0,0.0,0.0,0.0};
			shadow = 0;
			font = "EtelkaMonospacePro";
			sizeEx = TXT_L;
			text = "0m";
			// tooltip = "Coordinates - Format: XXXYYY";
			tooltip = "Distance to Mission";
		};
		
		class btn_mission_setActive: vn_mf_RscButton
		{
			idc = VN_TR_MISSION_ACTIVATE_IDC;
			
			x = UIW(10.25);
			y = UIH(15.25);
			w = UIW(8.5);
			h = UIH(1.1);
			
			sizeEx = TXT_M;
			
			colorText[] = {0,0,0,1};
			colorDisabled[] = {0,0,0,0.0};
			colorBackground[] = {0,0,0,0.02};
			colorFocused[] = {0,0,0,0.1};
			
			onButtonClick = "call vn_mf_fnc_tr_mission_setActive;";
			// MouseButtonDown = "";	//No _this param given
			text = "make active";
			tooltip = "Set this mission as active.";
		};
	};
};

class vn_tr_MainInfo_base : vn_mf_RscControlsGroupNoScrollbarHV
{
	idc = VN_TR_MAININFO_IDC;
	//onLoad = "(_this#0) ctrlenable false;";
	onLoad = "";
	
	x = VN_TR_SHEET_R_X;
	y = VN_TR_SHEET_R_Y;
	w = VN_TR_SHEET_R_W;
	h = VN_TR_SHEET_R_H;
	
	class controls
	{
		class mainInfoBackground: vn_mf_RscPicture
		{
			idc = -1;
			x = UIW(0);
			y = UIH(0);
			w = VN_TR_SHEET_L_W;
			h = VN_TR_SHEET_L_H;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			text = "\vn\ui_f_vietnam\ui\taskroster\img\tr_mainInfo.paa";
			tooltip = "";
		};
		
		
		//////////////////VN_TR_MAININFO__IDC
		class groupLogo: vn_mf_RscPicture
		{
			idc = VN_TR_MAININFO_IMG_IDC;
			x = UIW(2.4);
			y = UIH(2);
			w = UIW(3);
			h = UIH(3);
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,1,1,1};
			text = "\vn\ui_f_vietnam\ui\taskroster\img\logos\Logo_MikeForce_HL.paa";
			tooltip = "";
		};
		
		class text_top: vn_mf_RscStructuredText
		{
			idc = VN_TR_MAININFO_TXT_TOP_IDC;
			x = UIW(5.5);
			y = UIH(2);
			w = UIW(11.5);
			h = UIH(3);
			
			// style = "0x10 + 0x0200";
			
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {0,0,0,0.0};
			text = "";
			size = UIH(1.075);
			tooltip = "";
			class Attributes
			{
				align = "left";
				valign = "middle";
				color = "#000000";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};
		class GroupTextMid: vn_mf_RscControlsGroup
		{
			idc = -1;
			x = UIW(2.4);
			y = UIH(5.1);
			w = UIW(15);
			h = UIH(11);
			class controls
			{
				class text_mid: vn_mf_RscStructuredText
				{
					idc = VN_TR_MAININFO_TXT_MID_IDC;
					x = 0;
					y = 0;
					w = UIW(14.5);
					h = UIH(11.5);
					colorText[] = {0.1,0.1,0.1,0.9};
					text = "";
					size = TXT_S;
					tooltip = "";
					class Attributes
					{
						align = "left";
						color = "#000000";
						colorLink = "#D09B43";
						font = USEDFONT;
						size = 1;
						shadow = 0;
					};
				}; 
			};
		};
		class RolesHeader: vn_mf_RscControlsGroupNoScrollbarH
		{
			idc = -1;
			x = UIW(2.4);
			y = UIH(16.2);
			w = UIW(15);
			h = UIH(0.75);
			class controls
			{
				class Name: vn_mf_RscStructuredText
				{
					text = $STR_vn_mf_taskRoster_Main_rolesHeaderName;
					x = 0;
					y = 0;
					w = UIW(3);
					h = UIH(0.75);
					size = TXT_S;
					class Attributes
					{
						align = "left";
						color = "#000000";
						colorLink = "#D09B43";
						font = USEDFONT;
						size = 1;
						shadow = 0;
					};
				};
				class Tasks: Name
				{
					text = $STR_vn_mf_taskRoster_Main_rolesHeaderTasks;
					x = UIW(3);
					w = UIW(6.5);
				};
				class Players: Name
				{
					text = $STR_vn_mf_taskRoster_Main_rolesHeaderPlayers;
					x = UIW(9.5);
					w = UIW(5.5);
				};
			};
		};
		class RolesGroup: rolesHeader
		{
			idc = VN_TR_MAININFO_GRP_ROLES_IDC;
			y = UIH(17);
			h = UIH(5.3);
			class controls {};
		};
	};
};