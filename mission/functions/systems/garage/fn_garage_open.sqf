/*
    File: vn_garage_open.sqf
    Author: Bohemia Interactive + Savage Game Design
    Date: 2023-05-08
    Last Update: 2023-05-08
    Public: Yes
    
    Description:
        Opens the BI virtual garage.

		Only shows specific vehicles in the garage.
    
    Parameter(s):
        _mode - Identical to "BIS_fnc_garage"
		_params - [vehicles, spawnPos, spawnDir]
			- vehicleClasses - Array of classnames to make available [ARRAY]
			- spawnPos - Location to spawn the vehicles at [POS]
			- spawnDir - Direction for the vehicles to face.
    
    Returns:
        None
    
    Example(s):
		["Open", [["vn_land_some_vehicle"], [0, 0, 0], 180]] call vn_mf_fnc_garage_open
*/

#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

#define SELF_NAME "vn_mf_fnc_garage_open"
#define SELF_FUNC (missionNamespace getVariable SELF_NAME)
#define ARSENAL_NAME "vn_mf_fnc_garage_arsenal"
#define ARSENAL_FUNC (missionNamespace getVariable ARSENAL_NAME)
#define REGISTER_DISPLAY_FUNC (missionNamespace getVariable "vn_mf_fnc_garage_register_display")

#define FADE_DELAY	0.15

disableserialization;

private _mode = _this param [0, "Open", [displayNull, ""]];
_this = param [1, []];

#define IDCS_LEFT\
	IDC_RSCDISPLAYGARAGE_TAB_CAR,\
	IDC_RSCDISPLAYGARAGE_TAB_ARMOR,\
	IDC_RSCDISPLAYGARAGE_TAB_HELI,\
	IDC_RSCDISPLAYGARAGE_TAB_PLANE,\
	IDC_RSCDISPLAYGARAGE_TAB_NAVAL,\
	IDC_RSCDISPLAYGARAGE_TAB_STATIC

#define IDCS_RIGHT\
	IDC_RSCDISPLAYGARAGE_TAB_SUBANIMATION,\
	IDC_RSCDISPLAYGARAGE_TAB_SUBTEXTURE

#define INITTYPES\
		_types = [];\
		_types set [IDC_RSCDISPLAYGARAGE_TAB_CAR,["carx"]];\
		_types set [IDC_RSCDISPLAYGARAGE_TAB_ARMOR,["tankx"]];\
		_types set [IDC_RSCDISPLAYGARAGE_TAB_HELI,["helicopterx"]];\
		_types set [IDC_RSCDISPLAYGARAGE_TAB_PLANE,["airplanex"]];\
		_types set [IDC_RSCDISPLAYGARAGE_TAB_NAVAL,["shipx","sumbarinex"]];\
		_types set [IDC_RSCDISPLAYGARAGE_TAB_STATIC,[""]];

#define IDCS	[IDCS_LEFT,IDCS_RIGHT]


#define STATS\
	["maxspeed","armor","fuelcapacity","threat"],\
	[false,true,false,false]

// TODO - Try removing
#define CONDITION(LIST)	({"%ALL" in LIST} || {{_item == _x} count LIST > 0})
#define ERROR if !(_item in _disabledItems) then {_disabledItems set [count _disabledItems,_item];};

