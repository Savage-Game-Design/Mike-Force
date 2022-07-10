////////////////////////////////////////////////////////////////////////////////////
//
//included by "ui_main.hpp"
//include all the import stuff, so we load this stuff inside scripts and use them.
//
////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
/// Styles
///////////////////////////////////////////////////////////////////////////

/*Control types*/
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102
#define CT_CHECKBOX         77

/*Static styles*/
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

/*Slider styles*/
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

/*progress bar */
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

/*Listbox styles*/
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

/*Tree styles*/
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

/*MessageBox styles*/
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4



//SafeZone stuff
//Basic
//X
#define SZX(NUM)		(NUM * safezoneW + safezoneX)
#define SZX_CL(NUM)		((0.5 - NUM) * safezoneW + safezoneX)
#define SZX_CR(NUM)		((0.5 + NUM) * safezoneW + safezoneX)
//Y
#define SZY(NUM)		(NUM * safezoneH + safezoneY)
#define SZY_CU(NUM)		((0.5 - NUM) * safezoneH + safezoneY)
#define SZY_CD(NUM)		((0.5 + NUM) * safezoneH + safezoneY)
//W+H
#define SZW(NUM)		(NUM * safezoneW)
#define SZH(NUM)		(NUM * safezoneH)



////// Scaling with InterfaceSize - But at least stays at the same size, across all Resolutions/AspectRatios
//X Calculations:
#define UIX_CALC_A		(((getResolution select 4) min 1.2) / 40)
#define UIX_CALC_B		(safezoneX + (safezoneW - ((getResolution select 7) min 1.2))/2)
#define UIX_CALC		UIX_CALC_A + UIX_CALC_B

//Y Calculations:
#define UIY_CALC_A		((((getResolution select 4) min 1.2) / 1.2) / 25)
#define UIY_CALC_B		(safezoneY + (safezoneH - (((getResolution select 7) min 1.2) / 1.2))/2)
#define UIY_CALC		UIY_CALC_A + UIY_CALC_B
//X
#define UIX(NUM)		(NUM * UIX_CALC)
#define UIX_LR(NUM)		(UIW(NUM) + safeZoneX)						//FROM Left -> Right
#define UIX_RL(NUM)		((UIW(NUM)*-1) + safeZoneX + safeZoneW)		//FROM Right -> Left
#define UIX_CR(NUM)		((NUM + 20) * UIX_CALC)						//FROM Center -> Right
#define UIX_CL(NUM)		(((NUM*-1) + 20) * UIX_CALC)				//FROM Center -> Left
//Y
#define UIY(NUM)		(NUM * UIY_CALC)
#define UIY_TD(NUM)		((UIH(NUM)) + safezoneY)					//FROM Top -> Downwards
#define UIY_BU(NUM)		((UIH(NUM)*-1) + safezoneY + safezoneH)		//FROM Bottom -> Upwards
#define UIY_CD(NUM)		((NUM + 12.5) * UIY_CALC)					//FROM Center -> Downwards
#define UIY_CU(NUM)		(((NUM*-1) + 12.5) * UIY_CALC)				//FROM Center -> Upwards
//Width/Height
#define UIW(NUM)		(NUM * UIX_CALC_A)
#define UIH(NUM)		(NUM * UIY_CALC_A)


// Colors:
#define COLOR_KEYBINDINGS_NORMAL_SELECTED [1,1,1,1]
#define COLOR_KEYBINDINGS_NORMAL_UNSELECTED [1,1,1,0.5]
#define COLOR_KEYBINDINGS_DOUBLEBIND_SELECTED [1,0,0,1]
#define COLOR_KEYBINDINGS_DOUBLEBIND_UNSELECTED [1,0,0,0.5]

//Text stuff:
#define USEDFONT "tt2020base_vn"
#define USEDFONT_B "tt2020base_vn_bold"
#define USEDFONT_ALT "tt2020style_e_vn"
#define USEDFONT_ALT_B "tt2020style_e_vn_bold"

#define CALCRESANDAR	UIY_CALC_A
#define TXT_CST(NUM)	(UIY_CALC_A * NUM)

// TT2020 size
#define TXT_XXS			(UIY_CALC_A * 0.2)
#define TXT_XS			(UIY_CALC_A * 0.4)
#define TXT_S			(UIY_CALC_A * 0.65)
#define TXT_M			(UIY_CALC_A * 0.85)
#define TXT_L			(UIY_CALC_A * 1)
#define TXT_XL			(UIY_CALC_A * 1.3)
#define TXT_XXL			(UIY_CALC_A * 1.4)



//TASK ROSTER STANDARD VALUES:
//Background folder
#define VN_TR_FOLDER_X			UIX_CL(22.2)
#define VN_TR_FOLDER_Y			UIY_CU(12.5)
#define VN_TR_FOLDER_W			UIW(44.4)
#define VN_TR_FOLDER_H			UIH(25)

//Sheet: LEFT side
#define VN_TR_SHEET_L_X			UIX_CL(19)
#define VN_TR_SHEET_L_Y			UIY_CU(12)
#define VN_TR_SHEET_L_W			UIW(19.5)
#define VN_TR_SHEET_L_H			UIH(25)

//Sheet: RIGHT side
#define VN_TR_SHEET_R_X			UIX_CR(0.5)
#define VN_TR_SHEET_R_Y			UIY_CU(12)
#define VN_TR_SHEET_R_W			UIW(19.5)
#define VN_TR_SHEET_R_H			UIH(25)

//Cordles in the center
#define VN_TR_CORDLES_X			UIX_CL(1.6)
#define VN_TR_CORDLES_Y			UIY_CU(3.9)
#define VN_TR_CORDLES_W			UIW(4.25)
#define VN_TR_CORDLES_H			UIH(7.9)

//Mission Infos:
#define VN_TR_MISSIONSHEET_X	UIX_CR(0.5)
#define VN_TR_MISSIONSHEET_Y	UIY_CU(11.9)
#define VN_TR_MISSIONSHEET_W	UIW(19.5)
#define VN_TR_MISSIONSHEET_H	UIH(25)

#define VN_TR_MISSIONSHEET_POLA_W	UIW(19.5)
#define VN_TR_MISSIONSHEET_POLA_H	UIH(25)

// onLoad and onUnload script macro:
#define VN_MF_INIT_DISPLAY(CLASSNAME) \
	onLoad = ["onLoad", _this, #CLASSNAME] call para_fnc_ui_initMissionDisplay;\
	onUnload = ["onUnload", _this, #CLASSNAME] call para_fnc_ui_initMissionDisplay;\

//Main File for IDDs and IDCs
#include "ui_def_idc.hpp"