//included by "ui_main.hpp"

//auto adjust the height of the ribbons
#define RIBBON_H(NUM)	(NUM/3.3333)

//Macro for Ribbons
#define RIBBONCTRL(NUM,INDEXX,INDEXY,WIDTH)\
class ribbon_##NUM : vn_mf_ribbon_base\
{\
	idc = VN_TR_CHARINFO_RIBBON_##NUM##_IDC;\
	\
	x = UIW((2.5+((WIDTH+0.2)*INDEXX)));\
	y = UIH((15.30+((RIBBON_H(WIDTH)+0.2)*INDEXY)));\
	w = UIW(WIDTH);\
	h = UIH(RIBBON_H(WIDTH));\
};

class vn_mf_RscPicture
{
	type = 0;
	access=0;
	idc=-1;
	x=0;
	y=0;
	w=0;
	h=0;
	style=48;
	colorBackground[]={0,0,0,0};
	colorText[]={1,1,1,1};
	font=USEDFONT;
	sizeEx=0;
	lineSpacing=0;
	text="";
};
class vn_mf_RscPictureKeepAspect: vn_mf_RscPicture
{
	style = "0x10+ 0x20+ 0x800";
};

class vn_mf_RscText
{
	idc = -1;
	type = 0;
	style = 0;
	shadow = 0;
	
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	
	text = "";
	font = USEDFONT;
	SizeEx = TXT_S;
	
	colorShadow[] = {0,0,0,0.5};
	colorText[] = {1,1,1,1.0};
	colorBackground[] = {0,0,0,0};
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
};

class vn_mf_RscStructuredText
{
	idc = -1;
	type = 13;
	style = 0;
	
	x = UIW(2);
	y = UIH(2.5);
	w = UIW(15.5);
	h = UIH(0.9);
	
	colorText[] = {0.1,0.1,0.1,0.9};
	colorBackground[] = {0,0,0,0};
	shadow = 0;
	size = TXT_M;
	text = "";
	fade = 0;
	tooltip = "";
	class Attributes
	{
		align = "left";
		color = "#000000";
		colorLink = "#D09B43";
		font = USEDFONT;
		size = 0.8;
		shadow = 0;
	};
};

class vn_mf_RscStructuredText_c: vn_mf_RscStructuredText
{
	class Attributes
	{
		align = "center";
		color = "#000000";
		colorLink = "#D09B43";
		font = USEDFONT;
		size = 0.8;
		shadow = 0;
	};
};

class vn_mf_RscStructuredText_r: vn_mf_RscStructuredText
{
	class Attributes
	{
		align = "right";
		color = "#000000";
		colorLink = "#D09B43";
		font = USEDFONT;
		size = 0.8;
		shadow = 0;
	};
};

class vn_mf_RscListNBox               
{
	idc = -1; // Control identification (without it, the control won't be displayed)
	type = CT_LISTNBOX; // Type 102
	style = ST_LEFT + LB_TEXTURES; // Style
	
	selectWithRMB = 1;	//Enable RightClick to select rows
	text = "";
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.
	
	x = UIX_CL(1);
	y = UIY_CU(1);
	w = UIW(2);
	h = UIH(2);
	
	colorSelectBackground[] = {0.5,0.5,0.5,0.4}; // Selected item fill color
	colorSelectBackground2[] = {0.5,0.5,0.5,0.4}; // Selected item fill color (oscillates between this and colorSelectBackground)
	
	sizeEx = TXT_S; // Text size
	font = USEDFONT; // Font from CfgFontFamilies
	rowHeight = UIH(1); // Row height
	borderSize = 0;
	shadow = 0; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
	
