import RscActivePicture;
import RscButtonArsenal;
import RscButtonMenu;
import RscControlsGroup;
import RscControlsGroupNoScrollbars;
import RscEdit;
import RscFrame;
import RscListBox;
import RscListNBox;
import RscMessageBox;
import RscPicture;
import RscProgress;
import RscText;
import RscTitle;


class vn_mf_garage_disp_garage
{
	idd = -1;
	enableSimulation = 1;
	onLoad = "with uiNamespace do { ['Init', _this] call (missionNamespace getVariable 'vn_mf_fnc_garage_open')}";
	onUnload = "with uiNamespace do { ['Exit', _this] call (missionNamespace getVariable 'vn_mf_fnc_garage_open')}";
	icon = "\A3\Ui_f\data\Logos\a_64_ca.paa";
	logo = "\A3\Ui_f\data\Logos\arsenal_1024_ca.paa";
	class ControlsBackground
	{
		class BlackLeft: RscText
		{
			colorBackground[] = {0,0,0,1};
			x = "safezoneXAbs";
			y = "safezoneY";
			w = "safezoneXAbs - safezoneX";
			h = "safezoneH";
		};
		class BlackRight: BlackLeft
		{
			x = "safezoneX + safezoneW";
		};
		class MouseArea: RscText
		{
			idc = 899;
			style = 16;
			x = "safezoneX";
			y = "safezoneY";
			w = "safezoneW";
			h = "safezoneH";
		};
	};
	class Controls
	{
		class ArrowLeft: RscButton
		{
			idc = 992;
			text = "-";
			x = -1;
			y = -1;
			w = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ArrowRight: ArrowLeft
		{
			idc = 993;
			text = "+";
			x = -1;
			y = -1;
			w = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class BackgroundLeft: RscText
		{
			fade = 1;
			idc = 994;
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.5};
		};
		class BackgroundRight: BackgroundLeft
		{
			idc = 995;
			x = "safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class LineIcon: RscFrame
		{
			fade = 1;
			idc = 1803;
			x = -1;
			y = -1;
			w = 0;
			h = 0;
			colorText[] = {0,0,0,1};
		};
		class LineTabLeft: RscText
		{
			fade = 1;
			idc = 1804;
			x = -1;
			y = -1;
			w = "0.6 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,1};
		};
		class LineTabLeftSelected: RscText
		{
			idc = 1805;
			x = "safezoneX";
			y = -1;
			w = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.8};
		};
		class LineTabRight: LineTabLeft
		{
			idc = 1806;
		};
		class Tabs: RscFrame
		{
			fade = 1;
			idc = 1800;
			x = "safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "40 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,0};
		};
		class FrameLeft: RscFrame
		{
			fade = 1;
			idc = 1801;
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorText[] = {0,0,0,1};
		};
		class FrameRight: FrameLeft
		{
			fade = 1;
			idc = 1802;
			x = "safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
		};
		class Load: RscProgress
		{
			fade = 1;
			idc = 990;
			style = 0;
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			colorBar[] = {1,1,1,1};
			colorFrame[] = {0,0,0,1};
			x = "safezoneX";
			y = "safezoneY + safezoneH - 0.0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "safezoneW";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class LoadCargo: Load
		{
			fade = 1;
			idc = 991;
			x = "safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + safezoneH - 11.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class Message: RscText
		{
			fade = 1;
			idc = 996;
			x = "safezoneX + (0.5 * safezoneW) - (0.5 * ((safezoneW - 36 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) max 0.4))";
			y = "21.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "((safezoneW - 36 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) max 0.4)";
			h = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.7};
			style = 2;
			shadow = 0;
			text = "";
			sizeEx = "0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class Space: RscControlsGroup
		{
			x = "safezoneX + safezoneW * 0.5 - 4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY";
			show = 0;
			idc = 27903;
			w = "8.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls
			{
				class SpaceArsenalBackground: RscText
				{
					idc = 26603;
					x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.7};
				};
				class SpaceArsenal: RscActivePicture
				{
					idc = 26803;
					text = "\a3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\spaceArsenal_ca.paa";
					x = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					tooltip = "$STR_A3_Arsenal";
				};
				class SpaceGarageBackground: SpaceArsenalBackground
				{
					idc = 26604;
					x = "4.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "4 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.7};
				};
				class SpaceGarage: SpaceArsenal
				{
					idc = 26804;
					text = "\a3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\spaceGarage_ca.paa";
					x = "5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "1.99996 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					tooltip = "$STR_A3_Garage";
				};
			};
		};
		class ControlBar: RscControlsGroupNoScrollbars
		{
			w = "safezoneW";
			idc = 44046;
			x = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
			y = "23.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls
			{
				class ButtonClose: RscButtonMenu
				{
					idc = 44448;
					text = "$STR_DISP_CLOSE";
					x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.2) - 0.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					shortcuts[] = {"0x00050000 + 1"};
					tooltip = "$STR_A3_RscDisplayGarage_ButtonClose_tooltip";
				};
				class ButtonInterface: ButtonClose
				{
					idc = 44151;
					text = "$STR_CA_HIDE";
					x = "2 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					w = "((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1) - 0.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					tooltip = "$STR_A3_RscDisplayArsenal_ButtonInterface_tooltip";
				};
				class ButtonRandom: ButtonInterface
				{
					idc = 44150;
					text = "$STR_A3_RscDisplayArsenal_ButtonRandom";
					x = "3 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					tooltip = "$STR_A3_RscDisplayGarage_ButtonRandom_tooltip";
				};
				class ButtonSave: ButtonInterface
				{
					idc = 44146;
					text = "$STR_DISP_INT_SAVE";
					x = "4 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					tooltip = "$STR_A3_RscDisplayGarage_ButtonSave_tooltip";
				};
				class ButtonLoad: ButtonInterface
				{
					idc = 44147;
					text = "$STR_DISP_INT_LOAD";
					x = "5 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					tooltip = "$STR_A3_RscDisplayGarage_ButtonLoad_tooltip";
				};
				class ButtonExport: ButtonInterface
				{
					idc = 44148;
					text = "$STR_A3_RscDisplayArsenal_ButtonExport";
					x = "6 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					tooltip = "$STR_A3_RscDisplayGarage_ButtonExport_tooltip";
				};
				class ButtonImport: ButtonInterface
				{
					idc = 44149;
					text = "$STR_A3_RscDisplayArsenal_ButtonImport";
					x = "7 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					tooltip = "$STR_A3_RscDisplayGarage_ButtonImport_tooltip";
				};
				class ButtonTry: ButtonInterface
				{
					idc = 44347;
					text = "$STR_A3_RscDisplayArsenal_ButtonOK";
					x = "8 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					tooltip = "$STR_A3_RscDisplayGarage_ButtonTry_tooltip";
					shortcuts[] = {"0x00050000 + 0",28,57,156};
				};
				class ButtonOK: ButtonInterface
				{
					idc = 44346;
					text = "$STR_DISP_CLOSE";
					x = "9 * 	((safezoneW - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) * 0.1)";
					tooltip = "$STR_A3_RscDisplayGarage_ButtonOK_tooltip";
				};
			};
		};
		class Info: RscControlsGroup
		{
			x = "safezoneX + safezoneW - 20.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + safezoneH - 4.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			fade = 1;
			idc = 25815;
			w = "17.6 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls
			{
				class InfoBackground: RscText
				{
					idc = 24515;
					x = "2.6 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,1};
				};
				class InfoName: RscText
				{
					idc = 24516;
					x = "2.6 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class InfoAuthor: RscText
				{
					idc = 24517;
					x = "2.6 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {1,1,1,0.5};
					sizeEx = "0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class DLCBackground: RscText
				{
					fade = 1;
					idc = 24518;
					x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.5};
				};
				class DLCIcon: RscActivePicture
				{
					enabled = 0;
					fade = 1;
					color[] = {1,1,1,1};
					colorActive[] = {1,1,1,1};
					idc = 24715;
					text = "#(argb,8,8,3)color(1,1,1,1)";
					x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "2.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
			};
		};
		class Stats: RscControlsGroupNoScrollbars
		{
			x = "safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + safezoneH - 10.6 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			fade = 1;
			enable = 0;
			idc = 28644;
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "6 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls
			{
				class StatsBackground: RscText
				{
					idc = 27347;
					x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "6 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.5};
				};
				class Stat1: RscProgress
				{
					colorBar[] = {1,1,1,1.0};
					colorFrame[] = {0,0,0,0};
					idc = 27348;
					x = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class Stat2: Stat1
				{
					idc = 27349;
					x = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class Stat3: Stat1
				{
					idc = 27350;
					x = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class Stat4: Stat1
				{
					idc = 27351;
					x = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "3.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class Stat5: Stat1
				{
					idc = 27352;
					x = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "4.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class StatText1: RscText
				{
					shadow = 0;
					colorShadow[] = {1,1,1,1.0};
					idc = 27353;
					x = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {0,0,0,1};
					colorBackground[] = {1,1,1,0.1};
					sizeEx = "0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class StatText2: StatText1
				{
					idc = 27354;
					x = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {0,0,0,1};
					colorBackground[] = {1,1,1,0.1};
					sizeEx = "0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class StatText3: StatText1
				{
					idc = 27355;
					x = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {0,0,0,1};
					colorBackground[] = {1,1,1,0.1};
					sizeEx = "0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class StatText4: StatText1
				{
					idc = 27356;
					x = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "3.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {0,0,0,1};
					colorBackground[] = {1,1,1,0.1};
					sizeEx = "0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class StatText5: StatText1
				{
					idc = 27357;
					x = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "4.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "14 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "0.9 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorText[] = {0,0,0,1};
					colorBackground[] = {1,1,1,0.1};
					sizeEx = "0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
			};
		};
		class MouseBlock: RscText
		{
			idc = 898;
			style = 16;
			x = "safezoneX";
			y = "safezoneY";
			w = "safezoneW";
			h = "safezoneH";
		};
		class Template: RscControlsGroup
		{
			fade = 1;
			idc = 35919;
			x = "10 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
			y = "0.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "20 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "22.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls
			{
				class Title: RscTitle
				{
					style = 0;
					colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
					idc = 34619;
					text = "";
					x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "20 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class MainBackground: RscText
				{
					idc = 34622;
					x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "20 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "20 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.8};
				};
				class Column1: RscText
				{
					idc = 34620;
					x = "0.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {1,1,1,0.2};
				};
				class Column2: RscText
				{
					idc = 34623;
					x = "9.05 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "1.9 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {1,1,1,0.1};
				};
				class Column3: RscText
				{
					idc = 34624;
					x = "12.85 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "1.9 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {1,1,1,0.1};
				};
				class Column4: RscText
				{
					idc = 34625;
					x = "15.7 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "0.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {1,1,1,0.1};
				};
				class Column5: RscText
				{
					idc = 34626;
					x = "17.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "0.95 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {1,1,1,0.1};
				};
				class TextName: RscText
				{
					style = 1;
					idc = 34621;
					text = "$STR_DISP_GAME_NAME";
					x = "0.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "5.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.2};
					sizeEx = "0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class EditName: RscEdit
				{
					idc = 35020;
					x = "6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "19.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "13.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class ValueName: RscListNBox
				{
					columns[] = {0.0,0.45,0.55,0.65,0.75,0.8,0.85,0.9,0.95};
					idc = 35119;
					x = "0.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "19 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "17.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					sizeEx = "0.8 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class ButtonOK: RscButtonMenu
				{
					idc = 36019;
					text = "$STR_DISP_OK";
					x = "15 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "21.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class ButtonCancel: RscButtonMenu
				{
					idc = 36020;
					text = "$STR_DISP_CANCEL";
					x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "21.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
				class ButtonDelete: RscButtonMenu
				{
					idc = 36021;
					text = "$STR_DISP_DELETE";
					x = "9.9 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "21.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};
			};
		};
		class MessageBox: RscMessageBox{};
		class TabCar: RscButtonArsenal
		{
			idc = "930 + 								0";
			idcx = 930;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\Car_ca.paa";
			x = "safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 0.04 + 0 * 0.04";
			w = "(1.4 * 		2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "(1.4 * 		2) * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_Car";
		};
		class IconCar: RscPicture
		{
			idc = "900 + 								0";
			idcx = 900;
			x = -1;
			y = -1;
			w = "(1.4 * 		2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			color[] = {1,1,1,0.8};
		};
		class ListCar: RscListBox
		{
			idc = "960 + 							0";
			idcx = 960;
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0};
			colorSelectBackground[] = {1,1,1,0.5};
			colorSelectBackground2[] = {1,1,1,0.5};
			colorPictureSelected[] = {1,1,1,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorPictureRightSelected[] = {1,1,1,1};
		};
		class ListDisabledCar: RscText
		{
			idc = "860 + 							0";
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "$STR_lib_info_na";
			style = 2;
			show = 0;
			colorText[] = {1,1,1,0.15};
			shadow = 0;
		};
		class TabTank: RscButtonArsenal
		{
			idc = "930 + 								1";
			idcx = 931;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\Tank_ca.paa";
			x = "safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 0.04 + 3 * 0.04";
			w = "(1.4 * 		2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "(1.4 * 		2) * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_Tank";
		};
		class IconTank: RscPicture
		{
			idc = "900 + 								1";
			idcx = 901;
			x = -1;
			y = -1;
			w = "(1.4 * 		2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			color[] = {1,1,1,0.8};
		};
		class ListTank: RscListBox
		{
			idc = "960 + 							1";
			idcx = 961;
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0};
			colorSelectBackground[] = {1,1,1,0.5};
			colorSelectBackground2[] = {1,1,1,0.5};
			colorPictureSelected[] = {1,1,1,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorPictureRightSelected[] = {1,1,1,1};
		};
		class ListDisabledTank: RscText
		{
			idc = "860 + 							1";
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "$STR_lib_info_na";
			style = 2;
			show = 0;
			colorText[] = {1,1,1,0.15};
			shadow = 0;
		};
		class TabHelicopter: RscButtonArsenal
		{
			idc = "930 + 							2";
			idcx = 932;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\Helicopter_ca.paa";
			x = "safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 0.04 + 6 * 0.04";
			w = "(1.4 * 		2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "(1.4 * 		2) * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_Helicopter";
		};
		class IconHelicopter: RscPicture
		{
			idc = "900 + 							2";
			idcx = 902;
			x = -1;
			y = -1;
			w = "(1.4 * 		2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			color[] = {1,1,1,0.8};
		};
		class ListHelicopter: RscListBox
		{
			idc = "960 + 						2";
			idcx = 962;
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0};
			colorSelectBackground[] = {1,1,1,0.5};
			colorSelectBackground2[] = {1,1,1,0.5};
			colorPictureSelected[] = {1,1,1,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorPictureRightSelected[] = {1,1,1,1};
		};
		class ListDisabledHelicopter: RscText
		{
			idc = "860 + 						2";
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "$STR_lib_info_na";
			style = 2;
			show = 0;
			colorText[] = {1,1,1,0.15};
			shadow = 0;
		};
		class TabPlane: RscButtonArsenal
		{
			idc = "930 + 								3";
			idcx = 933;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\Plane_ca.paa";
			x = "safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 0.04 + 9 * 0.04";
			w = "(1.4 * 		2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "(1.4 * 		2) * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_Plane";
		};
		class IconPlane: RscPicture
		{
			idc = "900 + 								3";
			idcx = 903;
			x = -1;
			y = -1;
			w = "(1.4 * 		2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			color[] = {1,1,1,0.8};
		};
		class ListPlane: RscListBox
		{
			idc = "960 + 							3";
			idcx = 963;
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0};
			colorSelectBackground[] = {1,1,1,0.5};
			colorSelectBackground2[] = {1,1,1,0.5};
			colorPictureSelected[] = {1,1,1,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorPictureRightSelected[] = {1,1,1,1};
		};
		class ListDisabledPlane: RscText
		{
			idc = "860 + 							3";
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "$STR_lib_info_na";
			style = 2;
			show = 0;
			colorText[] = {1,1,1,0.15};
			shadow = 0;
		};
		class TabNaval: RscButtonArsenal
		{
			idc = "930 + 								4";
			idcx = 934;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\Naval_ca.paa";
			x = "safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 0.04 + 12 * 0.04";
			w = "(1.4 * 		2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "(1.4 * 		2) * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_Naval";
		};
		class IconNaval: RscPicture
		{
			idc = "900 + 								4";
			idcx = 904;
			x = -1;
			y = -1;
			w = "(1.4 * 		2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			color[] = {1,1,1,0.8};
		};
		class ListNaval: RscListBox
		{
			idc = "960 + 							4";
			idcx = 964;
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0};
			colorSelectBackground[] = {1,1,1,0.5};
			colorSelectBackground2[] = {1,1,1,0.5};
			colorPictureSelected[] = {1,1,1,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorPictureRightSelected[] = {1,1,1,1};
		};
		class ListDisabledNaval: RscText
		{
			idc = "860 + 							4";
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "$STR_lib_info_na";
			style = 2;
			show = 0;
			colorText[] = {1,1,1,0.15};
			shadow = 0;
		};
		class TabStatic: RscButtonArsenal
		{
			idc = "930 + 							5";
			idcx = 935;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\Static_ca.paa";
			x = "safezoneX + 0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 0.04 + 15 * 0.04";
			w = "(1.4 * 		2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "(1.4 * 		2) * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_Static";
		};
		class IconStatic: RscPicture
		{
			idc = "900 + 							5";
			idcx = 905;
			x = -1;
			y = -1;
			w = "(1.4 * 		2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			color[] = {1,1,1,0.8};
		};
		class ListStatic: RscListBox
		{
			idc = "960 + 						5";
			idcx = 965;
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0};
			colorSelectBackground[] = {1,1,1,0.5};
			colorSelectBackground2[] = {1,1,1,0.5};
			colorPictureSelected[] = {1,1,1,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorPictureRightSelected[] = {1,1,1,1};
		};
		class ListDisabledStatic: RscText
		{
			idc = "860 + 						5";
			x = "safezoneX + (1 + 1.5 * 	2) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "safezoneH - 2.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "$STR_lib_info_na";
			style = 2;
			show = 0;
			colorText[] = {1,1,1,0.15};
			shadow = 0;
		};
		class TabAnimationSources: RscButtonArsenal
		{
			idc = "930 + 					19";
			idcx = 949;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\AnimationSources_ca.paa";
			x = "safezoneX + safezoneW - 2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 0.04 + 0 * 0.04";
			w = "(1.4 * 	1) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "(1.4 * 	1) * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_AnimationSources";
		};
		class IconAnimationSources: RscPicture
		{
			idc = "900 + 					19";
			idcx = 919;
			x = -1;
			y = -1;
			w = "(1.4 * 	1) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			color[] = {1,1,1,0.8};
		};
		class ListAnimationSources: RscListBox
		{
			idc = "960 + 				19";
			idcx = 979;
			x = "safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "15 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0};
			colorSelectBackground[] = {1,1,1,0.5};
			colorSelectBackground2[] = {1,1,1,0.5};
			colorPictureSelected[] = {1,1,1,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorPictureRightSelected[] = {1,1,1,1};
		};
		class ListDisabledAnimationSources: RscText
		{
			idc = "860 + 				19";
			x = "safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "15 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "$STR_lib_info_na";
			style = 2;
			show = 0;
			colorText[] = {1,1,1,0.15};
			shadow = 0;
		};
		class TabTextureSources: RscButtonArsenal
		{
			idc = "930 + 					20";
			idcx = 950;
			text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayGarage\TextureSources_ca.paa";
			x = "safezoneX + safezoneW - 2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 0.04 + 1.5 * 0.04";
			w = "(1.4 * 	1) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "(1.4 * 	1) * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "$STR_A3_RscDisplayGarage_tab_TextureSources";
		};
		class IconTextureSources: RscPicture
		{
			idc = "900 + 					20";
			idcx = 920;
			x = -1;
			y = -1;
			w = "(1.4 * 	1) * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			color[] = {1,1,1,0.8};
		};
		class ListTextureSources: RscListBox
		{
			idc = "960 + 				20";
			idcx = 980;
			x = "safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "15 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "1.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0};
			colorSelectBackground[] = {1,1,1,0.5};
			colorSelectBackground2[] = {1,1,1,0.5};
			colorPictureSelected[] = {1,1,1,1};
			colorSelect[] = {1,1,1,1};
			colorSelect2[] = {1,1,1,1};
			colorPictureRightSelected[] = {1,1,1,1};
		};
		class ListDisabledTextureSources: RscText
		{
			idc = "860 + 				20";
			x = "safezoneX + safezoneW - 17.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "safezoneY + 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "15 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			sizeEx = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			text = "$STR_lib_info_na";
			style = 2;
			show = 0;
			colorText[] = {1,1,1,0.15};
			shadow = 0;
		};
		delete TabPrimaryWeapon;
		delete IconPrimaryWeapon;
		delete ListPrimaryWeapon;
		delete TabSecondaryWeapon;
		delete IconSecondaryWeapon;
		delete ListSecondaryWeapon;
		delete TabHandgun;
		delete IconHandgun;
		delete ListHandgun;
		delete TabUniform;
		delete IconUniform;
		delete ListUniform;
		delete TabVest;
		delete IconVest;
		delete ListVest;
		delete TabBackpack;
		delete IconBackpack;
		delete ListBackpack;
		delete TabHeadgear;
		delete IconHeadgear;
		delete ListHeadgear;
		delete TabGoggles;
		delete IconGoggles;
		delete ListGoggles;
		delete TabNVGs;
		delete IconNVGs;
		delete ListNVGs;
		delete TabBinoculars;
		delete IconBinoculars;
		delete ListBinoculars;
		delete TabMap;
		delete IconMap;
		delete ListMap;
		delete TabGPS;
		delete IconGPS;
		delete ListGPS;
		delete TabRadio;
		delete IconRadio;
		delete ListRadio;
		delete TabCompass;
		delete IconCompass;
		delete ListCompass;
		delete TabWatch;
		delete IconWatch;
		delete ListWatch;
		delete TabFace;
		delete IconFace;
		delete ListFace;
		delete TabVoice;
		delete IconVoice;
		delete ListVoice;
		delete TabInsignia;
		delete IconInsignia;
		delete ListInsignia;
		delete TabItemOptic;
		delete IconItemOptic;
		delete ListItemOptic;
		delete TabItemAcc;
		delete IconItemAcc;
		delete ListItemAcc;
		delete TabItemMuzzle;
		delete IconItemMuzzle;
		delete ListItemMuzzle;
		delete TabCargoMag;
		delete IconCargoMag;
		delete ListCargoMag;
		delete TabCargoThrow;
		delete IconCargoThrow;
		delete ListCargoThrow;
		delete TabCargoPut;
		delete IconCargoPut;
		delete ListCargoPut;
		delete TabCargoMisc;
		delete IconCargoMisc;
		delete ListCargoMisc;
	};
};