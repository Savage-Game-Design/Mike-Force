class vn_mf_RscDisplayExample
{
	idd = VN_MF_RSCDISPLAYEXAMPLE_IDD; // defined in config\ui\ui_def_idc.hpp
	VN_MF_INIT_DISPLAY(vn_mf_RscDisplayExample) // handles onLoad and onUnload UIEH
	class objects
	{
	};
	class controlsBackground
	{
	};
	class controls
	{
		class LT: vn_mf_RscStructuredText
		{
			idc = VN_MF_RSCDISPLAYEXAMPLE_LT_IDC;
			style = ST_LEFT;
			text = "LEFT TOP";
			color[] = {1,1,1,1};
			colorBackground[] = {1,0,0,0.25};
			x = UIX_LR(0);
			y = UIY_TD(0);
			w = UIW(40);
			h = UIH(25);
			onMouseEnter = "ctrlSetFocus (_this#0)";
			class Attributes
			{
				align = "left";
				color = "#ffffff";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};
		class CT: LT
		{
			idc = VN_MF_RSCDISPLAYEXAMPLE_CT_IDC;
			text = "CENTER TOP";
			colorBackground[] = {0,1,0,0.25};
			x = UIX_CL(20);
			class Attributes
			{
				align = "center";
				color = "#ffffff";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};
		class RT: LT
		{
			idc = VN_MF_RSCDISPLAYEXAMPLE_RT_IDC;
			text = "RIGHT TOP";
			colorBackground[] = {0,0,1,0.25};
			x = UIX_RL(40);
			class Attributes
			{
				align = "right";
				color = "#ffffff";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};
		#define QUOTE(S) #S
		#define MTXT(S) QUOTE(<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>S)
		class LM: LT
		{
			idc = VN_MF_RSCDISPLAYEXAMPLE_LM_IDC;
			text = MTXT(LEFT MIDDLE);
			colorBackground[] = {1,1,0,0.25};
			x = UIX_LR(0);
			y = UIY_CU(12.5);
			class Attributes
			{
				align = "left";
				valign = "middle";
				color = "#ffffff";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};
		class CM: LM
		{
			idc = VN_MF_RSCDISPLAYEXAMPLE_CM_IDC;
			text = MTXT(CENTER MIDDLE);
			colorBackground[] = {0,1,1,0.25};
			x = UIX_CL(20);
			class Attributes
			{
				align = "center";
				valign = "middle";
				color = "#ffffff";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};
		class RM: LM
		{
			idc = VN_MF_RSCDISPLAYEXAMPLE_RM_IDC;
			text = MTXT(RIGHT MIDDLE);
			colorBackground[] = {1,0,1,0.25};
			x = UIX_RL(40);
			class Attributes
			{
				align = "right";
				valign = "middle";
				color = "#ffffff";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};
		#define BTXT(S) QUOTE(<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>S)
		class LB: LT
		{
			idc = VN_MF_RSCDISPLAYEXAMPLE_LB_IDC;
			text = BTXT(LEFT BOTTOM);
			colorBackground[] = {0,0,1,0.25};
			x = UIX_LR(0);
			y = UIY_BU(25);
			class Attributes
			{
				align = "left";
				valign = "bottom";
				color = "#ffffff";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};
		class CB: LB
		{
			idc = VN_MF_RSCDISPLAYEXAMPLE_CB_IDC;
			text = BTXT(CENTER BOTTOM);
			colorBackground[] = {1,0,0,0.25};
			x = UIX_CL(20);
			class Attributes
			{
				align = "center";
				valign = "bottom";
				color = "#ffffff";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};
		class RB: LB
		{
			idc = VN_MF_RSCDISPLAYEXAMPLE_RB_IDC;
			text = BTXT(RIGHT BOTTOM);
			colorBackground[] = {0,1,0,0.25};
			x = UIX_RL(40);
			class Attributes
			{
				align = "right";
				valign = "bottom";
				color = "#ffffff";
				colorLink = "#D09B43";
				font = USEDFONT;
				size = 1;
				shadow = 0;
			};
		};
	};
};