	colorText[] = {1,1,1,1}; // Text and frame color
	colorDisabled[] = {1,1,1,0.5}; // Disabled text color
	colorSelect[] = {1,1,1,1}; // Text selection color
	colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
	colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)
	
	colorPicture[] = {0.7,0.7,0.7,1};
	colorPictureSelected[] = {0.2,0.2,0.2,1};
	colorPictureDisabled[] = {0,0,0,1};
	
	tooltip = ""; // Tooltip text
	tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
	tooltipColorText[] = {1,1,1,1}; // Tooltip text color
	tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color
	
	columns[] = {0.0,0.2}; // Horizontal coordinates of columns (relative to list width, in range from 0 to 1)
	
	drawSideArrows = 0; // 1 to draw buttons linked by idcLeft and idcRight on both sides of selected line. They are resized to line height
	idcLeft = -1; // Left button IDC
	idcRight = -1; // Right button IDC
	
	period = 1; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected
	
	maxHistoryDelay = 1; // Time since last keyboard type search to reset it
	
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected
	
	disableOverflow = 1;
	// Scrollbar configuration (applied only when LB_TEXTURES style is used)
	class ListScrollBar
	{
		width = 0; // width of ListScrollBar
		height = 0; // height of ListScrollBar
		scrollSpeed = 0.01; // scrollSpeed of ListScrollBar
		
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)
		
		color[] = {1,1,1,1}; // Scrollbar color
	};
};

class vn_mf_RscListBox
{
	//access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
	idc = CT_LISTBOX; // Control identification (without it, the control won't be displayed)
	type = CT_LISTBOX; // Type is 5
	style = ST_LEFT + LB_TEXTURES; // Style
	//default = 0; // Control selected by default (only one within a display can be used)
	selectWithRMB = 1;	//Enable RightClick to select rows
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.

	
	x = UIX_CL(1);
	y = UIY_CU(1);
	w = UIW(2);
	h = UIH(2);

	colorBackground[] = {0.2,0.2,0.2,1}; // Fill color
	colorSelectBackground[] = {1,0.5,0,1}; // Selected item fill color
	colorSelectBackground2[] = {0,0,0,1}; // Selected item fill color (oscillates between this and colorSelectBackground)

	sizeEx = TXT_S; // Text size
	font = USEDFONT; // Font from CfgFontFamilies
	shadow = 0; // Shadow (0 - none, 1 - directional, color affected by colorShadow, 2 - black outline)
	colorText[] = {1,1,1,1}; // Text and frame color
	colorDisabled[] = {1,1,1,0.5}; // Disabled text color
	colorSelect[] = {1,1,1,1}; // Text selection color
	colorSelect2[] = {1,1,1,1}; // Text selection color (oscillates between this and colorSelect)
	colorShadow[] = {0,0,0,0.5}; // Text shadow color (used only when shadow is 1)

	pictureColor[] = {1,0.5,0,1}; // Picture color
	pictureColorSelect[] = {1,1,1,1}; // Selected picture color
	pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color

	tooltip = "CT_LISTBOX"; // Tooltip text
	tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
	tooltipColorText[] = {1,1,1,1}; // Tooltip text color
	tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color
	
	period = 1; // Oscillation time between colorSelect/colorSelectBackground2 and colorSelect2/colorSelectBackground when selected
	
