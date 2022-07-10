//included by "ui_tr_base.hpp"

class vn_tr_disp_selectTeam
{
	name = "vn_tr_disp_selectTeam";
	//scriptName = "vn_tr_disp_selectTeam";
	//scriptPath = "GUI";
	//If already opened -> Recalling it -> Reloading the Dialog (e.g. like updating the view, without "closing" it)
	onLoad = "[""onLoad"",_this,""vn_tr_disp_selectTeam"",''] call 	(uinamespace getvariable 'BIS_fnc_initDisplay'); _this call vn_mf_fnc_tr_selectTeam_init;";
	onUnload = "[""onUnload"",_this,""vn_tr_disp_selectTeam"",''] call 	(uinamespace getvariable 'BIS_fnc_initDisplay'); [] spawn vn_mf_fnc_tr_overview_init;";
	idd = VN_TR_SELECTTEAM_IDC;
	movingEnable = 1;
	enableSimulation = 1;
	
	
	class ControlsBackground
	{
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
		};
		
		//MUST be in the background, otherwise it could "pop up", when clicking on it, covering up the cordles (silly Arma, y u do dis? :sad:)
		class vn_sheet_clean_R: vn_sheet_clean_R_base
		{
			idc = -1;
		};
	};
	
	
	
	class Controls
	{
		///////////////////Right:
		//Teamselection
		class vn_tr_selectTeam: vn_tr_selectTeam_base
		{
			idc = VN_TR_SELECTTEAM_TEAM_SELECTION_IDC;
		};
		
		///////////////////Left:
		class activeTeam_logo: vn_mf_RscPicture
		{
			idc = VN_TR_SELECTTEAM_TEAM_LOGO_IDC;
			x = UIX_CL(12.5);
			y = UIY_CU(10.5);
			w = UIW(6);
			h = UIH(6);
			
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			text = "";
			tooltip = "";
		};
		
		class activeTeam_description: vn_mf_RscStructuredText
		{
			idc = VN_TR_SELECTTEAM_TEAM_DESC_IDC;
			x = UIX_CL(17.5);
			y = UIY_CU(4.125);
			w = UIW(16);
			h = UIH(1);
			
			colorText[] = {0,0,0,0.9};
			colorBackground[] = {0,0,0,0.0};
			sizeEx = TXT_S;
			text = "";
			tooltip = "";
			class Attributes
			{
				align = "center";
				color = "#000000";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1.1;
				shadow = 0;
			};
		};
		
		class activeTeam_text: vn_mf_RscStructuredText
		{
			idc = VN_TR_SELECTTEAM_TEAM_TEXT_IDC;
			x = UIX_CL(17.5);
			y = UIY_CU(3);
			w = UIW(16);
			h = UIH(12);
			
			colorText[] = {0,0,0,1};
			colorBackground[] = {0,0,0,0.0};
			sizeEx = TXT_XS;
			text = "";
			tooltip = "";
			class Attributes
			{
				align = "left";
				color = "#000000";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 0.625;
				shadow = 0;
			};
		};
		
		
		class btn_accept: vn_mf_RscButton
		{
			idc = -1;
			x = UIX_CL(8.5);
			y = UIY_CD(9.5);
			w = UIW(7);
			h = UIH(1.1);
			
			text = "ACCEPT";
			font = USEDFONT;
			sizeEx = TXT_L;
			onButtonClick = "[] call vn_mf_fnc_tr_selectTeam_set; (ctrlParent param[0]) closeDisplay 1;";
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {1,0,0,0.0};
			colorBackgroundActive[] = {0,0,0,0.05};
			colorFocused[] = {0,0,0,0.01};
		};
		
		class btn_cancel: vn_mf_RscButton
		{
			idc = -1;
			x = UIX_CL(17.5);
			y = UIY_CD(9.5);
			w = UIW(7);
			h = UIH(1.1);
			
			text = "CANCEL";
			font = USEDFONT;
			sizeEx = TXT_L;
			onButtonClick = (ctrlParent param[0]) closeDisplay 2;
			colorText[] = {0.1,0.1,0.1,0.9};
			colorBackground[] = {1,0,0,0.0};
			colorBackgroundActive[] = {0,0,0,0.05};
			colorFocused[] = {0,0,0,0.01};
		};
		
		
		//ALWAYS AT THE BOTTOM/LAST OF THE CONTROLS!
		class folder_cordels: vn_tr_cordels
		{};
	};
};