private _fnc_compareTextures = 
{
	params ["_vehtex", "_cfgtex"];
	if (_cfgtex isEqualTo "") exitWith { true }; // empty/absent config texture == any texture
	if (_vehtex find "\" != 0) then {_vehtex = "\" + _vehtex};
	if (_cfgtex find "\" != 0) then {_cfgtex = "\" + _cfgtex};
	_vehtex == _cfgtex
};

private _checkboxTextures = 
[
	tolower gettext (configfile >> "RscCheckBox" >> "textureUnchecked"),
	tolower gettext (configfile >> "RscCheckBox" >> "textureChecked")
];
	
switch _mode do {

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Open": {
		if !(isnull (uinamespace getvariable ["BIS_fnc_arsenal_cam",objnull])) exitwith {"Garage Viewer is already running" call bis_fnc_logFormat;};

		_this params ["_vehicleClasses", "_spawnPos", "_spawnDir"];

		if (_spawnPos isEqualType []) then {
			_spawnPos = createVehicle ["Land_HelipadEmpty_F", _spawnPos, [], 0, "CAN_COLLIDE"];	
		};

		uinamespace setVariable ["vn_mf_garage_vehicleClasses", _vehicleClasses];
		uinamespace setVariable ["vn_mf_garage_spawnPos", _spawnPos];
		uinamespace setVariable ["vn_mf_garage_spawnDir", _spawnDir];

		with missionnamespace do {
			BIS_fnc_garage_center = _spawnPos;
		};

		with uinamespace do {
			_displayMission = [] call (uinamespace getvariable "bis_fnc_displayMission");
			if !(isnull finddisplay 312) then {_displayMission = finddisplay 312;};
			_displayMission createdisplay 'vn_mf_garage_disp_garage';
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Init": {
		// We need to do this because the RscDisplayGarage script does it.
		// No idea why - maybe we could remove it in the future?
		if (isNil "bis_fnc_arsenal_data" && !canSuspend) exitWith {
			["Init", _this] spawn SELF_FUNC;
		};

		["register", _this, "RscDisplayGarageMikeForce", "GUI"] call REGISTER_DISPLAY_FUNC;

		["BIS_fnc_arsenal"] call bis_fnc_startloadingscreen;
		_display = _this select 0;
		_toggleSpace = uinamespace getvariable ["BIS_fnc_arsenal_toggleSpace",false];
		BIS_fnc_arsenal_type = 1; //--- 0 - Arsenal, 1 - Garage
		BIS_fnc_arsenal_toggleSpace = nil;
		BIS_fnc_garage_turretPaths = [];
		if (isnil "BIS_fnc_garage_centerType") then {BIS_fnc_garage_centerType = "";};
		setstatvalue ["MarkVirtualVehicleInspection",1];

		with missionnamespace do {
			BIS_fnc_arsenal_group = creategroup side group player;
			BIS_fnc_arsenal_center = missionnamespace getvariable ["BIS_fnc_garage_center",player];
		};

		//--- Show specific class
		_classDefault = uinamespace getvariable ["bis_fnc_garage_defaultClass",""];
		if (isclass (configfile >> "cfgvehicles" >> _classDefault)) then {
			_vehModel = gettext (configfile >> "cfgvehicles" >> _classDefault >> "model");
			if (getnumber (configfile >> "cfgvehicles" >> _classDefault >> "forceInGarage") > 0) then {_vehModel = _vehModel + ":" + _classDefault;};
			bis_fnc_garage_centerType = _vehModel;
		};
		uinamespace setvariable ["bis_fnc_garage_defaultClass",nil];

		//--- Load stats
		if (isnil {uinamespace getvariable "BIS_fnc_garage_stats"}) then {
			_defaultCrew = gettext (configfile >> "cfgvehicles" >> "all" >> "crew");
			uinamespace setvariable [
				"BIS_fnc_garage_stats",
				[
					//("isclass _x && getnumber (_x >> 'scope') == 2") configclasses (configfile >> "cfgvehicles"),
					("isclass _x && {getnumber (_x >> 'scope') == 2} && {gettext (_x >> 'crew') != _defaultCrew}" configclasses (configfile >> "cfgvehicles")),
					STATS
				] call bis_fnc_configExtremes
			];
		};

		INITTYPES
		["InitGUI",[_display, SELF_NAME]] call ARSENAL_FUNC;
		["InitGUI", [_display]] call SELF_FUNC;
		["Preload"] call SELF_FUNC;
		["ListAdd",[_display]] call SELF_FUNC;
		if (BIS_fnc_garage_centerType == "") then {["buttonRandom",[_display]] call SELF_FUNC;};
		["MouseZChanged",[controlnull,0]] call ARSENAL_FUNC; //--- Reset zoom
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsetfade 0;
		} foreach [IDC_RSCDISPLAYARSENAL_LINETABLEFT];

		_ctrl = _display displayctrl IDC_RSCDISPLAYARSENAL_LINEICON;
		_ctrl ctrlshow false;

		with missionnamespace do {
			[missionnamespace,"garageOpened",[_display,_toggleSpace]] call bis_fnc_callscriptedeventhandler;
		};
		["BIS_fnc_arsenal"] call bis_fnc_endloadingscreen;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Exit": {
		// Need to do this, as formerly initDisplay handled running this in the uiNamespace.
		// Since that was replaced by register_display
		if (currentNamespace isNotEqualTo uiNamespace) exitWith {
			with uiNamespace do {
				["Exit", _this] call SELF_FUNC;
			};
		};

		["unregister", _this, "RscDisplayGarageMikeForce", "GUI"] call REGISTER_DISPLAY_FUNC;

		with missionnamespace do {
			BIS_fnc_garage_center = BIS_fnc_arsenal_center;
/*
			{
				BIS_fnc_arsenal_center deletevehiclecrew _x;
			} foreach crew BIS_fnc_arsenal_center;
			deletevehicle BIS_fnc_arsenal_center;
			BIS_fnc_arsenal_group = nil;
*/
		};
		BIS_fnc_garage_turretPaths = nil;

		with missionnamespace do {
			[missionnamespace,"garageClosed",[displaynull,uinamespace getvariable ["BIS_fnc_arsenal_toggleSpace",false]]] call bis_fnc_callscriptedeventhandler;
		};
		"Exit" call ARSENAL_FUNC;
	};

	case "InitGUI": {
		params ["_display"];

		_ctrlButtonSave = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE;
		_ctrlButtonSave ctrlShow false;

		_ctrlButtonLoad = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
		_ctrlButtonLoad ctrlShow false;

		_ctrlButtonExport = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONEXPORT;
		_ctrlButtonExport ctrlShow false;

		_ctrlButtonImport = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONIMPORT;
		_ctrlButtonImport ctrlShow false;

		_ctrlButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONOK;

		_ctrlButtonTry = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONTRY;
		_ctrlButtonTry ctrlShow false;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Preload": {
		diag_log "Calling MF garage preload";
		private _vehicleClasses = uinamespace getVariable ["vn_mf_garage_vehicleClasses", []];
		//Load vehicle types sorted by category
		if (isnil "_data" || cheatsenabled) then {
			["bis_fnc_garage_preload"] call bis_fnc_startloadingscreen;

			_data = [];
			{
				_data set [_x,[]];
			} foreach [IDCS_LEFT];
			_defaultCrew = gettext (configfile >> "cfgvehicles" >> "all" >> "crew");

			{
				_simulation = gettext (_x >> "simulation");
				_items = switch tolower _simulation do {
					case "car";
					case "carx": {
						_data select IDC_RSCDISPLAYGARAGE_TAB_CAR;
					};
					case "tank";
					case "tankx": {
						if (getnumber (_x >> "maxspeed") > 0) then {
							_data select IDC_RSCDISPLAYGARAGE_TAB_ARMOR;
						} else {
							_data select IDC_RSCDISPLAYGARAGE_TAB_STATIC;
						};
					};
					case "helicopter";
					case "helicopterx";
					case "helicopterrtd": {
						_data select IDC_RSCDISPLAYGARAGE_TAB_HELI;
					};
					case "airplane";
					case "airplanex": {
						_data select IDC_RSCDISPLAYGARAGE_TAB_PLANE;
					};
					case "ship";
					case "shipx";
					case "submarinex": {
						_data select IDC_RSCDISPLAYGARAGE_TAB_NAVAL;
					};
					default {[]};
				};

				//--- Sort vehicles by model (vehicles with the same model are displayed as one, with variable textures / animations)
				_model = tolower gettext (_x >> "model");
				if (getnumber (_x >> "forceInGarage") > 0) then {_model = _model + ":" + configname _x;}; //--- Force specific class
				_modelID = _items find _model;
				if (_modelID < 0) then {
					_modelID = count _items;
					_items pushback _model;
					_items pushback [];
				};
				_modelData = _items select (_modelID + 1);
				_modelData pushback _x;

			} foreach (_vehicleClasses apply {configfile >> "cfgvehicles" >> _x});

			missionnamespace setvariable ["bis_fnc_garage_data",_data];
			["bis_fnc_garage_preload"] call bis_fnc_endloadingscreen;
			true
		} else {
			false
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "ListAdd": {
		_display = _this select 0;
		_data = missionnamespace getvariable "bis_fnc_garage_data";
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		{
			_items = _x;
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _foreachindex);
			for "_i" from 0 to (count _items - 1) step 2 do {
				_model = _items select _i;
				_modelData = _items select (_i + 1);
				_modelExample = _modelData select 0;
				_displayName = gettext (_modelExample >> "displayName");
				_lbAdd = _ctrlList lbadd _displayName;
				_ctrlList lbsetpicture [_lbAdd,gettext (_modelExample >> "picture")];
				_ctrlList lbsetdata [_lbAdd,_model];
				_ctrlList lbsetvalue [_lbAdd,_i];
				_ctrlList lbsettooltip [_lbAdd,_displayName];
				/*
					// Sets the DLC logo
					_addons = configsourceaddonlist _modelExample;
					if (count _addons > 0) then {
						_dlcs = configsourcemodlist (configfile >> "CfgPatches" >> _addons select 0);
						if (count _dlcs > 0) then {
							_ctrlList lbsetpictureright [_lbAdd,gettext (configfile >> "cfgMods" >> (_dlcs select 0) >> "logo")];
						};
					};
				*/
			};
			lbsort _ctrlList;

			//--- Select previously selected item (must be done after sorting)
			for "_i" from 0 to (lbsize _ctrlList - 1) do {
				if ((_ctrlList lbdata _i) == bis_fnc_garage_centerType) then {
					_ctrlList lbsetcursel _i;
				};
			} foreach _data;
		} foreach _data;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "TabSelectLeft": {
		_display = _this select 0;
		_index = _this select 1;
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
/*
		{
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
			_ctrlList lbsetcursel -1;
			lbclear _ctrlList;
		} foreach [IDCS_RIGHT];
*/
		{
			_idc = _x;
			_active = _idc == _index;

			{
				_ctrlList = _display displayctrl (_x + _idc);
				_ctrlList ctrlenable _active;
				_ctrlList ctrlsetfade ([1,0] select _active);
				_ctrlList ctrlcommit FADE_DELAY;
			} foreach [IDC_RSCDISPLAYARSENAL_LIST,IDC_RSCDISPLAYARSENAL_LISTDISABLED];

			_ctrlTab = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
			_ctrlTab ctrlenable !_active;

			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc);
			if (_active) then {
				_ctrlLineTabLeft = _display displayctrl IDC_RSCDISPLAYARSENAL_LINETABLEFT;
				_ctrlLineTabLeft ctrlsetfade 0;
				_ctrlTabPos = ctrlposition _ctrlTab;
				_ctrlLineTabPosX = (_ctrlTabPos select 0) + (_ctrlTabPos select 2) - 0.01;
				_ctrlLineTabPosY = (_ctrlTabPos select 1);
				_ctrlLineTabLeft ctrlsetposition [
					safezoneX,//_ctrlLineTabPosX,
					_ctrlLineTabPosY,
					(ctrlposition _ctrlList select 0) - safezoneX,//_ctrlLineTabPosX,
					ctrlposition _ctrlTab select 3
				];
				_ctrlLineTabLeft ctrlcommit 0;
				ctrlsetfocus _ctrlList;
				if (_idc != IDC_RSCDISPLAYGARAGE_TAB_SUBANIMATION) then { //--- Don't select animation, it would inverse the state
					['SelectItem',[_display,_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc),_idc]] call SELF_FUNC;
				};
			} else {
				if ((_center getvariable "bis_fnc_arsenal_idc") != _idc) then {_ctrlList lbsetcursel -1;};
			};

			_ctrlIcon = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICON + _idc);
			//_ctrlIcon ctrlsetfade ([1,0] select _active);
			_ctrlIcon ctrlshow _active;
			_ctrlIcon ctrlenable !_active;
		} foreach [IDCS_LEFT];

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsetfade 0;
			_ctrl ctrlcommit FADE_DELAY;
		} foreach [
			//IDC_RSCDISPLAYARSENAL_LINETABLEFT,
			IDC_RSCDISPLAYARSENAL_FRAMELEFT,
			IDC_RSCDISPLAYARSENAL_BACKGROUNDLEFT
		];

		//--- Right lists
		{
			_idc = _x;
			_ctrl = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _x);
			_ctrl ctrlenable true;
			_ctrl ctrlsetfade 0;
			_ctrl ctrlcommit 0;//FADE_DELAY;
			{
				_ctrlList = _display displayctrl (_idc + _x);
				_ctrlList ctrlenable true;
				_ctrlList ctrlsetfade 0;
				_ctrlList ctrlcommit FADE_DELAY;
			} foreach [IDC_RSCDISPLAYARSENAL_LIST,IDC_RSCDISPLAYARSENAL_LISTDISABLED];
		} foreach [IDCS_RIGHT];

		//--- Right sidebar
		if !(is3DEN) then {
			{
				_ctrl = _display displayctrl _x;
				_ctrl ctrlsetfade 0;
				_ctrl ctrlcommit FADE_DELAY;
			} foreach [
				IDC_RSCDISPLAYARSENAL_LINETABRIGHT,
				IDC_RSCDISPLAYARSENAL_FRAMERIGHT,
				IDC_RSCDISPLAYARSENAL_BACKGROUNDRIGHT
			];
		};

		['TabSelectRight',[_display,IDC_RSCDISPLAYGARAGE_TAB_SUBANIMATION]] call SELF_FUNC;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "TabSelectRight": {
		_display = _this select 0;
		_index = _this select 1;
		_ctrFrameRight = _display displayctrl IDC_RSCDISPLAYARSENAL_FRAMERIGHT;
		_ctrBackgroundRight = _display displayctrl IDC_RSCDISPLAYARSENAL_BACKGROUNDRIGHT;

		{
			_idc = _x;
			_active = _idc == _index;

			{
				_ctrlList = _display displayctrl (_x + _idc);
				_ctrlList ctrlenable _active;
				_ctrlList ctrlsetfade ([1,0] select _active);
				_ctrlList ctrlcommit FADE_DELAY;
			} foreach [IDC_RSCDISPLAYARSENAL_LIST,IDC_RSCDISPLAYARSENAL_LISTDISABLED];

			_ctrlTab = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
			_ctrlTab ctrlenable (!_active && ctrlfade _ctrlTab == 0);

			if (_active) then {
				_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc);
				_ctrlLineTabRight = _display displayctrl IDC_RSCDISPLAYARSENAL_LINETABRIGHT;
				_ctrlLineTabRight ctrlsetfade 0;
				_ctrlTabPos = ctrlposition _ctrlTab;
				_ctrlLineTabPosX = (ctrlposition _ctrlList select 0) + (ctrlposition _ctrlList select 2);
				_ctrlLineTabPosY = (_ctrlTabPos select 1);
				_ctrlLineTabRight ctrlsetposition [
					_ctrlLineTabPosX,
					_ctrlLineTabPosY,
					safezoneX + safezoneW - _ctrlLineTabPosX,//(_ctrlTabPos select 0) - _ctrlLineTabPosX + 0.01,
					ctrlposition _ctrlTab select 3
				];
				_ctrlLineTabRight ctrlcommit 0;
				ctrlsetfocus _ctrlList;

				_ctrlLoadCargo = _display displayctrl IDC_RSCDISPLAYARSENAL_LOADCARGO;
				_ctrlListPos = ctrlposition _ctrlList;
				_ctrlListPos set [3,(_ctrlListPos select 3) + (ctrlposition _ctrlLoadCargo select 3)];
				{
					_x ctrlsetposition _ctrlListPos;
					_x ctrlcommit 0;
				} foreach [_ctrFrameRight,_ctrBackgroundRight];

				if (_idc in [IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC]) then {
					["SelectItemRight",[_display,_ctrlList,_index]] call ARSENAL_FUNC;
				};
			};

			_ctrlIcon = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICON + _idc);
			//_ctrlIcon ctrlenable false;
			_ctrlIcon ctrlshow _active;
			_ctrlIcon ctrlenable (!_active && ctrlfade _ctrlTab == 0);
		} foreach [IDCS_RIGHT];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "SelectItem": {
		private ["_ctrlList","_index","_cursel"];
		_display = _this select 0;
		_ctrlList = _this select 1;
		_idc = _this select 2;
		_cursel = lbcursel _ctrlList;
		if (_cursel < 0) exitwith {};
		_index = _ctrlList lbvalue _cursel;

		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		_group = (missionnamespace getvariable ["BIS_fnc_arsenal_group",group player]);
		_cfg = configfile >> "dummy";
		//_cfg = configfile >> "cfgvehicles" >> typeof _center;
		_colors = [[1,1,1,1],[1,1,1,0.25]];
		_initVehicle = false;

		switch _idc do {
			case IDC_RSCDISPLAYGARAGE_TAB_CAR;
			case IDC_RSCDISPLAYGARAGE_TAB_ARMOR;
			case IDC_RSCDISPLAYGARAGE_TAB_HELI;
			case IDC_RSCDISPLAYGARAGE_TAB_PLANE;
			case IDC_RSCDISPLAYGARAGE_TAB_NAVAL;
			case IDC_RSCDISPLAYGARAGE_TAB_STATIC: {
				_item = if (ctrltype _ctrlList == 102) then {_ctrlList lnbdata [_cursel,0]} else {_ctrlList lbdata _cursel};
				_target = (missionnamespace getvariable ["BIS_fnc_arsenal_target",player]);
				_centerType = if !(simulationenabled _center) then {""} else {typeof _center}; //--- Accept only previous vehicle, not player during init
				_centerSizeOld = ((boundingboxreal _center select 0) vectordistance (boundingboxreal _center select 1));//sizeof _centerType;
				_data = missionnamespace getvariable "bis_fnc_garage_data";
				_modelData = (_data select _idc) select (_index + 1);
				_cfg = _modelData select 0;
				_cfgStats = _cfg;
				_class = configname _cfg;

				if (_class != _centerType || !alive _center) then {
					_centerPos = position _center;
					_centerPos set [2,0];
					_players = [];
					{
						if (isplayer _x) then {
							_players pushback [_x,assignedvehiclerole _x];
							moveout _x;
						} else {
							_center deletevehiclecrew _x;
						};
					} foreach crew _center;

					if (_center != player) then {_center setpos [10,10,00];};
					deletevehicle _center;
					_center = createVehicle [_class, _centerPos, [], 0, "NONE"];
					_center setPos _centerPos;
					if ((_center getvariable ["bis_fnc_arsenal_idc",-1]) >= 0) then {_center setpos _centerPos;}; //--- Move vehicle only when previous vehicle was created by Garage
					_center allowdamage false;
					_center setvelocity [0,0,0];
					_center setvariable ["bis_fnc_arsenal_idc",_idc];
					// _center setvehicletipars [0.5,0.5,0.5];}; //--- Heat vehicle parts so user can preview them
					bis_fnc_garage_centerType = _item;
					missionnamespace setvariable ["BIS_fnc_arsenal_center",_center];
					_target attachto [_center,BIS_fnc_arsenal_campos select 3,""];

					//--- Restore player seats
					{
						_player = _x select 0;
						_roleArray = _x select 1;
						_role = _roleArray select 0;
						switch (tolower _role) do {
							case "driver": {
								if (_center emptypositions _role > 0) then {_player moveindriver _center;} else {_player moveinany _center;};
							};
							case "gunner";
							case "commander";
							case "turret": {
								if (count (allturrets _center) > 0) then {_player moveinturret [_center,(allturrets _center) select 0];} else {_player moveinany _center;};
							};
							case "cargo": {
								if (_center emptypositions _role > 0) then {_player moveincargo _center;} else {_player moveinany _center;};
							};
						};
					} foreach _players;

					//--- Set the same relative distance and position
					_centerSize = ((boundingboxreal _center select 0) vectordistance (boundingboxreal _center select 1));//sizeof typeof _center;
					if (_centerSizeOld != 0) then {
						_dis = BIS_fnc_arsenal_campos select 0;
						_disCoef = _dis / _centerSizeOld;
						BIS_fnc_arsenal_campos set [0,_centerSize * _disCoef];

						_targetPos = BIS_fnc_arsenal_campos select 3;
						_coefX = (_targetPos select 0) / _centerSizeOld;
						_coefY = (_targetPos select 1) / _centerSizeOld;
						_coefZ = (_targetPos select 2) / _centerSizeOld;
						BIS_fnc_arsenal_campos set [3,[_centerSize * _coefX,_centerSize * _coefY,_centerSize * _coefZ]];
					};
				};

				//--- Reset the vehicle state
				_center setdir direction _center;
				_center setvelocity [0,0,0];

				//--- Animations
				_ctrlListAnimations = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYGARAGE_TAB_SUBANIMATION);
				lbclear _ctrlListAnimations;
				{
					_configName = configname _x;
					_displayName = gettext (_x >> "displayName");
					if (_displayName != "" && {getnumber (_x >> "scope") > 1 || !isnumber (_x >> "scope")}) then {
						_lbAdd = _ctrlListAnimations lbadd _displayName;
						_ctrlListAnimations lbsetdata [_lbAdd,_configName];
						_ctrlListAnimations lbsetpicture [_lbAdd,_checkboxTextures select ((_center animationphase _configName) max 0)];
					};
				} foreach (configproperties [_cfg >> "animationSources","isclass _x",true]);
				lbsort _ctrlListAnimations;
				_ctrlListAnimationsDisabled = _display displayctrl (IDC_RSCDISPLAYARSENAL_LISTDISABLED + IDC_RSCDISPLAYGARAGE_TAB_SUBANIMATION);
				_ctrlListAnimationsDisabled ctrlshow (lbsize _ctrlListAnimations == 0);

				//--- Textures
				_currentTextures = getobjecttextures _center;
				_current = "";
				_ctrlListTextures = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYGARAGE_TAB_SUBTEXTURE);
				lbclear _ctrlListTextures;
				{
					_displayName = gettext (_x >> "displayName");
					if (_displayName != "") then 
					{					
						private _textures = getarray (_x >> "textures");
						private _decals = getarray (_x >> "decals");
						private _selected = 
						({
							if !(_forEachIndex in _decals || { [_x, _textures param [_forEachIndex, ""]] call _fnc_compareTextures }) exitWith { false };
							true
						}
						forEach _currentTextures);

						_lbAdd = _ctrlListTextures lbadd _displayName;
						_ctrlListTextures lbsetdata [_lbAdd,configname _x];
						_ctrlListTextures lbsetpicture [_lbAdd,_checkboxTextures select 0];
						if (_selected) then {_current = configname _x;};
					};
				} foreach (configproperties [_cfg >> "textureSources","isclass _x",true]);
				lbsort _ctrlListTextures;
				for "_i" from 0 to (lbsize _ctrlListTextures - 1) do {
					if ((_ctrlListTextures lbdata _i) == _current) then {
						_ctrlListTextures lbsetcursel _i;
					};
				};
				_ctrlListTexturesDisabled = _display displayctrl (IDC_RSCDISPLAYARSENAL_LISTDISABLED + IDC_RSCDISPLAYGARAGE_TAB_SUBTEXTURE);
				_ctrlListTexturesDisabled ctrlshow (lbsize _ctrlListTextures == 0);

				//--- Mark the tab as selected
				_ctrlTab = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
				_ctrlLineTab = _display displayctrl IDC_RSCDISPLAYARSENAL_LINETABLEFTSELECTED;
				_ctrlLineTabPos = ctrlposition _ctrlLineTab;
				_ctrlLineTabPos set [1,ctrlposition _ctrlTab select 1];
				_ctrlLineTab ctrlsetposition _ctrlLineTabPos;
				_ctrlLineTab ctrlcommit 0;
			};

			case IDC_RSCDISPLAYGARAGE_TAB_SUBANIMATION: {
				_selected = _checkboxTextures find (_ctrlList lbpicture _cursel);
				_ctrlList lbsetpicture [_cursel,_checkboxTextures select ((_selected + 1) % 2)];
				_initVehicle = true;
			};

			case IDC_RSCDISPLAYGARAGE_TAB_SUBTEXTURE: {
				_selected = _checkboxTextures find (_ctrlList lbpicture _cursel);
				for "_i" from 0 to (lbsize _ctrlList - 1) do {
					_ctrlList lbsetpicture [_i,_checkboxTextures select 0];
				};
				_ctrlList lbsetpicture [_cursel,_checkboxTextures select 1];
				_initVehicle = true;
			};