	rowHeight = UIH(1); // Row height
	itemSpacing = 0; // Height of empty space between items
	maxHistoryDelay = 1; // Time since last keyboard type search to reset it
	canDrag = 0; // 1 (true) to allow item dragging
	
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1}; // Sound played when an item is selected
	
	// Scrollbar configuration (applied only when LB_TEXTURES style is used)
	class ListScrollBar //In older games this class is "ScrollBar"
	{
		width = 0; // width of ListScrollBar
		height = 0; // height of ListScrollBar
		scrollSpeed = 0.01; // scroll speed of ListScrollBar

		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

		color[] = {1,1,1,1}; // Scrollbar color
	};

	//onCanDestroy = "systemChat str ['onCanDestroy',_this]; true";
	//onDestroy = "systemChat str ['onDestroy',_this]; false";
	//onSetFocus = "systemChat str ['onSetFocus',_this]; false";
	//onKillFocus = "systemChat str ['onKillFocus',_this]; false";
	//onKeyDown = "systemChat str ['onKeyDown',_this]; false";
	//onKeyUp = "systemChat str ['onKeyUp',_this]; false";
	//onMouseButtonDown = "systemChat str ['onMouseButtonDown',_this]; false";
	//onMouseButtonUp = "systemChat str ['onMouseButtonUp',_this]; false";
	//onMouseButtonClick = "systemChat str ['onMouseButtonClick',_this]; false";
	//onMouseButtonDblClick = "systemChat str ['onMouseButtonDblClick',_this]; false";
	//onMouseZChanged = "systemChat str ['onMouseZChanged',_this]; false";
	//onMouseMoving = "";
	//onMouseHolding = "";

	//onLBSelChanged = "systemChat str ['onLBSelChanged',_this]; false";
	//onLBDblClick = "systemChat str ['onLBDblClick',_this]; false";
	//onLBDrag = "systemChat str ['onLBDrag',_this]; false";
	//onLBDragging = "systemChat str ['onLBDragging',_this]; false";
	//onLBDrop = "systemChat str ['onLBDrop',_this]; false";
};

class vn_mf_RscButton
{
	style = "0x02 + 0x10";
	deletable = 0;
	fade = 0;
	//access = 0;
	type = 1;
	text = "";
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0};
	colorBackground[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	colorBackgroundActive[] = {0,0,0,0.2};
	colorFocused[] = {0,0,0,0};
	colorShadow[] = {0,0,0,0};
	colorBorder[] = {0,0,0,0};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
	idc = -1;
	//style = 2;
	x = UIX_CL(1);
	y = UIY_CU(1);
	w = UIW(2);
	h = UIH(2);
	shadow = 0;
	font = USEDFONT;
	sizeEx = TXT_M;
	url = "";
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	borderSize = 0;
};

class vn_mf_RscButton_ImgSwitch
{
	default = 0;
	deletable = 0;
	fade = 0;

	type = 11;
	style = 0x30;

	idc = -1;
	x = UIX_CL(1);
	y = UIY_CU(1);
	w = UIW(2);
	h = UIH(2);

	font = USEDFONT;
	shadow = 0;
	sizeEx = TXT_M;
	url = "";

	text = "";		//Texture Normal
	textUp = "";	//Texture when mouser over
	
	tooltip = "";	//erm, a Tooltip? Those tiny boxes, that appear when you move your mouse over a console

	onButtonClick = "";
	onLoad = "";

	/////////////////// IMPORTANT! DON'T TOUCH OR OVERWRITE! /////////////////////////////////////////////
	onMouseEnter = "[1,(_this#0)] call para_c_fnc_ui_updateImg;"; //IMPORTANT! DON'T TOUCH OR OVERWRITE! //
	onMouseExit = "[0,(_this#0)] call para_c_fnc_ui_updateImg;";	 //IMPORTANT! DON'T TOUCH OR OVERWRITE! //
	/////////////////// IMPORTANT! DON'T TOUCH OR OVERWRITE! /////////////////////////////////////////////

	color[] = {1,1,1,1};
	colorText[] = {0,0,0,1};
	colorBackground[] = {0,0,0,1};
	colorActive[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};

	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};

	soundClick[] = {"",0.1,1};
	soundEnter[] = {"",0.1,1};
	soundEscape[] = {"",0.1,1};
	soundPush[] = {"",0.1,1};
	
};
/* EXAMPLE:
class vn_MyFancyButtonWithChangingTexturesWhenIHoverWithTheMouseOverItCamelCaseIsNice: vn_mf_RscButton_ImgSwitch
{
	idc = 123;
	x = UIX_CL(1);
	y = UIY_CU(1);
	w = UIW(2);
	h = UIH(2);
	
	tooltip = "I am a Button who exchanges images, when you move your mouse over me! WOOT WOOT!";
	
	text = "\vn\ui_f_vietnam\ui\taskroster\img\papersheetB.paa";
	textUp = "\vn\ui_f_vietnam\ui\taskroster\img\papersheetC.paa";
	
	onButtonClick = "systemchat str _this;";
};

*/

class vn_mf_RscControlsGroup
{
	x = 0;
	y = 0;
	w = 0;
	h = 0;
	idc = 0;
	type = 15;
	style = 16;
	enable = 1;
	show = 1;
	fade = 0;
	blinkingPeriod = 0;
	shadow = 0;
	
	class VScrollbar
	{
		width = UIW(0.5);
		scrollSpeed = 0.03;
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		color[] = {1,1,1,1};
		autoScrollEnabled = 0;
		autoScrollDelay = 0;
		autoScrollRewind = 0;
		autoScrollSpeed = 0;
	};
	class HScrollbar
	{
		width = UIH(0.5);
		scrollSpeed = 0.03;
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		color[] = {1,1,1,1};
	};
};

class vn_mf_RscControlsGroupNoScrollbarHV : vn_mf_RscControlsGroup
{
	class VScrollbar
	{
		width = 0;
		scrollSpeed = 0.02;
		arrowEmpty = "";
		arrowFull = "";
		border = "";
		thumb = "";
		color[] = {1,1,1,1};
		autoScrollEnabled = 0;
		autoScrollDelay = 0;
		autoScrollRewind = 0;
		autoScrollSpeed = 0;
	};
	class HScrollbar
	{
		height = 0;
		scrollSpeed = 0.02;
		arrowEmpty = "";
		arrowFull = "";
		border = "";
		thumb = "";
		color[] = {1,1,1,1};
	};
};

class vn_mf_RscControlsGroupNoScrollbarH : vn_mf_RscControlsGroup
{
	//onMouseButtonDown	= "[1,_this] call {hint str _this;}";
	//onMouseButtonUp		= "[2,_this] call {hint str _this;}";
	
	class HScrollbar
	{
		height = 0;
		scrollSpeed = 0.02;
		arrowEmpty = "";
		arrowFull = "";
		border = "";
		thumb = "";
		color[] = {1,1,1,1};
	};
};

class vn_mf_RscControlsGroupNoScrollbarV : vn_mf_RscControlsGroup
{
	class VScrollbar
	{
		width = 0;
		scrollSpeed = 0.02;
		arrowEmpty = "";
		arrowFull = "";
		border = "";
		thumb = "";
		color[] = {1,1,1,1};
		autoScrollEnabled = 0;
		autoScrollDelay = 0;
		autoScrollRewind = 0;
		autoScrollSpeed = 0;
	};
};

class vn_mf_RscCombo
{
	idc = -1;
	x = UIX_CL(1);
	y = UIY_CU(1);
	w = UIW(2);
	h = UIH(2);
	
	type = CT_COMBO;
	//style = ST_LEFT + LB_TEXTURES; // Style
	style = ST_LEFT + LB_TEXTURES; // Style
	blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.
	
	
	colorBackground[] = {0.1,0.1,0.1,0.0}; // Fill color
	colorSelectBackground[] = {0.1,0.1,0.1,0.1}; // Selected item fill color
	
	tooltip = ""; // Tooltip text
	sizeEx =  TXT_M;
	font = USEDFONT;
	shadow = 0;
	
	colorText[] = {0,0,0,0.75}; // Text and frame color
	colorDisabled[] = {1,1,1,0.5}; // Disabled text color
	colorSelect[] = {0,0,0,1}; // Text selection color
	
	pictureColor[] = {0.0,0.5,0.1,1}; // Picture color
	pictureColorSelect[] = {0.0,0.5,0.1,1}; // Selected picture color
	pictureColorDisabled[] = {1,1,1,0.5}; // Disabled picture color
	