/*
			case IDC_RSCDISPLAYGARAGE_TAB_SUBANIMATION: {
				_animationClass = _ctrlList lbdata _cursel;
				_cfg = configfile >> "cfgvehicles" >> typeof _center >> "animationsources" >> _animationClass;
				_animationPhase = round ((_center animationphase _animationClass) + 1) % 2;
				_center animate [_animationClass,_animationPhase];
				_ctrlList lbsetpicture [_cursel,_checkboxTextures select _animationPhase];
			};
			case IDC_RSCDISPLAYGARAGE_TAB_SUBTEXTURE: {
				_textureClass = _ctrlList lbdata _cursel;
				_cfg = configfile >> "cfgvehicles" >> typeof _center >> "texturesources" >> _textureClass;
				{
					_center setobjecttexture [_foreachindex,_x];
				} foreach getarray (_cfg >> "textures");
			};
*/
		};
		if (_initVehicle) then {
			_ctrlListTextures = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYGARAGE_TAB_SUBTEXTURE);
			_ctrlListAnimations = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYGARAGE_TAB_SUBANIMATION);
			_textures = "";
			_animations = [];
			for "_i" from 0 to (lbsize _ctrlListTextures - 1) do {
				if ((_ctrlListTextures lbpicture _i) == (_checkboxTextures select 1)) exitwith {_textures = [_ctrlListTextures lbdata _i,1];};
			};
			for "_i" from 0 to (lbsize _ctrlListAnimations - 1) do {
				_animations pushback (_ctrlListAnimations lbdata _i);
				_animations pushback (_checkboxTextures find (_ctrlListAnimations lbpicture _i));
			};
			//_animations call bis_fnc_log;
			[_center,_textures,_animations,true] call bis_fnc_initVehicle;
		};
		
		["SetAnimationStatus",[_display]] call SELF_FUNC;
		["SetTextureStatus",[_display]] call SELF_FUNC;
		if (isclass _cfg) then {
			["ShowItemInfo",[_cfg]] call ARSENAL_FUNC;
			["ShowItemStats",[_cfgStats]] call SELF_FUNC;
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "SetAnimationStatus": 
	{
		_display = _this select 0;
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		_ctrlListAnimations = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYGARAGE_TAB_SUBANIMATION);
		for "_i" from 0 to (lbsize _ctrlListAnimations - 1) do {
			_selected = _center animationphase (_ctrlListAnimations lbdata _i);
			_ctrlListAnimations lbsetpicture [_i,_checkboxTextures select _selected];
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "SetTextureStatus": 
	{
		private _display = _this select 0;
		private _center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		private _ctrlListTextures = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYGARAGE_TAB_SUBTEXTURE);
		private _centerTextures = getObjectTextures _center;
		
		for "_i" from 0 to (lbsize _ctrlListTextures - 1) do 
		{
			private _cfg = configfile >> "cfgvehicles" >> typeof _center >> "texturesources" >> (_ctrlListTextures lbdata _i);
			
			private _configTextures = getarray (_cfg >> "textures");
			private _decals = getarray (_cfg >> "decals");
			private _selected = 
			({
				if !(_forEachIndex in _decals || { [_x, _configTextures param [_forEachIndex, ""]] call _fnc_compareTextures }) exitWith { false };
				true
			}
			forEach _centerTextures);
			
			_ctrlListTextures lbsetpicture [_i,_checkboxTextures select _selected];
		};
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "ShowItemStats": {
		_itemCfg = _this select 0;
		if (isclass _itemCfg) then {
			_ctrlStats = _display displayctrl IDC_RSCDISPLAYARSENAL_STATS_STATS;
			_ctrlStatsPos = ctrlposition _ctrlStats;
			_ctrlStatsPos set [0,0];
			_ctrlStatsPos set [1,0];
			_ctrlBackground = _display displayctrl IDC_RSCDISPLAYARSENAL_STATS_STATSBACKGROUND;
			_barMin = 0.01;
			_barMax = 1;

			_statControls = [
				[IDC_RSCDISPLAYARSENAL_STATS_STAT1,IDC_RSCDISPLAYARSENAL_STATS_STATTEXT1],
				[IDC_RSCDISPLAYARSENAL_STATS_STAT2,IDC_RSCDISPLAYARSENAL_STATS_STATTEXT2],
				[IDC_RSCDISPLAYARSENAL_STATS_STAT3,IDC_RSCDISPLAYARSENAL_STATS_STATTEXT3],
				[IDC_RSCDISPLAYARSENAL_STATS_STAT4,IDC_RSCDISPLAYARSENAL_STATS_STATTEXT4],
				[IDC_RSCDISPLAYARSENAL_STATS_STAT5,IDC_RSCDISPLAYARSENAL_STATS_STATTEXT5]
			];
			_rowH = 1 / (count _statControls + 1);
			_fnc_showStats = {
				_h = _rowH;
				{
					_ctrlStat = _display displayctrl ((_statControls select _foreachindex) select 0);
					_ctrlText = _display displayctrl ((_statControls select _foreachindex) select 1);
					if (count _x > 0) then {
						_ctrlStat progresssetposition (_x select 0);
						_ctrlText ctrlsettext toupper (_x select 1);
						_ctrlText ctrlsetfade 0;
						_ctrlText ctrlcommit 0;
						//_ctrlText ctrlshow true;
						_h = _h + _rowH;
					} else {
						_ctrlStat progresssetposition 0;
						_ctrlText ctrlsetfade 1;
						_ctrlText ctrlcommit 0;
						//_ctrlText ctrlshow false;
					};
				} foreach _this;
				_ctrlStatsPos set [1,(_ctrlStatsPos select 3) * (1 - _h)];
				_ctrlStatsPos set [3,(_ctrlStatsPos select 3) * _h];
				_ctrlBackground ctrlsetposition _ctrlStatsPos;
				_ctrlBackground ctrlcommit 0;
			};

			_ctrlStats ctrlsetfade 0;
			_statsExtremes = uinamespace getvariable "BIS_fnc_garage_stats";
			if !(isnil "_statsExtremes") then {
				_statsMin = _statsExtremes select 0;
				_statsMax = _statsExtremes select 1;

				_stats = [
					[_itemCfg],
					STATS,
					_statsMin
				] call bis_fnc_configExtremes;
				_stats = _stats select 1;

				_statMaxSpeed = linearConversion [_statsMin select 0,_statsMax select 0,_stats select 0,_barMin,_barMax];
				_statArmor = linearConversion [_statsMin select 1,_statsMax select 1,_stats select 1,_barMin,_barMax];
				_statFuelCapacity = linearConversion [_statsMin select 2,_statsMax select 2,_stats select 2,_barMin,_barMax];
				_statThreat = linearConversion [_statsMin select 3,_statsMax select 3,_stats select 3,_barMin,_barMax];
				[
					[],[],[],
					[_statMaxSpeed,localize "STR_A3_RSCDISPLAYGARAGE_STAT_MAX_SPEED"],
					[_statArmor,localize "STR_UI_ABAR"]/*
					[_statFuelCapacity,"Fuel capacity"],
					[_statThreat,"Threat"]*/
				] call _fnc_showStats;
			};

			_ctrlStats ctrlcommit FADE_DELAY;
		} else {
			_ctrlStats = _display displayctrl IDC_RSCDISPLAYARSENAL_STATS_STATS;
			_ctrlStats ctrlsetfade 1;
			_ctrlStats ctrlcommit FADE_DELAY;
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonImport": {};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonExport": {};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonRandom": {
		_display = _this select 0;

		if (is3DEN) then {

			//--- Select random animations
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYGARAGE_TAB_SUBANIMATION);
			for "_i" from 0 to (lbsize _ctrlList - 1) do {
				if (random 1 > 0.5) then {_ctrlList lbsetcursel _i;};
			};

			//--- Select random texture
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYGARAGE_TAB_SUBTEXTURE);
			_ctrlList lbsetcursel floor random (lbsize _ctrlList);

		} else {
			//--- Select random vehicle type
			{
				_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
				_ctrlList lbsetcursel -1;
			} foreach [IDCS_LEFT];

			//--- Select random item
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + (floor random (count [IDCS_LEFT] - 1)));
			_ctrlList lbsetcursel (floor random (lbsize _ctrlList - 1));
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "showTemplates": {
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonTemplateOK": {
	};

	///////////////////////////////////////////////////////////////////////////////////////////

	case "buttonOK": {
		_display = _this select 0;
		_display closedisplay 2;
		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call bis_fnc_textTiles;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
};