	tooltipColorShade[] = {0,0,0,1}; // Tooltip background color
	tooltipColorText[] = {1,1,1,1}; // Tooltip text color
	tooltipColorBox[] = {1,1,1,1}; // Tooltip frame color
	
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa"; // Expand arrow									//ToDo?
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa"; // Collapse arrow							//ToDo?
	
	wholeHeight = PXH(10); // Maximum height of expanded box (including the control height)
	maxHistoryDelay = 1; // Time since last keyboard type search to reset it
	
	soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1}; // Sound played when the list is expanded			//ToDo?
	soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1}; // Sound played when the list is collapsed		//ToDo?
	soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1}; // Sound played when an item is selected			//ToDo?
	
	// Scrollbar configuration (applied only when LB_TEXTURES style is used)
	class ComboScrollBar
	{
		width = 0; // width of ComboScrollBar
		height = 0; // height of ComboScrollBar
		scrollSpeed = 0.01; // scrollSpeed of ComboScrollBar
		
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow												//ToDo?
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on								//ToDo?
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)					//ToDo?
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)						//ToDo?

		color[] = {1,1,1,1}; // Scrollbar color
	};
	
	
	onCanDestroy = "";
	onDestroy = "";
	onSetFocus = "";
	onKillFocus = "";
	onKeyDown = "";
	onKeyUp = "";
	onMouseButtonDown = "";
	onMouseButtonUp = "";
	onMouseButtonClick = "";
	onMouseButtonDblClick = "";
	onMouseZChanged = "";
	onMouseMoving = "";
	onMouseHolding = "";
	
	onLBSelChanged = "systemChat str ['CHANGE ME: onLBSelChanged',_this]; false";
};

class vn_mf_ribbon_base: vn_mf_RscButton_ImgSwitch
{
	idc = -1;
	
	x = UIW(0);
	y = UIH(0);
	w = UIW(1);
	h = UIH((1/3.3333));
	
	text = "";
	tooltip = "";
	
	onMouseEnter = "[_this#0,true] call vn_mf_fnc_tr_characterInfo_ribbon_enter;";
	onMouseExit = "call vn_mf_fnc_tr_characterInfo_ribbon_exit;";
	onButtonClick = "[_this#0,true]call vn_mf_fnc_tr_characterInfo_ribbon_setIcon;";
};

class vn_mf_RscMapControl
{
	moveOnEdges = 1;
	x = "SafeZoneXAbs";
	y = "SafeZoneY + 1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	w = "SafeZoneWAbs";
	h = "SafeZoneH - 1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	
	type = 101;
	style = "0x10+ 0x20";
	text = "#(argb,8,8,3)color(1,1,1,1)";
	font = "TahomaB";
	sizeEx = 0.04;
	
	onLoad = "(_this#0) ctrlenable false;";
	
	colorText[] = {0,0,0,1};
	// colorBackground[] = {1,1,1,1};
	
	shadow = 0;
	ptsPerSquareSea = 5;
	ptsPerSquareTxt = 20;
	ptsPerSquareCLn = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareFor = 9;
	ptsPerSquareForEdge = 9;
	ptsPerSquareRoad = 6;
	ptsPerSquareObj = 9;
	showCountourInterval = 0;
	scaleMin = 0.001;
	scaleMax = 1.0;
	scaleDefault = 0.16;
	maxSatelliteAlpha = 0.85;
	alphaFadeStartScale = 2;
	alphaFadeEndScale = 2;
	colorBackground[] = {0.969,0.957,0.949,1.0};
	colorSea[] = {0.467,0.631,0.851,0.5};
	colorForest[] = {0.624,0.78,0.388,0.5};
	colorForestBorder[] = {0.0,0.0,0.0,0.0};
	colorRocks[] = {0.0,0.0,0.0,0.3};
	colorRocksBorder[] = {0.0,0.0,0.0,0.0};
	colorLevels[] = {0.286,0.177,0.094,0.5};
	colorMainCountlines[] = {0.572,0.354,0.188,0.5};
	colorCountlines[] = {0.572,0.354,0.188,0.25};
	colorMainCountlinesWater[] = {0.491,0.577,0.702,0.6};
	colorCountlinesWater[] = {0.491,0.577,0.702,0.3};
	colorPowerLines[] = {0.1,0.1,0.1,1.0};
	colorRailWay[] = {0.8,0.2,0.0,1.0};
	colorNames[] = {0.1,0.1,0.1,0.9};
	colorInactive[] = {1.0,1.0,1.0,0.5};
	colorOutside[] = {0.0,0.0,0.0,1.0};
	colorTracks[] = {0.84,0.76,0.65,0.15};
	colorTracksFill[] = {0.84,0.76,0.65,1.0};
	colorRoads[] = {0.7,0.7,0.7,1.0};
	colorRoadsFill[] = {1.0,1.0,1.0,1.0};
	colorMainRoads[] = {0.9,0.5,0.3,1.0};
	colorMainRoadsFill[] = {1.0,0.6,0.4,1.0};
	colorGrid[] = {0.1,0.1,0.1,0.6};
	colorGridMap[] = {0.1,0.1,0.1,0.6};
	colorTrails[] = {0.84,0.76,0.65,0.15};
	colorTrailsFill[] = {0.84,0.76,0.65,0.65};
	widthRailWay = 4.0;
	fontLabel = "RobotoCondensed";
	sizeExLabel = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontGrid = "TahomaB";
	sizeExGrid = 0.02;
	fontUnits = "TahomaB";
	sizeExUnits = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontNames = "RobotoCondensed";
	sizeExNames = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
	fontInfo = "RobotoCondensed";
	sizeExInfo = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontLevel = "TahomaB";
	sizeExLevel = 0.02;
	idcMarkerColor = -1;
	idcMarkerIcon = -1;
	textureComboBoxColor = "#(argb,8,8,3)color(1,1,1,1)";
	showMarkers = 1;
	class ActiveMarker
	{
		color[] = {0.3,0.1,0.9,1};
		size = 50;
	};
	class LineMarker
	{
		lineWidthThin = 0.008;
		lineWidthThick = 0.014;
		lineDistanceMin = 3e-05;
		lineLengthMin = 5;
	};
	class Legend
	{
		x = "SafeZoneX + 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "10 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		h = "3.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		font = "RobotoCondensed";
		sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		colorBackground[] = {1,1,1,0.5};
		color[] = {0,0,0,1};
	};
	class Task
	{
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		colorCreated[] = {1,1,1,1};
		colorCanceled[] = {0.7,0.7,0.7,1};
		colorDone[] = {0.7,1,0.3,1};
		colorFailed[] = {1,0.3,0.2,1};
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Waypoint
	{
		icon = "\a3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		color[] = {1,1,1,1};
		size = 18;
		coefMax = 1;
		coefMin = 1;
		importance = 1;
	};
	class WaypointCompleted
	{
		icon = "\a3\ui_f\data\map\mapcontrol\waypointcompleted_ca.paa";
		color[] = {1,1,1,1};
		size = 18;
		coefMax = 1;
		coefMin = 1;
		importance = 1;
	};
	class CustomMark
	{
		icon = "\a3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {1,1,1,1};
	};
	class Command
	{
		icon = "\a3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		color[] = {1,1,1,1};
	};
	class Bush
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45,0.64,0.33,0.4};
		size = "14/2";
		importance = "0.2 * 14 * 0.05 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Rock
	{
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		color[] = {0.1,0.1,0.1,0.8};
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class SmallTree
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45,0.64,0.33,0.4};
		size = 12;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Tree
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[] = {0.45,0.64,0.33,0.4};
		size = 12;
		importance = "0.9 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class busstop
	{
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class fuelstation
	{
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class hospital
	{
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class church
	{
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class lighthouse
	{
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class power
	{
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powersolar
	{
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powerwave
	{
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class powerwind
	{
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class quay
	{
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class transmitter
	{
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class watertower
	{
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {1,1,1,1};
	};
	class Cross
	{
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {0,0,0,1};
	};
	class Chapel
	{
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {0,0,0,1};
	};
	class Shipwreck
	{
		icon = "\A3\ui_f\data\map\mapcontrol\Shipwreck_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1.0;
		color[] = {0,0,0,1};
	};
	class Bunker
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Fortress
	{
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Fountain
	{
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		size = 11;
		importance = "1 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Ruin
	{
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		size = 16;
		importance = "1.2 * 16 * 0.05";
		coefMin = 1;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class Stack
	{
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.4;
		coefMax = 2;
		color[] = {0,0,0,1};
	};
	class Tourism
	{
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.7;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
	class ViewTower
	{
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.5;
		coefMax = 4;
		color[] = {0,0,0,1};
	};
};

class vn_mf_RscShortcutButton
{
	idc = -1;
	style = 0;
	default = 0;
	shadow = 1;
	w = 0.183825;
	h = "(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	color[] = {1,1,1,1.0};
	colorFocused[] = {1,1,1,1.0};
	color2[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",1};
	colorBackgroundFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",1};
	colorBackground2[] = {1,1,1,1};
	textSecondary = "";
	colorSecondary[] = {1,1,1,1.0};
	colorFocusedSecondary[] = {1,1,1,1.0};
	color2Secondary[] = {0.95,0.95,0.95,1};
	colorDisabledSecondary[] = {1,1,1,0.25};
	sizeExSecondary = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	fontSecondary = "RobotoCondensed";
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	periodFocus = 1.2;
	periodOver = 0.8;
	class HitZone
	{
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	class ShortcutPos
	{
		left = 0;
		top = "(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class TextPos
	{
		left = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		top = "(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	period = 0.4;
	font = "RobotoCondensed";
	size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	url = "";
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
	action = "";
	class Attributes
	{
		font = "RobotoCondensed";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	class AttributesImage
	{
		font = "RobotoCondensed";
		color = "#E5E5E5";
		align = "left";
	};
};

class vn_mf_RscButtonMenu: vn_mf_RscShortcutButton
{
	idc = -1;
	type = 16;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] = {0,0,0,0.8};
	colorBackgroundFocused[] = {1,1,1,1};
	colorBackground2[] = {0.75,0.75,0.75,1};
	color[] = {1,1,1,1};
	colorFocused[] = {0,0,0,1};
	color2[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	textSecondary = "";
	colorSecondary[] = {1,1,1,1};
	colorFocusedSecondary[] = {0,0,0,1};
	color2Secondary[] = {0,0,0,1};
	colorDisabledSecondary[] = {1,1,1,0.25};
	sizeExSecondary = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	fontSecondary = USEDFONT;
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	class TextPos
	{
		left = "0.25 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	class Attributes
	{
		font = USEDFONT;
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class ShortcutPos
	{
		left = "5.25 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
		top = 0;
		w = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
		h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundPush",0.09,1};
	soundClick[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundClick",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",0.09,1};
	textureNoShortcut = "";
};

class vn_mf_ControlsTable
{
	idc = -1;
	x = 0;
	y = 0;
	w = 0;
	h = 0;

	type = 19;
	style = ST_LEFT + LB_TEXTURES;

	lineSpacing = 0;
	rowHeight = UIH(1);
	headerHeight = UIH(1);

	firstIdc = 20000;
	lastIdc = 30000;

	selectedRowColorFrom[] = { 0, 0, 0, 0.1 };
	selectedRowColorTo[] = { 0, 0, 0, 0.2 };
	selectedRowAnimLength = 0.8;

	class VScrollbar
	{
		width = UIW(0.5);
		scrollSpeed = 0.03;
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		color[] = {1,1,1,1};
		autoScrollEnabled = 0;
		autoScrollDelay = 0;
		autoScrollRewind = 0;
		autoScrollSpeed = 0;
	};

	class HScrollbar
	{
		height = UI_GRID_H * 1.5;
		scrollSpeed = 0.03;
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		color[] = {1,1,1,1};
	};
	
	class RowTemplate {};
	class HeaderTemplate {};
};

class vn_mf_RscProgress
{
	type = 8;
	x=0.34400001;
	y=0.61900002;
	w=0.3137255;
	h=0.0261438;
	shadow=2;
	texture="#(argb,8,8,3)color(1,1,1,1)";
	colorFrame[] = {0,0,0,1};
	colorBar[] = {1,1,1,1};
};
class vn_mf_RscStatProgress : vn_mf_RscProgress
{
	style = 1;
	colorFrame[] = {0,0,0,1};
	colorBar[] = {1,1,1,1};
	texture = "#(argb,8,8,3)color(1,1,1,1)";
	x = 0;
	y = 0;
	w = 1;
	h = 1;
};

class vn_mf_RscStatProgressHUD : vn_mf_RscProgress
{
	style = 0;
	colorFrame[] = {0,0,0,0};
};
// custom UI stuff for armor stats
class vn_mf_RscCustomProgress : vn_mf_RscProgress
{
	style = 0;
	texture = "";
	textureExt = "";
	colorBar[] = { 0.9, 0.9, 0.9, 0.9 };
	colorExtBar[] = { 1, 1, 1, 1 };
	colorFrame[] = { 1, 1, 1, 1 };
	x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
	y = "16 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	w = "26 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
	h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	colorBackground[] = { 1, 1, 1, 0.75 };
};

class vn_mf_RscTotalArmorProgress : vn_mf_RscProgress
{
	style = 0;
	texture = "";
	textureExt = "";
	colorBar[] = { 0.9, 0.9, 0.9, 0.9 };
	colorExtBar[] = { 1, 1, 1, 1 };
	colorFrame[] = { 1, 1, 1, 1 };
	x = "1.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
	y = "22.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
	w = "11 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
	h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
};

// loading screen
class MikeForce_loadingScreen
{
	idd = -1;
	onLoad = "uiNamespace setVariable ['vn_mf_loadingScreen',_this select 0]";
	onUnload = "uiNamespace setVariable ['vn_mf_loadingScreen',displayNull]";
	duration = 10e10;
	fadein = 0;
	fadeout = 0;
	name = "loading screen";
	class controls
	{
		class LoadingProgress: vn_mf_RscProgress
		{
			style = 0;
			idc = 104; // progress bar, has to have idc 104
			colorBar[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.295761 * safezoneW + safezoneX;
			y = 0.9 * safezoneH + safezoneY;
			w = 0.408477 * safezoneW;
			h = 0.0066 * safezoneH;
		};
		class LoadingText: vn_mf_RscStructuredText
		{
			idc = 5050;
			text = "";
			class Attributes
			{
				size = "0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				align = "center";
			};
			x = 0.314328 * safezoneW + safezoneX;
			y = 0.80 * safezoneH + safezoneY;
			w = 0.350767 * safezoneW;
			h = 0.0396 * safezoneH;
			sizeEx = "0.8 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
	class controlsBackground
	{
		class Black: vn_mf_RscText
		{
			idc = 5001;
			text = "";
			colorBackground[] = {0,0,0,1};
			x = "safezoneXAbs";
			y = "safezoneY";
			w = "safezoneWAbs";
			h = "safezoneH";
		};

		class Overlay: vn_mf_RscPicture
		{
			idc = 5002;
			style = 48 + 0x800;
			text="\vn\objects_f_vietnam\civ\signs\data\billboards\vn_ui_billboard_01_ca.paa";
			colorText[] = {1,1,1,0.8};
			x = "safezoneX";
			y = "safezoneY";
			w = "safezoneW";
			h = "safezoneH";
		};
	};

};