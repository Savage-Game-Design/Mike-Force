/*
	Author: 
		Karel Moricky, modified by Killzone_Kid

		Adapted for Mike Force by Savage Game Design

	Description:
		Splendid arsenal viewer

	Parameter(s):

		0: STRING - mode
		1: ANY - params (see below)

	Modes:
		"Open" - Open the Arsenal
			0 (Optional): BOOL - true to open full Arsenal, with all categories and items available (default: false)

		"Preload" - Preload item configs for Arsenal (without preloading, configs are parsed the first time Arsenal is opened)
			No params

		"AmmoboxInit" - Add virtual ammobox. Action to access the Arsenal will be added automatically on all clients.
			0: OBJECT - ammobox
			1 (Optional): BOOL - true to make all weapons and items in the game available in the box (default: false)
			2 (Optional): Condition for showing the Arsenal action (default: {true})
				      Passed arguments are the same as in addAction condition, i.e., _target - the box, _this - caller

		"AmmoboxExit" - Remove virtual ammobox
			0: OBJECT - ammobox


	Returns:
		NOTHING
*/

#include "\A3\ui_f\hpp\defineDIKCodes.inc"
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

#define SELF_NAME "vn_mf_fnc_garage_arsenal"
#define SELF_FUNC (missionNamespace getVariable SELF_NAME)
#define GARAGE_FUNC_NAME "vn_mf_fnc_garage_open"
#define GARAGE_FUNC (missionNamespace getVariable GARAGE_FUNC_NAME)
#define MAKE_UI_CALLBACK_FUNC (missionNamespace getVariable "vn_mf_fnc_garage_create_ui_callback")

#define DEFAULT_MATERIAL "\a3\data_f\default.rvmat"
#define DEFAULT_TEXTURE "#(rgb,8,8,3)color(0,0,0,0)"
#define FADE_DELAY	0.15

disableserialization;

private _fullVersion = missionnamespace getvariable ["BIS_fnc_arsenal_fullArsenal", false]; // INCLUDE IDENTITY
private _broadcastUpdates = isMultiplayer && _fullVersion;
private _mode = param [0, "Open", [displaynull, ""]];
private _confirmAction = param [2, false];
private _fastLookupTable = uiNamespace getVariable ["bis_fnc_arsenal_data", locationNull];

_this = param [1, []];

private _fnc_getFaceConfig = 
{	
	private _faces = missionnamespace getvariable ["BIS_fnc_arsenal_faces", [[],[]]];
	private _faceIndex = _faces select 0 findIf { _this == _x };
	if (_faceIndex > -1) exitWith { _faces select 1 select _faceIndex };
	configNull
};

private _fnc_setUnitInsignia = 
{
	params ["_unit", "_insignia", ["_global", false]];

	private _index = getArray (configFile >> "CfgVehicles" >> getText (configFile >> "CfgWeapons" >> uniform _unit >> "ItemInfo" >> "uniformClass") >> "hiddenSelections") findIf { _x == "insignia" };
	private _materialArray = [_index, getText (configfile >> "CfgUnitInsignia" >> _insignia >> "material") call {[_this, DEFAULT_MATERIAL] select (_this isEqualTo "")}];
	private _textureArray = [_index, getText (configfile >> "CfgUnitInsignia" >> _insignia >> "texture") call {[_this, DEFAULT_TEXTURE] select (_this isEqualTo "")}];
	
	_unit setVariable ["BIS_fnc_setUnitInsignia_class", [_insignia, nil] select (_insignia isEqualTo ""), true];	
	
	if (_global) exitWith 
	{
		_unit setObjectMaterialGlobal _materialArray;
		_unit setObjectTextureGlobal _textureArray;
	};
		
	_unit setObjectMaterial _materialArray;
	_unit setObjectTexture _textureArray;
};

private _fnc_getUnitInsignia  = { _this getVariable ["BIS_fnc_setUnitInsignia_class", ""] };

private _fnc_addBinoculars = 
{
	params ["_unit", "_binocs"];
	_unit removeWeapon binocular _unit;
	private _magazine = getArray (configFile >> "cfgWeapons" >> _binocs >> "magazines") param [0, ""];
	if (_magazine != "") then 
	{
		if (_unit canAdd _magazine) exitWith 
		{ 
			isNil 
			{
				_unit addMagazine _magazine;
				_unit addWeapon _binocs;
			};								
		};
	
		if (!isNull uniformContainer _unit) exitWith 
		{
			isNil 
			{
				uniformContainer _unit addMagazineCargoGlobal [_magazine, 1];
				_unit addWeapon _binocs;
			};								
		};
		
		if (!isNull vestContainer _unit) exitWith
		{
			isNil 
			{
				vestContainer _unit addMagazineCargoGlobal [_magazine, 1];
				_unit addWeapon _binocs;
			};		
		};

		if (!isNull backpackContainer _unit) exitWith 
		{
			isNil 
			{
				backpackContainer _unit addMagazineCargoGlobal [_magazine, 1];
				_unit addWeapon _binocs;
			};		
		};
		
		_unit forceAddUniform getText (configFile >> "CfgVehicles" >> "C_man_1" >> "uniformClass");
		_unit addmagazine _magazine;
		_unit addWeapon _binocs;
		removeUniform _unit;
	}
	else
	{
		_unit addWeapon _binocs;
	};
};

#define IDCS_LEFT\
	IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON,\
	IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON,\
	IDC_RSCDISPLAYARSENAL_TAB_HANDGUN,\
	IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,\
	IDC_RSCDISPLAYARSENAL_TAB_VEST,\
	IDC_RSCDISPLAYARSENAL_TAB_BACKPACK,\
	IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR,\
	IDC_RSCDISPLAYARSENAL_TAB_GOGGLES,\
	IDC_RSCDISPLAYARSENAL_TAB_NVGS,\
	IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS,\
	IDC_RSCDISPLAYARSENAL_TAB_MAP,\
	IDC_RSCDISPLAYARSENAL_TAB_GPS,\
	IDC_RSCDISPLAYARSENAL_TAB_RADIO,\
	IDC_RSCDISPLAYARSENAL_TAB_COMPASS,\
	IDC_RSCDISPLAYARSENAL_TAB_WATCH,\
	IDC_RSCDISPLAYARSENAL_TAB_FACE,\
	IDC_RSCDISPLAYARSENAL_TAB_VOICE,\
	IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA

#define IDCS_RIGHT\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,\
	IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,\
	IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC\

#define IDCS	[IDCS_LEFT,IDCS_RIGHT]

#define INITTYPES\
		private _types = [];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,["Uniform"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_VEST,["Vest"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_BACKPACK,["Backpack"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR,["Headgear"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_GOGGLES,["Glasses"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_NVGS,["NVGoggles"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS,["Binocular","LaserDesignator"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON,["AssaultRifle","MachineGun","SniperRifle","Shotgun","Rifle","SubmachineGun"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON,["Launcher","MissileLauncher","RocketLauncher"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_HANDGUN,["Handgun"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_MAP,["Map"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_GPS,["GPS","UAVTerminal"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_RADIO,["Radio"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_COMPASS,["Compass"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_WATCH,["Watch"]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_FACE,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_VOICE,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,[]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,[/*"Grenade","SmokeShell"*/]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,[/*"Mine","MineBounding","MineDirectional"*/]];\
		_types set [IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC,["FirstAidKit","Medikit","MineDetector","Toolkit"]];

#define GETVIRTUALCARGO\
	private _virtualItemCargo =\
		(missionnamespace call bis_fnc_getVirtualItemCargo) +\
		(_cargo call bis_fnc_getVirtualItemCargo) +\
		items _center +\
		assigneditems _center +\
		primaryweaponitems _center +\
		secondaryweaponitems _center +\
		handgunitems _center +\
		[uniform _center,vest _center,headgear _center,goggles _center];\
	private _virtualWeaponCargo = [];\
	{\
		_weapon = _x call bis_fnc_baseWeapon;\
		_virtualWeaponCargo set [count _virtualWeaponCargo,_weapon];\
		{\
			private ["_item"];\
			_item = gettext (_x >> "item");\
			if !(_item in _virtualItemCargo) then {_virtualItemCargo set [count _virtualItemCargo,_item];};\
		} foreach ((configfile >> "cfgweapons" >> _x >> "linkeditems") call bis_fnc_returnchildren);\
	} foreach ((missionnamespace call bis_fnc_getVirtualWeaponCargo) + (_cargo call bis_fnc_getVirtualWeaponCargo) + weapons _center + [binocular _center]);\
	private _virtualMagazineCargo = (missionnamespace call bis_fnc_getVirtualMagazineCargo) + (_cargo call bis_fnc_getVirtualMagazineCargo) + magazines _center;\
	private _virtualBackpackCargo = (missionnamespace call bis_fnc_getVirtualBackpackCargo) + (_cargo call bis_fnc_getVirtualBackpackCargo) + [backpack _center];

#define STATS_WEAPONS\
	["reloadtime","dispersion","maxzeroing","hit","mass","initSpeed"],\
	[true,true,false,true,false,false]

#define STATS_EQUIPMENT\
	["passthrough","armor","maximumLoad","mass"],\
	[false,false,false,false]

#define ADDBINOCULARSMAG\
	_magazines = getarray (configfile >> "cfgweapons" >> _item >> "magazines");\
	if (count _magazines > 0) then {_center addmagazine (_magazines select 0);};

#define CONDITION(ITEMLIST) (_fastLookupTable getVariable [_item, false] && { _fullVersion || { "%ALL" in ITEMLIST } || { ITEMLIST findIf { _item == _x } > -1 } })
#define ERROR if !(_item in _disabledItems) then {_disabledItems set [count _disabledItems,_item];};

//--- Function to get item DLC. Don't use item itself, but the first addon in which it's defined. SOme items are re-defined in mods.
//#define GETDLC	{configsourcemod _this}
#define GETDLC\
	{\
		private _dlc = "";\
		private _addons = configsourceaddonlist _this;\
		if (count _addons > 0) then {\
			private _mods = configsourcemodlist (configfile >> "CfgPatches" >> _addons select 0);\
			if (count _mods > 0) then {\
				_dlc = _mods select 0;\
			};\
		};\
		_dlc\
	}


#define ADDMODICON\
	{\
		private _dlcName = _this call GETDLC;\
		if (_dlcName != "") then {\
			_ctrlList lbsetpictureright [_lbAdd,(modParams [_dlcName,["logo"]]) param [0,""]];\
			_modID = _modList find _dlcName;\
			if (_modID < 0) then {_modID = _modList pushback _dlcName;};\
			_ctrlList lbsetvalue [_lbAdd,_modID];\
		};\
	};

//--- Defautl mod list for sorting
#define MODLIST ["","curator","kart","heli","mark","expansion","expansionpremium"]

#define CAM_DIS_MAX	7

///////////////////////////////////////////////////////////////////////////////////////////
if (_mode isEqualTo "draw3D") exitWith
{
	private _display = BIS_fnc_arsenal_display;

	private _cam = uinamespace getvariable ["BIS_fnc_arsenal_cam", objnull];
	private _center = missionnamespace getvariable ["BIS_fnc_arsenal_center", player];
	private _target = missionnamespace getvariable ["BIS_fnc_arsenal_target", player];

	BIS_fnc_arsenal_campos params ["_dis", "_dirH", "_dirV", "_targetPos"];

	[_target, [_dirH + 180, -_dirV, 0]] call bis_fnc_setobjectrotation;
	_target attachto [_center, _targetPos, ""]; //--- Reattach for smooth movement

	//_cam setvectordirandup [vectordirvisual _target, vectorupvisual _target];
	//_cam setPosASL (_target modeltoworldvisualworld [0, -_dis, 0]); //--- Don't use setPosASL, can be blacklisted on server
	_cam attachto [_target,[0, -_dis, 0],""];
	_cam setdir 0;

	//--- Make sure the camera is not underground
	if ((getPosASLVisual _cam select 2) < (getPosASLVisual _center select 2)) then 
	{
		//_cam setPosASL (_target modeltoworldvisualworld [0, -_dis * (((getPosASLVisual _target select 2) - (getPosASLVisual _center select 2)) / ((getPosASLVisual _target select 2) - (getPosASLVisual _cam select 2) + 0.001)), 0]);
		_cam attachto [_target,[0, -_dis * (((getPosASLVisual _target select 2) - (getPosASLVisual _center select 2)) / ((getPosASLVisual _target select 2) - (getPosASLVisual _cam select 2) + 0.001)), 0],""];
		_cam setdir 0;
	};

	if (BIS_fnc_arsenal_type == 0) then 
	{
		_selections = [];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,		["Pelvis",						[+0.00, +0.00, -0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_VEST,		["Spine3",						[+0.00, +0.00, +0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_BACKPACK,		["Spine3",						[+0.00, -0.20, +0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR,		["Head_axis",						[+0.00, +0.00, +0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_GOGGLES,		["Pilot",						[-0.04, +0.05, +0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_NVGS,		["Pilot",						[+0.00, -0.05, +0.05]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS,		["Pilot",						[+0.04, +0.05, +0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON,	["proxy:\A3\Characters_F\Proxies\weapon.001",		[+0.00, +0.00, +0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON,	["proxy:\A3\Characters_F\Proxies\launcher.001",		[+0.00, +0.00, +0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_HANDGUN,		["proxy:\A3\Characters_F\Proxies\pistol.001",		[+0.00, +0.00, +0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_MAP,			["",[0, 0,0]]];//["Pelvis",				[-0.15, +0.05, +0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_GPS,			["",[0, 0,0]]];//["Pelvis",				[-0.05, +0.10, +0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_RADIO,		["",[0, 0,0]]];//["Pelvis",				[+0.05, +0.10, +0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_COMPASS,		["",[0, 0,0]]];//["Pelvis",				[+0.15, +0.05, +0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_WATCH,		["",[0, 0,0]]];//["LeftForeArmRoll",			[+0.00, +0.00, +0.00]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_FACE,		["Head_axis",						[+0.05, +0.10, -0.05]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_VOICE,		["",[0, 0,0]]];//["Head_axis",				[-0.05, +0.10, -0.05]]];
		_selections set [IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA,		["LeftShoulder",					[+0.00, +0.00, +0.00]]];
		//_selections set [IDC_RSCDISPLAYARSENAL_TAB_MISC,		["",[0, 0,0]]];//["",					[+0.00, +0.00, +0.00]]];

		//_cam = (uinamespace getvariable ["BIS_fnc_arsenal_cam",player]);
		//_target = (uinamespace getvariable ["BIS_fnc_arsenal_target",player]);
		//_alpha = (1 / (_cam distance _target) - 1/3) * 0.75;

		_fade = 1;
		{
			_selPos = _center selectionposition (_x select 0);
			//if (_selPos distance [0,0,0] > 0) then {
			if (_selPos vectorDistanceSqr [0,0,0] > 0) then {
				//_selPos = [_selPos,_x select 1] call bis_fnc_vectorAdd;
				//_pos = _center modeltoworldvisual _selPos;
				//_uiPos = worldtoscreen _pos;
				_uiPos = worldtoscreen (_center modeltoworldvisual (_selPos vectorAdd (_x select 1)));
				if (count _uiPos > 0) then {
					//_fade = _fade min (_uiPos distance BIS_fnc_arsenal_mouse);
					_fade = _fade min (_uiPos distance2D BIS_fnc_arsenal_mouse);
					_index = _foreachindex;
					_ctrlPos = [];
					{
						_ctrl = _display displayctrl (_x + _index);
						_ctrlPos = ctrlposition _ctrl;
						_ctrlPos set [0,(_uiPos select 0) - (_ctrlPos select 2) * 0.5];
						_ctrlPos set [1,(_uiPos select 1) - (_ctrlPos select 3) * 0.5];
						_ctrl ctrlsetposition _ctrlPos;
						_ctrl ctrlcommit 0;
					} foreach [IDC_RSCDISPLAYARSENAL_ICON,IDC_RSCDISPLAYARSENAL_ICONBACKGROUND];

					_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _foreachindex);
					_ctrlLineIcon = _display displayctrl IDC_RSCDISPLAYARSENAL_LINEICON;
					if (ctrlfade _ctrlList == 0) then {
						_ctrlLinePosX = (_uiPos select 0) - (_ctrlPos select 2) * 0.5;
						_ctrlLineIcon ctrlsetposition [
							(_uiPos select 0) - (_ctrlPos select 2) * 0.5,
							_uiPos select 1,
							(ctrlposition _ctrlList select 0) + (ctrlposition _ctrlList select 2) - _ctrlLinePosX,
							0
						];
						_ctrlLineIcon ctrlsetfade 0;
						_ctrlLineIcon ctrlcommit 0;
					} else {
						if (ctrlfade _ctrlLineIcon == 0) then {
							_ctrlLineIcon ctrlsetfade 0.01;
							_ctrlLineIcon ctrlcommit 0;
							_ctrlLineIcon ctrlsetfade 1;
							_ctrlLineIcon ctrlcommit FADE_DELAY;
						};
					};
				};
			};
		} foreach _selections;

		_fade = ((_fade - safezoneW * 0.1) * safezoneW) max 0;
		{
			_index = _foreachindex;
			_ctrl = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICON + _index);
			_ctrlFade = if !(ctrlenabled _ctrl) then {0} else {_fade};
			{
				_ctrl = _display displayctrl (_x + _index);
				_ctrl ctrlsetfade _ctrlFade;
				_ctrl ctrlcommit 0;
			} foreach [IDC_RSCDISPLAYARSENAL_ICON,IDC_RSCDISPLAYARSENAL_ICONBACKGROUND];
		} foreach _selections;
	};

	//--- Grid
	_sphere = missionnamespace getvariable ["BIS_fnc_arsenal_sphere",objnull];
	if (is3DEN) then {
		for "_x" from -5 to 5 step 1 do {
			drawLine3D [
				_sphere modeltoworld [_x,-5,0],
				_sphere modeltoworld [_x,+5,0],
				[0.03,0.03,0.03,1]
			];
		};
		for "_y" from -5 to 5 step 1 do {
			drawLine3D [
				_sphere modeltoworld [-5,_y,0],
				_sphere modeltoworld [+5,_y,0],
				[0.03,0.03,0.03,1]
			];
		};
	};
};

///////////////////////////////////////////////////////////////////////////////////////////
if (_mode isEqualTo "Mouse") exitwith 
{
	params ["_ctrl", "_mX", "_mY"];
	BIS_fnc_arsenal_mouse = [_mX, _mY];

	private _cam = uinamespace getvariable ["BIS_fnc_arsenal_cam", objnull];
	private _center = missionnamespace getvariable ["BIS_fnc_arsenal_center", player];
	private _target = missionnamespace getvariable ["BIS_fnc_arsenal_target", player];

	BIS_fnc_arsenal_campos params ["_dis", "_dirH", "_dirV", "_targetPos"];
	BIS_fnc_arsenal_buttons params ["_LMB", "_RMB"];

	if (isnull _ctrl) then { _LMB = [0,0] }; //--- Init

	if (count _LMB > 0) then 
	{
		_LMB params ["_cX", "_cY"];
		BIS_fnc_arsenal_buttons set [0, [_mX, _mY]];

		boundingboxreal _center params ["_minBox", "_maxBox"];
		private _centerSizeBottom = _minBox select 2;
		private _centerSizeUp = _maxBox select 2;
		private _centerSize = sqrt ([_minBox select 0, _minBox select 1] distance2D [_maxBox select 0, _maxBox select 1]);
		
		private _z = _targetPos select 2;
		_targetPos = _targetPos getPos [(_cX - _mX) * _centerSize, _dirH - 90];
		_z = (_z - (_cY - _mY) * _centerSize) max _centerSizeBottom min _centerSizeUp;
		_targetPos = [0,0,0] getPos [([0,0,0] distance2D _targetPos) min _centerSize, [0,0,0] getDir _targetPos];
		_targetPos set [2, _z max ((_minBox select 2) + 0.2)];			
		//_targetPos set [2,(_targetPos select 2) max 0.1];
		
		//--- Do not let target go below ground
		//_posZmin = 0.1;
		//_targetWorldPosZ = (_center modelToWorldVisualWorld _targetPos) select 2;
		//if (_targetWorldPosZ < _posZmin) then { _targetPos set [2, (_targetPos select 2) - _targetWorldPosZ + _posZmin] };

		BIS_fnc_arsenal_campos set [3, _targetPos];
	};

	if (count _RMB > 0) then 
	{
		_RMB params ["_cX", "_cY"];

		private _dX = (_cX - _mX) * 0.75;
		private _dY = (_cY - _mY) * 0.75;
		private _z = _targetPos select 2;
		
		_targetPos = [0,0,0] getPos [[0,0,0] distance2D _targetPos, ([0,0,0] getDir _targetPos) - _dX * 180];
		_targetPos set [2, _z];
		
		BIS_fnc_arsenal_campos set [1, (_dirH - _dX * 180) % 360];
		BIS_fnc_arsenal_campos set [2, (_dirV - _dY * 100) max -89 min 89];
		BIS_fnc_arsenal_campos set [3, _targetPos];
		BIS_fnc_arsenal_buttons set [1, [_mX,_mY]];
	};

	if (isnull _ctrl) then { BIS_fnc_arsenal_buttons = [[],[]] };

	//--- Terminate when unit is dead
	if (!alive _center || isnull _center) then 
	{
		(ctrlparent (_this select 0)) closedisplay 2;
	};
};

///////////////////////////////////////////////////////////////////////////////////////////
if (_mode == "Open") exitWith // case insensitive
{
	if !(isnull (uinamespace getvariable ["BIS_fnc_arsenal_cam", objnull])) exitwith { "Arsenal Viewer is already running" call bis_fnc_logFormat };
	
	missionNamespace setVariable ["BIS_fnc_arsenal_fullArsenal", param [0, false, [false]]];
	missionNamespace setVariable ["BIS_fnc_arsenal_cargo", param [1, objnull, [objnull]]];
	
	private _center = param [2, player, [player]];
	if (!local _center) exitWith { ["Center must exist and be local"] call BIS_fnc_error };
	missionNamespace setVariable ["BIS_fnc_arsenal_center", _center];
	
	private _displayMission = [] call BIS_fnc_displayMission;
	if !(isnull finddisplay 312) then { _displayMission = finddisplay 312 };
	if (is3DEN) then { _displayMission = finddisplay 313 };
	_displayMission createdisplay "RscDisplayArsenal";
};

switch _mode do
{
	///////////////////////////////////////////////////////////////////////////////////////////
	case "MouseButtonDown": { BIS_fnc_arsenal_buttons set [_this select 1, [_this select 2, _this select 3]] };

	///////////////////////////////////////////////////////////////////////////////////////////
	case "MouseButtonUp": { BIS_fnc_arsenal_buttons set [_this select 1,[]] };

	///////////////////////////////////////////////////////////////////////////////////////////
	case "MouseZChanged": 
	{
		private _cam = uinamespace getvariable ["BIS_fnc_arsenal_cam", objnull];
		private _center = missionnamespace getvariable ["BIS_fnc_arsenal_center", player];
		private _target = missionnamespace getvariable ["BIS_fnc_arsenal_target", player];
		
		//_disMax = if (bis_fnc_arsenal_type > 0) then {sizeof typeof _center * 1.5} else {CAM_DIS_MAX};
		private _disMax = if (bis_fnc_arsenal_type > 0) then { (boundingboxreal _center select 0 vectordistance (boundingboxreal _center select 1)) * 1.5 } else { CAM_DIS_MAX };
		private _dis = BIS_fnc_arsenal_campos select 0;
		_dis = _dis - ((_this select 1) / 10);
		_dis = _dis max (_disMax * 0.15) min _disMax;
		BIS_fnc_arsenal_campos set [0, _dis];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Init": 
	{
		private _CFGVEHICLES = configfile >> "CfgVehicles";
		["bis_fnc_arsenal"] call bis_fnc_startloadingscreen;
		
		private _display = _this select 0;
		private _toggleSpace = uinamespace getvariable ["BIS_fnc_arsenal_toggleSpace", false];
		private _center = missionnamespace getvariable ["BIS_fnc_arsenal_center", player];
		
		BIS_fnc_arsenal_type = 0; //--- 0 - Arsenal, 1 - Garage
		BIS_fnc_arsenal_toggleSpace = nil;

		if !(is3DEN) then 
		{
			if (_fullVersion) then 
			{
				if (missionname == "Arsenal") then 
				{
					moveout player;
					player switchaction "playerstand";
					[player,0] call bis_fnc_setheight;
				};

				//--- Default appearance (only at the mission start)
				if (time < 1) then 
				{
					uinamespace getvariable ["bis_fnc_arsenal_defaultClass", []] params 
					[
						["_defaultClass", "", [""]],
						["_defaultItems", [], [[]]],
						["_defaultShow", -1, [0]]
					];
					
					if (isclass (_CFGVEHICLES >> _defaultClass)) then 
					{
						//--- Load specific class (e.g., when defined by mod browser)
						[player, _defaultClass] call bis_fnc_loadinventory;
						uinamespace setvariable ["bis_fnc_arsenal_defaultItems", _defaultItems];
						uinamespace setvariable ["bis_fnc_arsenal_defaultShow", _defaultShow];
					} 
					else 
					{
						//--- Randomize default loadout
						[
							player, 
							selectRandom (("getnumber (_x >> 'scope') > 1 && gettext (_x >> 'simulation') == 'soldier'" configclasses _CFGVEHICLES) apply {configname _x})
						] 
						call bis_fnc_loadinventory;
					};
					
					player switchMove "";
					uinamespace setvariable ["bis_fnc_arsenal_defaultClass", nil];
				};
			};
		};

		//INITTYPES 
		["InitGUI", [_display, SELF_NAME]] call SELF_FUNC;
		["Preload"] call SELF_FUNC;
		["ListAdd", [_display]] call SELF_FUNC;
		["ListSelectCurrent", [_display]] call SELF_FUNC;

		//--- Save default weapon type
		BIS_fnc_arsenal_selectedWeaponType = switch currentweapon _center do 
		{
			case (primaryweapon _center): {0};
			case (secondaryweapon _center): {1};
			case (handgunweapon _center): {2};
			default {-1};
		};

		//--- Load stats
		if (isnil {uinamespace getvariable "bis_fnc_arsenal_weaponStats"}) then {
			uinamespace setvariable [
				"bis_fnc_arsenal_weaponStats",
				[
					("getnumber (_x >> 'scope') == 2 && getnumber (_x >> 'type') < 5") configclasses (configfile >> "cfgweapons"),
					STATS_WEAPONS
				] call bis_fnc_configExtremes
			];
		};
		if (isnil {uinamespace getvariable "bis_fnc_arsenal_equipmentStats"}) then {
			_statsEquipment = [
				("getnumber (_x >> 'scope') == 2 && getnumber (_x >> 'itemInfo' >> 'type') in [605,701,801]") configclasses (configfile >> "cfgweapons"),
				STATS_EQUIPMENT
			] call bis_fnc_configExtremes;
			_statsBackpacks = [
				("getnumber (_x >> 'scope') == 2 && getnumber (_x >> 'isBackpack') == 1") configclasses (configfile >> "cfgvehicles"),
				STATS_EQUIPMENT
			] call bis_fnc_configExtremes;

			_statsEquipmentMin = _statsEquipment select 0;
			_statsEquipmentMax = _statsEquipment select 1;
			_statsBackpacksMin = _statsBackpacks select 0;
			_statsBackpacksMax = _statsBackpacks select 1;
			for "_i" from 2 to 3 do { //--- Ignore backpack armor and passThrough, has no effect
				_statsEquipmentMin set [_i,(_statsEquipmentMin select _i) min (_statsBackpacksMin select _i)];
				_statsEquipmentMax set [_i,(_statsEquipmentMax select _i) max (_statsBackpacksMax select _i)];
			};

			uinamespace setvariable ["bis_fnc_arsenal_equipmentStats",[_statsEquipmentMin,_statsEquipmentMax]];
		};

		with missionnamespace do {
			[missionnamespace,"arsenalOpened",[_display,_toggleSpace]] call bis_fnc_callscriptedeventhandler;
		};
		["bis_fnc_arsenal"] call bis_fnc_endloadingscreen;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "InitGUI": 
	{
		params ["_display", "_function"];

		BIS_fnc_arsenal_display = _display;
		BIS_fnc_arsenal_mouse = [0,0];
		BIS_fnc_arsenal_buttons = [[],[]];
		BIS_fnc_arsenal_action = "";
		
		private _center = missionnamespace getvariable ["BIS_fnc_arsenal_center", player];
		_center hideobject false;
		cuttext ["","plain"];
		showcommandingmenu "";
		//["#(argb,8,8,3)color(0,0,0,1)",false,nil,0.1,[0,0.5]] spawn bis_fnc_textTiles;

		//--- Force internal view to enable consistent screen blurring. Restore the original view after closing Arsenal.
		BIS_fnc_arsenal_cameraview = cameraview;
		player switchcamera "internal";

		showhud false;

		if (is3DEN) then 
		{
			private _isArsenal = _function == SELF_NAME;
			private _centerOrig = _center;
			private _centerPos = getPosASLVisual _centerOrig  vectorAdd [0,0,500];
			
			private _sphere = createvehicle ["Sphere_3DEN",_centerPos, [], 0, "none"];
			_sphere setDir 0;
			_sphere setPosASL _centerPos;
			_sphere setobjecttexture [0,"#(argb,8,8,3)color(0.93,1.0,0.98,0.028,co)"];
			_sphere setobjecttexture [1,"#(argb,8,8,3)color(0.93,1.0,0.98,0.01,co)"];
			
			private _params = [typeof _centerOrig, _centerPos, [], 0, "none"];
			_center = if (_isArsenal) then { createagent _params } else { createvehicle _params };
			_center setDir 0;
			_center setPosASL getPosASLVisual _sphere; //[getPosASLVisual _sphere select 0,getPosASLVisual _sphere select 1,(getPosASLVisual _sphere select 2) - 4];
			_center switchmove animationstate _centerOrig;
			_center switchaction "playerstand";
			
			if (_isArsenal) then 
			{
				[_centerOrig, [_center, "arsenal"]] call bis_fnc_saveInventory;
				[_center, [_center, "arsenal"]] call bis_fnc_loadInventory;
			} 
			else 
			{
				{ _center setobjecttexture [_foreachindex, _x] } foreach getobjecttextures _centerOrig;

				{
					private _configname = configname _x;
					private _params = [_configname, _centerOrig animationphase _configname, true];
					_center animate _params;
					_center animateDoor _params;
					[_center, _centerOrig animationphase _configname] call compile (getText(configfile >> "CfgVehicles" >> typeOf _center >> "AnimationSources" >> _configname >> "onPhaseChanged"));
				} 
				foreach configproperties [configfile >> "cfgvehicles" >> typeof _center >> "animationsources", "isclass _x"];
			};
			
			_center enablesimulation false;

			//--- Create light for night editing (code based on BIS_fnc_3DENFlashlight)
			_intensity = 20;
			_light = "#lightpoint" createvehicle _centerPos;
			_light setlightbrightness _intensity;
			_light setlightambient [1,1,1];
			_light setlightcolor [0,0,0];
			_light lightattachobject [_sphere,[0,0,-_intensity * 7]];

			//--- Save to global variables, so it can be deleted latger
			missionnamespace setvariable ["BIS_fnc_arsenal_light",_light];
			missionnamespace setvariable ["BIS_fnc_arsenal_centerOrig",_centerOrig];
			missionnamespace setvariable ["BIS_fnc_arsenal_center",_center];
			missionnamespace setvariable ["BIS_fnc_arsenal_sphere",_sphere];

			//--- Use the same vision mode as in Eden
			missionnamespace setvariable ["BIS_fnc_arsenal_visionMode",-2 call bis_fnc_3DENVisionMode];
			["ShowInterface",false] spawn bis_fnc_3DENInterface;
			if (get3denactionstate "togglemap" > 0) then { do3DENAction "togglemap" };
		};

		_display displayaddeventhandler ["mousebuttondown",["['MouseButtonDown',_this]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];
		_display displayaddeventhandler ["mousebuttonup",["['MouseButtonUp',_this]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];
		_display displayaddeventhandler ["keydown",["['KeyDown',_this]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];

		_ctrlMouseArea = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEAREA;
		_ctrlMouseArea ctrladdeventhandler ["mousemoving",["['Mouse',_this]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];
		_ctrlMouseArea ctrladdeventhandler ["mouseholding",["['Mouse',_this]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];
		_ctrlMouseArea ctrladdeventhandler ["mousebuttonclick",["['TabDeselect',[ctrlparent (_this select 0),_this select 1]]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];
		_ctrlMouseArea ctrladdeventhandler ["mousezchanged",["['MouseZChanged',_this]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];
		ctrlsetfocus _ctrlMouseArea;

		_ctrlMouseBlock = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
		_ctrlMouseBlock ctrlenable false;
		_ctrlMouseBlock ctrladdeventhandler ["setfocus",{_this spawn {disableserialization; (_this select 0) ctrlenable false; (_this select 0) ctrlenable true;};}];

		_ctrlMessage = _display displayctrl IDC_RSCDISPLAYARSENAL_MESSAGE;
		_ctrlMessage ctrlsetfade 1;
		_ctrlMessage ctrlcommit 0;

		_ctrlInfo = _display displayctrl IDC_RSCDISPLAYARSENAL_INFO_INFO;
		_ctrlInfo ctrlsetfade 1;
		_ctrlInfo ctrlcommit 0;

		_ctrlStats = _display displayctrl IDC_RSCDISPLAYARSENAL_STATS_STATS;
		_ctrlStats ctrlsetfade 1;
		_ctrlStats ctrlenable false;
		_ctrlStats ctrlcommit 0;

		//--- UI event handlers
		_ctrlButtonInterface = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONINTERFACE;
		_ctrlButtonInterface ctrladdeventhandler ["buttonclick", ["['buttonInterface',[ctrlparent (_this select 0)]]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];

		_ctrlButtonRandom = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONRANDOM;
		_ctrlButtonRandom ctrladdeventhandler ["buttonclick", ["['buttonRandom',[ctrlparent (_this select 0)]]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];

		_ctrlButtonSave = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONSAVE;
		_ctrlButtonSave ctrladdeventhandler ["buttonclick",["['buttonSave',[ctrlparent (_this select 0)]]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];

		_ctrlButtonLoad = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONLOAD;
		_ctrlButtonLoad ctrladdeventhandler ["buttonclick",["['buttonLoad',[ctrlparent (_this select 0)]]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];

		_ctrlButtonExport = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONEXPORT;
		_ctrlButtonExport ctrladdeventhandler ["buttonclick",["['buttonExport',[ctrlparent (_this select 0),'init']]", _function] call MAKE_UI_CALLBACK_FUNC];
		_ctrlButtonExport ctrlenable isServer; // only server can copy to clipboard in MP

		_ctrlButtonImport = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONIMPORT;
		_ctrlButtonImport ctrladdeventhandler ["buttonclick",["['buttonImport',[ctrlparent (_this select 0),'init']]", _function] call MAKE_UI_CALLBACK_FUNC];
		_ctrlButtonImport ctrlenable !ismultiplayer; // cannot copy from clipboard in MP

		_ctrlButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONOK;
		_ctrlButtonOK ctrladdeventhandler ["buttonclick",["['buttonOK',[ctrlparent (_this select 0),'init']]", _function] call MAKE_UI_CALLBACK_FUNC];

		_ctrlButtonTry = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONTRY;
		_ctrlButtonTry ctrladdeventhandler ["buttonclick",["['buttonTry',[ctrlparent (_this select 0)]]", GARAGE_FUNC_NAME] call MAKE_UI_CALLBACK_FUNC];

		_ctrlArrowLeft = _display displayctrl IDC_RSCDISPLAYARSENAL_ARROWLEFT;
		_ctrlArrowLeft ctrladdeventhandler ["buttonclick",["['buttonCargo',[ctrlparent (_this select 0),-1]]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];

		_ctrlArrowRight = _display displayctrl IDC_RSCDISPLAYARSENAL_ARROWRIGHT;
		_ctrlArrowRight ctrladdeventhandler ["buttonclick",["['buttonCargo',[ctrlparent (_this select 0),+1]]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];

		_ctrlTemplateButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		_ctrlTemplateButtonOK ctrladdeventhandler ["buttonclick",["['buttonTemplateOK',[ctrlparent (_this select 0)]]", _function] call MAKE_UI_CALLBACK_FUNC];

		_ctrlTemplateButtonCancel = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONCANCEL;
		_ctrlTemplateButtonCancel ctrladdeventhandler ["buttonclick",["['buttonTemplateCancel',[ctrlparent (_this select 0)]]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];

		_ctrlTemplateButtonDelete = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
		_ctrlTemplateButtonDelete ctrladdeventhandler ["buttonclick",["['buttonTemplateDelete',[ctrlparent (_this select 0)],true]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];

		_ctrlTemplateValue = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_ctrlTemplateValue ctrladdeventhandler ["lbselchanged",["['templateSelChanged',[ctrlparent (_this select 0)]]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];
		_ctrlTemplateValue ctrladdeventhandler ["lbdblclick",["['buttonTemplateOK',[ctrlparent (_this select 0)]]", _function] call MAKE_UI_CALLBACK_FUNC];

		//--- Menus
		_ctrlIcon = _display displayctrl IDC_RSCDISPLAYARSENAL_TAB;
		_sortValues = uinamespace getvariable ["bis_fnc_arsenal_sort",[]];
		
		if !(isnull _ctrlIcon) then 
		{
			_ctrlIconPos = ctrlposition _ctrlIcon;
			_ctrlTabs = _display displayctrl IDC_RSCDISPLAYARSENAL_TABS;
			_ctrlTabsPos = ctrlposition _ctrlTabs;
			_ctrlTabsPosX = _ctrlTabsPos select 0;
			_ctrlTabsPosY = _ctrlTabsPos select 1;
			_ctrlIconPosW = _ctrlIconPos select 2;
			_ctrlIconPosH = _ctrlIconPos select 3;
			_columns = (_ctrlTabsPos select 2) / _ctrlIconPosW;
			_rows = (_ctrlTabsPos select 3) / _ctrlIconPosH;
			_gridH = ctrlposition _ctrlTemplateButtonOK select 3;

			{
				_idc = _x;
				_ctrlIcon = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICON + _idc);
				_ctrlTab = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
				_mode = if (_idc in [IDCS_LEFT]) then {"TabSelectLeft"} else {"TabSelectRight"};
				
				{
					_x ctrladdeventhandler [
						"buttonclick",
						[
							format ["['%2',[ctrlparent (_this select 0),%1]]", _idc, _mode], 
							_function
						] call MAKE_UI_CALLBACK_FUNC
					];
					_x ctrladdeventhandler ["mousezchanged",["['MouseZChanged',_this]", SELF_NAME] call MAKE_UI_CALLBACK_FUNC];
				} 
				foreach [_ctrlIcon,_ctrlTab];

				_sort = _sortValues param [_idc,0];
				_ctrlSort = _display displayctrl (IDC_RSCDISPLAYARSENAL_SORT + _idc);
				_ctrlSort ctrladdeventhandler ["lbselchanged",[format ["['lbSort',[_this,%1]]", _idc], SELF_NAME] call MAKE_UI_CALLBACK_FUNC];
				_ctrlSort lbsetcursel _sort;
				_sortValues set [_idc,_sort];

				_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc);
				_ctrlList ctrlenable false;
				_ctrlList ctrlsetfade 1;
				_ctrlList ctrlsetfontheight (_gridH * 0.8);
				_ctrlList ctrlcommit 0;

				_ctrlList ctrladdeventhandler ["lbselchanged",[format ["['SelectItem',[ctrlparent (_this select 0),(_this select 0),%1]]", _idc], _function] call MAKE_UI_CALLBACK_FUNC];
				_ctrlList ctrladdeventhandler ["lbdblclick",[format ["['ShowItem',[ctrlparent (_this select 0),(_this select 0),%1]]", _idc], SELF_NAME, nil, 'spawn'] call MAKE_UI_CALLBACK_FUNC];

				_ctrlListDisabled = _display displayctrl (IDC_RSCDISPLAYARSENAL_LISTDISABLED + _idc);
				_ctrlListDisabled ctrlenable false;

				_ctrlSort ctrlsetfade 1;
				_ctrlSort ctrlcommit 0;
			} 
			foreach IDCS;
		};
		
		uinamespace setvariable ["bis_fnc_arsenal_sort",_sortValues];
		['TabDeselect',[_display,-1]] call SELF_FUNC;
		['SelectItem',[_display,controlnull,-1]] call (missionNamespace getvariable _function);

		_ctrlButtonClose = _display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONCLOSE;
		_ctrlButtonClose ctrladdeventhandler ["buttonclick",
			format [
				"%1; true",
				["['buttonClose',[ctrlparent (_this select 0)]]", SELF_NAME, nil, 'spawn'] call MAKE_UI_CALLBACK_FUNC
			]
		];

		if (is3DEN) then 
		{
			_ctrlButtonClose ctrlsettext localize "STR_DISP_CANCEL";
			_ctrlButtonClose ctrlsettooltip "";
			_ctrlButtonOK ctrlsettext localize "STR_DISP_OK";
			_ctrlButtonOK ctrlsettooltip "";
		} 
		else 
		{
			if (missionname == "Arsenal") then 
			{
				_ctrlButtonClose ctrlsettext localize "STR_DISP_ARCMAP_EXIT";
			};
			
			if (missionname != "arsenal") then 
			{
				_ctrlButtonOK ctrlsettext "";
				_ctrlButtonOK ctrlenable false;
				_ctrlButtonOK ctrlsettooltip "";
				_ctrlButtonTry ctrlsettext "";
				_ctrlButtonTry ctrlenable false;
				_ctrlButtonTry ctrlsettooltip "";
			};
		};
		
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlenable false;
			_ctrl ctrlsetfade 1;
			_ctrl ctrlcommit 0;
		} 
		foreach 
		[
			IDC_RSCDISPLAYARSENAL_FRAMELEFT,
			IDC_RSCDISPLAYARSENAL_FRAMERIGHT,
			IDC_RSCDISPLAYARSENAL_BACKGROUNDLEFT,
			IDC_RSCDISPLAYARSENAL_BACKGROUNDRIGHT,
			IDC_RSCDISPLAYARSENAL_LINEICON,
			IDC_RSCDISPLAYARSENAL_LINETABLEFT,
			IDC_RSCDISPLAYARSENAL_LINETABRIGHT,
			IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE
		];

		if (_fullVersion && !is3DEN) then 
		{
			if (missionname == "Arsenal") then 
			{
				_ctrlSpace = _display displayctrl IDC_RSCDISPLAYARSENAL_SPACE_SPACE;
				_ctrlSpace ctrlshow true;
				{
					_ctrl = _display displayctrl (_x select 0);
					_ctrlBackground = _display displayctrl (_x select 1);
					_ctrl ctrladdeventhandler ["buttonclick", 
						format [
							"%1; true",
							["['buttonSpace',_this]", SELF_NAME, nil, 'spawn']  call MAKE_UI_CALLBACK_FUNC
						]
					];
					if (_foreachindex == bis_fnc_arsenal_type) then 
					{
						_ctrl ctrlenable false;
						_ctrl ctrlsettextcolor [1,1,1,1];
						_ctrlBackground ctrlsetbackgroundcolor [0,0,0,1];
					};
				} 
				foreach 
				[
					[IDC_RSCDISPLAYARSENAL_SPACE_SPACEARSENAL,IDC_RSCDISPLAYARSENAL_SPACE_SPACEARSENALBACKGROUND],
					[IDC_RSCDISPLAYARSENAL_SPACE_SPACEGARAGE,IDC_RSCDISPLAYARSENAL_SPACE_SPACEGARAGEBACKGROUND]
				];
			} 
			else 
			{
				_ctrlSpace = _display displayctrl IDC_RSCDISPLAYARSENAL_SPACE_SPACE;
				_ctrlSpace ctrlsetposition [-1,-1,0,0];
				_ctrlSpace ctrlcommit 0;
			};
		} 
		else 
		{
			{
				_tab = _x;
				{
					_ctrl = _display displayctrl (_tab + _x);
					_ctrl ctrlshow false;
					_ctrl ctrlenable false;
					_ctrl ctrlremovealleventhandlers "buttonclick";
					_ctrl ctrlremovealleventhandlers "mousezchanged";
					_ctrl ctrlremovealleventhandlers "lbselchanged";
					_ctrl ctrlremovealleventhandlers "lbdblclick";
					_ctrl ctrlsetposition [0,0,0,0];
					_ctrl ctrlcommit 0;
				} 
				foreach [IDC_RSCDISPLAYARSENAL_TAB,IDC_RSCDISPLAYARSENAL_ICON,IDC_RSCDISPLAYARSENAL_ICONBACKGROUND];
			} 
			foreach 
			[
				IDC_RSCDISPLAYARSENAL_TAB_FACE,
				IDC_RSCDISPLAYARSENAL_TAB_VOICE,
				IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA
			];
			
			_ctrlSpace = _display displayctrl IDC_RSCDISPLAYARSENAL_SPACE_SPACE;
			_ctrlSpace ctrlsetposition [-1,-1,0,0];
			_ctrlSpace ctrlcommit 0;
		};

		//--- Camera init
		private _camPosVar = format ["BIS_fnc_arsenal_campos_%1", BIS_fnc_arsenal_type];
		if (isNil { missionnamespace getvariable _camPosVar }) then
		{
			// force reset on mission restart
			missionnamespace setvariable [_camPosVar, [[10,-45,15,[0,0,-1]], [5,0,0,[0,0,0.85]]] select (BIS_fnc_arsenal_type == 0)];
		};
		
		BIS_fnc_arsenal_campos = +(missionnamespace getVariable _camPosVar);
		private _posCenter = getPosASLVisual _center;
		
		private _target = createagent ["Logic", _posCenter, [], 0, "none"];
		//_target setPosASL _posCenter;
		_target attachto [_center, BIS_fnc_arsenal_campos select 3, ""];
		missionnamespace setvariable ["BIS_fnc_arsenal_target", _target];

		private _cam = "camera" camcreate _posCenter;
		//_cam setPosASL _posCenter;
		_cam cameraeffect ["internal", "back"];
		_cam campreparefocus [-1,-1];
		_cam campreparefov 0.35;
		_cam camcommitprepared 0;
		//cameraEffectEnableHUD true;
		showcinemaborder false;
		BIS_fnc_arsenal_cam = _cam;
		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call bis_fnc_textTiles;

		//--- Camera reset
		["Mouse", [controlnull, 0, 0]] call SELF_FUNC;
		BIS_fnc_arsenal_draw3D = addMissionEventHandler ["draw3D", { with uiNamespace do { ["draw3D"] call SELF_FUNC } }];

		setacctime (missionnamespace getvariable ["BIS_fnc_arsenal_acctime",1]);
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Preload": 
	{
		private _data = missionNamespace getVariable "bis_fnc_arsenal_data";
		
		if (isNil "_data" || isNull _fastLookupTable || _this isEqualTo true) then // or force preload
		{
			deleteLocation _fastLookupTable;
			_fastLookupTable = createLocation ["Invisible", [0,0,0], 0, 0];
			
			private _CFGWEAPONS = configFile >> "CfgWeapons";
			private _CFGMAGAZINES = configFile >> "CfgMagazines";
			
			private _fnc_dataPushBack = 
			{
				params ["_index", "_className"];
				_data select _index pushBack _className;
				_fastLookupTable setVariable [_className, true];
				true
			};
			
			private _fnc_testItemAndStore =
			{
				params ["_config", "_className"];
				if (getNumber (_config >> "scope") == 0) exitWith {};
				_fastLookupTable setVariable [_className, true];
				//while { getNumber (_config >> "scope") == 1 } do { _config = inheritsFrom _config };
				//if (getNumber (_config >> "scope") == 2 ) then { _fastLookupTable setVariable [_className, true] };
			};
			
			["bis_fnc_arsenal_preload"] call BIS_fnc_startLoadingScreen;
			INITTYPES
			_data = [];
			{ _data set [_x, []] } forEach IDCS;

			private _configArray = (
				("true" configClasses _CFGWEAPONS) +
				("true" configClasses (configFile >> "CfgVehicles")) +
				("true" configClasses (configFile >> "CfgGlasses"))
			);
			
			{
				private _itemAdded = false;
				private _className = configName _x;				
				private _itemScope = if (isNumber (_x >> "scopeArsenal")) then { getNumber (_x >> "scopeArsenal") } else { getNumber (_x >> "scope") };
				
				if (
					_itemScope == 2 
					&& 
					{ getText (_x >> "model") != "" } 
					&& 
					{ if (isArray (_x >> "muzzles")) then { _className call bis_fnc_baseWeapon == _className } else { true } } //-- Check if base weapon (true for all entity types)
				) 
				then 
				{
					_className call bis_fnc_itemType params ["_weaponTypeCategory", "_weaponTypeSpecific"];
					if (_weaponTypeCategory != "VehicleWeapon") then 
					{						
						private _typesDataIndex = _types findIf { _weaponTypeSpecific in _x }; // _types is part of macro
						if (_typesDataIndex > -1) then { _itemAdded = [_typesDataIndex, _className] call _fnc_dataPushBack };
					};
				};
				
				if (!_itemAdded) then { [_x, _className] call _fnc_testItemAndStore };
				
				progressLoadingScreen linearConversion [0, count _configArray, _foreachindex + 1, 0, 1, true];
			} 
			foreach _configArray;

			//--- Faces
			if (!is3DEN) then 
			{
				private _faces = [[],[]]; //[names,configs] - all faces
				{	
					{
						private _itemAdded = false;
						private _className = configName _x;
						
						if (getText (_x >> "head") != "" && _className != "Default") then
						{
							_faces select 0 pushBack _className;
							_faces select 1 pushBack _x;
							if (getNumber (_x >> "disabled") > 0) exitWith {}; 	
							_itemAdded = [IDC_RSCDISPLAYARSENAL_TAB_FACE, _className] call _fnc_dataPushBack;
						};
						
						if (!_itemAdded) then { [_x, _className] call _fnc_testItemAndStore };
					} 
					forEach ("true" configClasses _x);
				} 
				forEach ("true" configClasses (configfile >> "cfgfaces"));
				
				// store all faces names and configs
				missionNamespace setVariable ["BIS_fnc_arsenal_faces", _faces];
				
				//--- Voices
				{
					private _itemAdded = false;
					private _className = configName _x;			
					private _itemScope = if (isNumber (_x >> "scopeArsenal")) then { getNumber (_x >> "scopeArsenal") } else { getNumber (_x >> "scope") };
					
					if (
						_itemScope == 2 
						&& 
						getText (_x >> "protocol") != "RadioProtocolBase"
					) 
					then 
					{
						_itemAdded = [IDC_RSCDISPLAYARSENAL_TAB_VOICE, _className] call _fnc_dataPushBack;
					};
					
					if (!_itemAdded) then { [_x, _className] call _fnc_testItemAndStore };
				} 
				forEach ("true" configClasses (configFile >> "cfgVoice"));

				//--- Insignia
				{
					private _itemAdded = false;
					private _className = configName _x;	
					private _itemScope = if (isNumber (_x >> "scope")) then { getNumber (_x >> "scope") } else { 2 };
						
					if (_itemScope == 2) then 
					{
						_itemAdded = [IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA, _className] call _fnc_dataPushBack;
					};
					
					if (!_itemAdded) then { [_x, _className] call _fnc_testItemAndStore };
				} 
				foreach ("true" configclasses (configfile >> "cfgunitinsignia"));
			};

			//--- Magazines - Put and Throw
			private _magazinesThrowPut = [];
			
			{
				_x params ["_weapon", "_tab"];
				private _magazines = [];
				{
					{
						private _mag = toLower _x;
						if (_magazines pushBackUnique _mag > -1) then
						{
							private _cfgMag = _CFGMAGAZINES >> _mag;
							private _itemAdded = false;
							private _className = configName _cfgMag;
														
							if (getNumber (_cfgMag >> "scope") == 2 || getNumber (_cfgMag >> "scopeArsenal") == 2) then 
							{
								_itemAdded = [_tab, _className] call _fnc_dataPushBack;
								_magazinesThrowPut pushBack _mag;
							};
							
							if (!_itemAdded) then { [_cfgMag, _className] call _fnc_testItemAndStore };
						};
					}
					foreach getarray (_x >> "magazines");
				} 
				foreach ("true" configClasses (_CFGWEAPONS >> _weapon));
			} 
			foreach 
			[
				["throw", IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW],
				["put", IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT]
			];

			//--- Magazines
			//private _ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL);
			{
				private _itemAdded = false;
				private _className = configName _x;	
				
				if (
					getNumber (_x >> "type") > 0 
					&& 
					{ 
						(getNumber (_x >> "scope") == 2 || getNumber (_x >> "scopeArsenal") == 2) 
						&& 
						{ !(toLower _className in _magazinesThrowPut) } 
					}
				) 
				then 
				{
					_itemAdded = [IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL, _className] call _fnc_dataPushBack;
				};
				
				if (!_itemAdded) then { [_x, _className] call _fnc_testItemAndStore };
			} 
			foreach ("true" configClasses _CFGMAGAZINES);

			missionNamespace setVariable ["bis_fnc_arsenal_data", _data];
			
			// allow in loadout
			private _whitelist = ["Default", "NoVoice"];
			{_fastLookupTable setVariable [_x, true]} forEach _whitelist;
			// disallow in loadout
			private _blacklist = ["U_VirtualMan_F"];
			{_fastLookupTable setVariable [_x, false]} forEach _blacklist;
			
			uiNamespace setVariable ["bis_fnc_arsenal_data", _fastLookupTable];
			["bis_fnc_arsenal_preload"] call bis_fnc_endloadingscreen;
			true
		} else {
			false
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Exit": 
	{
		removemissioneventhandler ["draw3D", BIS_fnc_arsenal_draw3D];

		private _target = missionnamespace getvariable ["BIS_fnc_arsenal_target",player];
		private _cam = uinamespace getvariable ["BIS_fnc_arsenal_cam",objnull];
		_camData = [getPosASLVisual _cam,(getPosASLVisual _cam) vectorfromto (getPosASLVisual _target)];
		_cam cameraeffect ["terminate","back"];
		camdestroy _cam;

		//--- Select correct weapon based on animation
		private _center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		private _selectedWeaponType = uinamespace getvariable ["BIS_fnc_arsenal_selectedWeaponType",-1];
		switch _selectedWeaponType do 
		{
			case 0: {_center selectweapon primaryweapon _center;};
			case 1: {_center selectweapon secondaryweapon _center;};
			case 2: {_center selectweapon handgunweapon _center;};
		};

		//--- Restore 3DEN settings
		if (is3DEN) then {
			private _sphere = missionnamespace getvariable ["BIS_fnc_arsenal_sphere",objnull];
			private _light = missionnamespace getvariable ["BIS_fnc_arsenal_light",objnull];
			deletevehicle _center;
			deletevehicle _sphere;
			deletevehicle _light;

			get3DENCamera cameraeffect ["internal","back"];
			["ShowInterface",true] call bis_fnc_3DENInterface;
			(missionnamespace getvariable ["BIS_fnc_arsenal_visionMode",0]) call bis_fnc_3DENVisionMode;
		};

		//--- Restore original camera view
		player switchcamera BIS_fnc_arsenal_cameraview;

		showhud true;

		// exit
		missionNamespace setvariable [format ["BIS_fnc_arsenal_campos_%1", BIS_fnc_arsenal_type], +BIS_fnc_arsenal_campos];

		BIS_fnc_arsenal_cam = nil;
		BIS_fnc_arsenal_display = nil;
		BIS_fnc_arsenal_type = nil;
		BIS_fnc_arsenal_mouse = nil;
		BIS_fnc_arsenal_buttons = nil;
		BIS_fnc_arsenal_action = nil;
		BIS_fnc_arsenal_campos = nil;
		BIS_fnc_arsenal_selectedWeaponType = nil;
		BIS_fnc_arsenal_cameraview = nil;

		deletevehicle (missionnamespace getvariable ["BIS_fnc_arsenal_target", objnull]);

		missionNameSpace setVariable ["BIS_fnc_arsenal_acctime", acctime];
		missionNameSpace setVariable ["BIS_fnc_arsenal_target", nil];
		missionNameSpace setVariable ["BIS_fnc_arsenal_center", nil];
		missionNameSpace setVariable ["BIS_fnc_arsenal_centerOrig", nil];
		missionNameSpace setVariable ["BIS_fnc_arsenal_cargo", nil];

		setacctime 1;

		if !(isnull curatorcamera) then {
			curatorcamera setPosASL (_camData select 0);
			curatorcamera setvectordir (_camData select 1);
			curatorcamera cameraeffect ["internal","back"];
		};
		
		// sync udentity in MP if full version
		if (_broadcastUpdates) then
		{
			[_center, face _center, speaker _center] call BIS_fnc_setIdentity;
			[_center, _center call _fnc_getUnitInsignia, true] call _fnc_setUnitInsignia;
		};
		
		with missionnamespace do {
			[missionnamespace,"arsenalClosed",[displaynull,uinamespace getvariable ["BIS_fnc_arsenal_toggleSpace",false]]] call bis_fnc_callscriptedeventhandler;
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "ListAdd": 
	{
		private _CFGVEHICLES = configfile >> "CfgVehicles";
		private _CFGWEAPONS = configfile >> "CfgWeapons";
		private _CFGMAGAZINES = configfile >> "CfgMagazines";
		private _CFGGLASSES = configfile >> "CfgGlasses";
		private _CFGVOICE = configfile >> "CfgVoice";
		private _CFGUNITINSIGNIA = configfile >> "CfgUnitInsignia";
		
		private _display = _this select 0;
		private _center = missionnamespace getvariable ["BIS_fnc_arsenal_center",player];
		private _cargo = missionnamespace getvariable ["BIS_fnc_arsenal_cargo",objnull];
		private _lbAdd = -1;
		private _xCfg = configfile;
		private _modList = MODLIST;
		private _fnc_addModIcon = ADDMODICON;
		private _listDefaults = 
		[
			[primaryweapon _center call bis_fnc_baseWeapon], // IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON
			[secondaryweapon _center call bis_fnc_baseWeapon], // IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON
			[handgunweapon _center call bis_fnc_baseWeapon], // IDC_RSCDISPLAYARSENAL_TAB_HANDGUN
			[uniform _center], // IDC_RSCDISPLAYARSENAL_TAB_UNIFORM
			[vest _center], // IDC_RSCDISPLAYARSENAL_TAB_VEST
			[backpack _center], // IDC_RSCDISPLAYARSENAL_TAB_BACKPACK
			[headgear _center], // IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR
			[goggles _center], // IDC_RSCDISPLAYARSENAL_TAB_GOGGLES
			[hmd _center], // IDC_RSCDISPLAYARSENAL_TAB_NVGS
			[binocular _center], // IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS
			[], // IDC_RSCDISPLAYARSENAL_TAB_MAP
			[], // IDC_RSCDISPLAYARSENAL_TAB_GPS
			[], // IDC_RSCDISPLAYARSENAL_TAB_RADIO
			[], // IDC_RSCDISPLAYARSENAL_TAB_COMPASS
			[], // IDC_RSCDISPLAYARSENAL_TAB_WATCH
			[face _center], // IDC_RSCDISPLAYARSENAL_TAB_FACE
			[speaker _center], // IDC_RSCDISPLAYARSENAL_TAB_VOICE
			[_center call _fnc_getUnitInsignia], // IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA

			[], // IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC
			[], // IDC_RSCDISPLAYARSENAL_TAB_ITEMACC
			[], // IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE
			[], // IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD
			[], // IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG
			[], // IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL
			[], // IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW
			[], // IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT
			[] // IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC
		];

		GETVIRTUALCARGO

		{
			if (_fullVersion || { !(_foreachindex in [IDC_RSCDISPLAYARSENAL_TAB_FACE, IDC_RSCDISPLAYARSENAL_TAB_VOICE, IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA]) }) then
			{
				private _ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _foreachindex);
				private _list = +_x;

				//--- Make sure the current items are available
				{
					private _item = _x;
					if (!(_item isEqualTo "") && { _list findIf { _x == _item } < 0 }) then { _list pushBack _item };
				} 
				foreach (_listDefaults select _foreachindex);

				switch _foreachindex do 
				{
					case IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON;
					case IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON;
					case IDC_RSCDISPLAYARSENAL_TAB_HANDGUN: 
					{
						_virtualCargo = _virtualWeaponCargo;
						_virtualAll = _fullVersion || {"%ALL" in _virtualCargo};
						
						{
							if (_virtualAll || {_x in _virtualCargo}) then {
								_xCfg = _CFGWEAPONS >> _x;
								_displayName = gettext (_xCfg >> "displayName");
								_lbAdd = _ctrlList lbadd _displayName;
								_ctrlList lbsetdata [_lbAdd,_x];
								_ctrlList lbsetpicture [_lbAdd,gettext (_xCfg >> "picture")];
								_ctrlList lbsettooltip [_lbAdd,format ["%1\n%2",_displayName,_x]];
								_xCfg call _fnc_addModIcon;
							};
						} 
						foreach _list;
					};
					case IDC_RSCDISPLAYARSENAL_TAB_UNIFORM;
					case IDC_RSCDISPLAYARSENAL_TAB_VEST;
					case IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR;
					case IDC_RSCDISPLAYARSENAL_TAB_NVGS;
					case IDC_RSCDISPLAYARSENAL_TAB_MAP;
					case IDC_RSCDISPLAYARSENAL_TAB_GPS;
					case IDC_RSCDISPLAYARSENAL_TAB_RADIO;
					case IDC_RSCDISPLAYARSENAL_TAB_COMPASS;
					case IDC_RSCDISPLAYARSENAL_TAB_WATCH: {
						_virtualCargo = _virtualItemCargo;
						_virtualAll = _fullVersion || {"%ALL" in _virtualCargo};
						{
							if (_virtualAll || {_x in _virtualCargo}) then {
								_xCfg = _CFGWEAPONS >> _x;
								_displayName = gettext (_xCfg >> "displayName");
								_lbAdd = _ctrlList lbadd _displayName;;
								_ctrlList lbsetdata [_lbAdd,_x];
								_ctrlList lbsetpicture [_lbAdd,gettext (_xCfg >> "picture")];
								_ctrlList lbsettooltip [_lbAdd,format ["%1\n%2",_displayName,_x]];
								_xCfg call _fnc_addModIcon;
							};
						} 
						foreach _list;
					};
					case IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS: {
						_virtualCargo = _virtualWeaponCargo + _virtualItemCargo;
						_virtualAll = _fullVersion || {"%ALL" in _virtualCargo};
						{
							if (_virtualAll || {_x in _virtualCargo}) then {
								_xCfg = _CFGWEAPONS >> _x;
								_displayName = gettext (_xCfg >> "displayName");
								_lbAdd = _ctrlList lbadd _displayName;
								_ctrlList lbsetdata [_lbAdd,_x];
								_ctrlList lbsetpicture [_lbAdd,gettext (_xCfg >> "picture")];
								_ctrlList lbsettooltip [_lbAdd,format ["%1\n%2",_displayName,_x]];
								_xCfg call _fnc_addModIcon;
							};
						} 
						foreach _list;

					};
					case IDC_RSCDISPLAYARSENAL_TAB_GOGGLES: 
					{
						_virtualCargo = _virtualItemCargo;
						_virtualAll = _fullVersion || {"%ALL" in _virtualCargo};
						{
							if (_virtualAll || {_x in _virtualCargo}) then 
							{
								_xCfg = _CFGGLASSES >> _x;
								_displayName = gettext (_xCfg >> "displayName");
								_lbAdd = _ctrlList lbadd _displayName;
								_ctrlList lbsetdata [_lbAdd,_x];
								_ctrlList lbsetpicture [_lbAdd,gettext (_xCfg >> "picture")];
								_ctrlList lbsettooltip [_lbAdd,format ["%1\n%2",_displayName,_x]];
								_xCfg call _fnc_addModIcon;
							};
						} 
						foreach _list;
					};
					case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK: 
					{
						_virtualCargo = _virtualBackpackCargo;
						_virtualAll = _fullVersion || {"%ALL" in _virtualCargo};
						{
							if (_virtualAll || {_x in _virtualCargo}) then 
							{
								_xCfg = _CFGVEHICLES >> _x;
								_displayName = gettext (_xCfg >> "displayName");
								_lbAdd = _ctrlList lbadd _displayName;
								_ctrlList lbsetdata [_lbAdd,_x];
								_ctrlList lbsetpicture [_lbAdd,gettext (_xCfg >> "picture")];
								_ctrlList lbsettooltip [_lbAdd,format ["%1\n%2",_displayName,_x]];
								_xCfg call _fnc_addModIcon;
							};
						} 
						foreach _list;
					};
					
					case IDC_RSCDISPLAYARSENAL_TAB_FACE: 
					{
						{
							_xCfg = _x call _fnc_getFaceConfig;
							_displayName = getText (_xCfg >> "displayName");
							if (_displayName isEqualTo "") then { _displayName = _x };
							_lbAdd = _ctrlList lbadd _displayName;
							_ctrlList lbsetdata [_lbAdd, _x];
							//_ctrlList lbsetpicture [_lbAdd, gettext (_xCfg >> "texture")];
							_ctrlList lbsettooltip [_lbAdd, format ["%1\n%2",_displayName, _x]];
							_xCfg call _fnc_addModIcon;
						} 
						foreach _list;
					};
					
					case IDC_RSCDISPLAYARSENAL_TAB_VOICE: 
					{
						{
							_xCfg = _CFGVOICE >> _x;
							_displayName = getText (_xCfg >> "displayName");
							if (_displayName isEqualTo "") then { _displayName = _x };
							_lbAdd = _ctrlList lbadd _displayName;
							_ctrlList lbsetdata [_lbAdd,_x];
							_ctrlList lbsetpicture [_lbAdd,gettext (_xCfg >> "icon")];
							_ctrlList lbsettooltip [_lbAdd,format ["%1\n%2",_displayName,_x]];
							_xCfg call _fnc_addModIcon;
						} 
						foreach _list;
					};
					
					case IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA: 
					{
						{
							_xCfg = _CFGUNITINSIGNIA >> _x;
							_displayName = getText (_xCfg >> "displayName");
							if (_displayName isEqualTo "") then { _displayName = _x };
							_lbAdd = _ctrlList lbadd _displayName;
							_ctrlList lbsetdata [_lbAdd, _x];
							_ctrlList lbsetpicture [_lbAdd,gettext (_xCfg >> "texture")];
							_ctrlList lbsettooltip [_lbAdd,format ["%1\n%2",_displayName,_x]];
							_xCfg call _fnc_addModIcon;
						} 
						foreach _list;
					};
					
					case IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL;
					case IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW;
					case IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT: {
						_virtualCargo = _virtualMagazineCargo;
						_virtualAll = _fullVersion || {"%ALL" in _virtualCargo};
						_columns = count lnbGetColumnsPosition _ctrlList;
						{
							if (_virtualAll || {_x in _virtualCargo}) then {
								_xCfg = _CFGMAGAZINES >> _x;
								_lbAdd = _ctrlList lnbaddrow ["",gettext (_xCfg >> "displayName"),str 0];
								_ctrlList lnbsetdata [[_lbAdd,0],_x];
								_ctrlList lnbsetpicture [[_lbAdd,0],gettext (_xCfg >> "picture")];
								_ctrlList lnbsetvalue [[_lbAdd,0],getnumber (_xCfg >> "mass")];
								_ctrlList lbsettooltip [_lbAdd * _columns,format ["%1\n%2",gettext (_xCfg >> "displayName"),_x]];
							};
						} foreach _list;
					};
					case IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC: {
						_virtualCargo = _virtualItemCargo;
						_virtualAll = _fullVersion || {"%ALL" in _virtualCargo};
						_columns = count lnbGetColumnsPosition _ctrlList;
						{
							if (_virtualAll || {_x in _virtualCargo}) then {
								_xCfg = _CFGWEAPONS >> _x;
								_lbAdd = _ctrlList lnbaddrow ["",gettext (_xCfg >> "displayName"),str 0];
								_ctrlList lnbsetdata [[_lbAdd,0],_x];
								_ctrlList lnbsetpicture [[_lbAdd,0],gettext (_xCfg >> "picture")];
								_ctrlList lnbsetvalue [[_lbAdd,0],getnumber (_xCfg >> "itemInfo" >> "mass")];
								_ctrlList lbsettooltip [_lbAdd * _columns,format ["%1\n%2",gettext (_xCfg >> "displayName"),_x]];
							};
						} 
						foreach _list;
					};
				};

				//--- Add <Empty> item
				if !(
					_foreachindex in [
						IDC_RSCDISPLAYARSENAL_TAB_FACE,
						IDC_RSCDISPLAYARSENAL_TAB_VOICE,
						IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,
						IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,
						IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,
						IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,
						IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC
					]
				) then {
					_lbAdd = _ctrlList lbadd format [" <%1>",localize "str_empty"];
					_ctrlList lbsetvalue [_lbAdd,-1];
				};

				if (ctrltype _ctrlList == 102) then {
					_ctrlList lnbsort [1,false];
				} else {
					//lbsort _ctrlList;
					_ctrlSort = _display displayctrl (IDC_RSCDISPLAYARSENAL_SORT + _foreachindex);
					_sortValues = uinamespace getvariable ["bis_fnc_arsenal_sort",[]];
					["lbSort",[[_ctrlSort,_sortValues param [_foreachindex,0]],_foreachindex]] call SELF_FUNC;
				};
			};
		} 
		foreach (missionnamespace getvariable ["bis_fnc_arsenal_data", []]);
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "ListSelectCurrent": 
	{
		private _display = param [0, uinamespace getvariable ["bis_fnc_arsenal_display", displaynull], [displaynull]];
		private _defaultItems = uinamespace getvariable ["bis_fnc_arsenal_defaultItems", []];
		private _defaultShow = uinamespace getvariable ["bis_fnc_arsenal_defaultShow", -1];
		
		{
			private _ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _foreachindex);
			//--- Sort alphabetically
			//if (ctrltype _ctrlList == 5) then {lbsort _ctrlList;};

			//--- Select current
			private _center = missionnamespace getvariable ["BIS_fnc_arsenal_center", player];
			private _select = true;

			//--- Check if some item was marked for selection manually
			private _defaultItem = _defaultItems param [_foreachindex,[],["",[]]];
			if !(_defaultItem isEqualType []) then { _defaultItem = [_defaultItem] };
			
			private _current = if (count _defaultItem == 0) then 
			{
				switch _foreachindex do 
				{
					case IDC_RSCDISPLAYARSENAL_TAB_UNIFORM:		{uniform _center};
					case IDC_RSCDISPLAYARSENAL_TAB_VEST:		{vest _center};
					case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK:	{backpack _center};
					case IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR:	{headgear _center};
					case IDC_RSCDISPLAYARSENAL_TAB_GOGGLES:		{goggles _center};
					case IDC_RSCDISPLAYARSENAL_TAB_NVGS:		{hmd _center};
					case IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS:	{binocular _center};
					case IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON:	{primaryweapon _center call bis_fnc_baseWeapon param [0,""] };
					case IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON:	{secondaryweapon _center call bis_fnc_baseWeapon param [0,""] };
					case IDC_RSCDISPLAYARSENAL_TAB_HANDGUN:		{handgunweapon _center call bis_fnc_baseWeapon param [0,""] };
					case IDC_RSCDISPLAYARSENAL_TAB_MAP;
					case IDC_RSCDISPLAYARSENAL_TAB_GPS;
					case IDC_RSCDISPLAYARSENAL_TAB_RADIO;
					case IDC_RSCDISPLAYARSENAL_TAB_COMPASS;
					case IDC_RSCDISPLAYARSENAL_TAB_WATCH:		{assigneditems _center};
					case IDC_RSCDISPLAYARSENAL_TAB_FACE:		{ face _center };
					case IDC_RSCDISPLAYARSENAL_TAB_VOICE:		{ speaker _center };
					case IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA:	{ _center call _fnc_getUnitInsignia };
					default {_select = false; ""};
				};
			} 
			else 
			{
				if (_defaultShow < 0) then { ["ShowItem", [_display, _ctrlList, _foreachindex]] spawn SELF_FUNC };
				_defaultItem select 0 param [0,"",[""]]
			};
			
			if (_select) then 
			{
				if !(_current isEqualtype []) then { _current = [_current] };
				
				private _selectIndex = -1;
				for "_l" from 0 to (lbsize _ctrlList - 1) do 
				{
					if (_current findIf { _ctrlList lbdata _l == _x } > -1) exitwith { _selectIndex = _l };
				};

				if (_selectIndex > -1) exitWith { _ctrlList lbsetcursel _selectIndex };
				
				if (_foreachindex != IDC_RSCDISPLAYARSENAL_TAB_FACE && _foreachindex != IDC_RSCDISPLAYARSENAL_TAB_VOICE && _current isEqualTo [""]) exitWith { _ctrlList lbsetcursel 0 };
				
				// select nothing
				_ctrlList lbsetcursel -1;
			};

			//--- Add default items (must be done here, because the weapon UI where it would make sense is hidden)
			if (count _defaultItem > 0) then 
			{
				switch _foreachindex do 
				{
					case IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON: { { if (_foreachindex > 0) then { _center addprimaryweaponitem _x } } foreach _defaultItem };
					case IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON: { { if (_foreachindex > 0) then { _center addsecondaryweaponitem _x } } foreach _defaultItem };
					case IDC_RSCDISPLAYARSENAL_TAB_HANDGUN: { { if (_foreachindex > 0) then { _center addhandgunitem _x } } foreach _defaultItem };
				};
			};
		} 
		foreach (missionnamespace getvariable ["bis_fnc_arsenal_data", []]);
		
		if (_defaultShow >= 0) then {["ShowItem", [_display,_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _defaultShow),_defaultShow]] spawn SELF_FUNC;};
		uinamespace setvariable ["bis_fnc_arsenal_defaultItems",nil];
		uinamespace setvariable ["bis_fnc_arsenal_defaultShow",nil];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "TabDeselect": {
		_display = _this select 0;
		_key = _this select 1;

		//--- Deselect
		if ({count _x > 0} count BIS_fnc_arsenal_buttons == 0) then {

			//--- When interface is hidden, reveal it
			_shown = ctrlshown (_display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_CONTROLBAR);
			if (!_shown || _key == 1) exitwith {['buttonInterface',[_display]] call SELF_FUNC;};

			{
				_idc = _x;
				{
					_ctrlList = _display displayctrl (_x + _idc);
					_ctrlLIst ctrlenable false;
					_ctrlList ctrlsetfade 1;
					_ctrlList ctrlcommit FADE_DELAY;
				} foreach [IDC_RSCDISPLAYARSENAL_LIST,IDC_RSCDISPLAYARSENAL_LISTDISABLED,IDC_RSCDISPLAYARSENAL_SORT];

				_ctrlIcon = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICON + _idc);
				_ctrlTab = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
				{
					_x ctrlenable true;
					_x ctrlsetfade 0;
				} foreach [/*_ctrlIcon,*/_ctrlTab];
				_ctrlIcon ctrlenable true;
				_ctrlIcon ctrlshow true;

				_ctrlIconBackground = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICONBACKGROUND + _idc);
				_ctrlIconBackground ctrlshow true;

				if (_idc in [IDCS_RIGHT]) then {
					_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc);
					_ctrlSort = _display displayctrl (IDC_RSCDISPLAYARSENAL_SORT + _idc);
					{
						_x ctrlenable false;
						_x ctrlsetfade 1;
						_x ctrlcommit FADE_DELAY;
					} foreach [_ctrlList,_ctrlTab,_ctrlSort];
				};
			} foreach IDCS;

			_idcs = [
				IDC_RSCDISPLAYARSENAL_FRAMELEFT,
				IDC_RSCDISPLAYARSENAL_FRAMERIGHT,
				IDC_RSCDISPLAYARSENAL_BACKGROUNDLEFT,
				IDC_RSCDISPLAYARSENAL_BACKGROUNDRIGHT,
				IDC_RSCDISPLAYARSENAL_LINEICON,
				IDC_RSCDISPLAYARSENAL_LINETABLEFT,
				IDC_RSCDISPLAYARSENAL_LINETABRIGHT,
				IDC_RSCDISPLAYARSENAL_LOADCARGO
			];

			if (BIS_fnc_arsenal_type == 0 || (BIS_fnc_arsenal_type == 1 && !is3DEN)) then {
				_idcs append [
					IDC_RSCDISPLAYARSENAL_INFO_INFO,
					IDC_RSCDISPLAYARSENAL_STATS_STATS
				];
			};
			{
				_ctrl = _display displayctrl _x;
				_ctrl ctrlsetfade 1;
				_ctrl ctrlcommit 0;
			} foreach _idcs
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "TabSelectLeft": {
		_display = _this select 0;
		_index = _this select 1;

		{
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
			_ctrlList lbsetcursel -1;
			lbclear _ctrlList;
		} foreach [
			IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,
			IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,
			IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,
			IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD
			//IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG
		];

		{
			_idc = _x;
			_active = _idc == _index;

			{
				_ctrlList = _display displayctrl (_x + _idc);
				_ctrlList ctrlenable _active;
				_ctrlList ctrlsetfade ([1,0] select _active);
				_ctrlList ctrlcommit FADE_DELAY;
			} foreach [IDC_RSCDISPLAYARSENAL_LIST,IDC_RSCDISPLAYARSENAL_LISTDISABLED,IDC_RSCDISPLAYARSENAL_SORT];

			_ctrlTab = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
			_ctrlTab ctrlenable !_active;

			if (_active) then {
				_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc);
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
				['SelectItem',[_display,_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc),_idc]] call SELF_FUNC;
			};

			_ctrlIcon = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICON + _idc);
			//_ctrlIcon ctrlsetfade ([1,0] select _active);
			_ctrlIcon ctrlshow _active;
			_ctrlIcon ctrlenable !_active;

			_ctrlIconBackground = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICONBACKGROUND + _idc);
			_ctrlIconBackground ctrlshow _active;
		} foreach [IDCS_LEFT];

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsetfade 0;
			_ctrl ctrlcommit FADE_DELAY;
		} foreach [
			IDC_RSCDISPLAYARSENAL_LINETABLEFT,
			IDC_RSCDISPLAYARSENAL_FRAMELEFT,
			IDC_RSCDISPLAYARSENAL_BACKGROUNDLEFT
		];

		//--- Weapon attachments
		_showItems = _index in [IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON,IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON,IDC_RSCDISPLAYARSENAL_TAB_HANDGUN];
		_fadeItems = [1,0] select _showItems;
		{
			_idc = _x;
			_ctrl = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
			_ctrl ctrlenable _showItems;
			_ctrl ctrlsetfade _fadeItems;
			_ctrl ctrlcommit 0;//FADE_DELAY;
			{
				_ctrl = _display displayctrl (_x + _idc);
				_ctrl ctrlenable _showItems;
				_ctrl ctrlsetfade _fadeItems;
				_ctrl ctrlcommit FADE_DELAY;
			} foreach [IDC_RSCDISPLAYARSENAL_LIST,IDC_RSCDISPLAYARSENAL_LISTDISABLED,IDC_RSCDISPLAYARSENAL_SORT];
		} foreach [
			IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,
			IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,
			IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,
			IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD
		];
		if (_showItems) then {['TabSelectRight',[_display,IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC]] call SELF_FUNC;};

		//--- Containers
		_showCargo = _index in [IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,IDC_RSCDISPLAYARSENAL_TAB_VEST,IDC_RSCDISPLAYARSENAL_TAB_BACKPACK];
		_fadeCargo = [1,0] select _showCargo;
		{
			_idc = _x;
			_ctrl = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _idc);
			_ctrl ctrlenable _showCargo;
			_ctrl ctrlsetfade _fadeCargo;
			_ctrl ctrlcommit 0;//FADE_DELAY;
			{
				_ctrlList = _display displayctrl (_x + _idc);
				_ctrlList ctrlenable _showCargo;
				_ctrlList ctrlsetfade _fadeCargo;
				_ctrlList ctrlcommit FADE_DELAY;
			} foreach [IDC_RSCDISPLAYARSENAL_LIST,IDC_RSCDISPLAYARSENAL_LISTDISABLED];
		} foreach [
			IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,
			IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,
			IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,
			IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,
			IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC
		];
		_ctrl = _display displayctrl IDC_RSCDISPLAYARSENAL_LOADCARGO;
		_ctrl ctrlsetfade _fadeCargo;
		_ctrl ctrlcommit FADE_DELAY;
		if (_showCargo) then {['TabSelectRight',[_display,IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG]] call SELF_FUNC;};

		//--- Right sidebar
		_showRight = _showItems || _showCargo;
		_fadeRight = [1,0] select _showRight;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsetfade _fadeRight;
			_ctrl ctrlcommit FADE_DELAY;
		} foreach [
			IDC_RSCDISPLAYARSENAL_LINETABRIGHT,
			IDC_RSCDISPLAYARSENAL_FRAMERIGHT,
			IDC_RSCDISPLAYARSENAL_BACKGROUNDRIGHT
		];

		//--- Refresh weapon accessory lists
		//['SelectItem',[_display,_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _index),_index]] call SELF_FUNC;
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
			} foreach [IDC_RSCDISPLAYARSENAL_LIST,IDC_RSCDISPLAYARSENAL_LISTDISABLED,IDC_RSCDISPLAYARSENAL_SORT];

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

				if (
					_idc in [
						IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,
						IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,
						IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,
						IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,
						IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC
					]
				) then {
					//--- Update counts for all items in the list
					_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
					_itemsCurrent = switch true do {
						case (ctrlenabled (_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_UNIFORM))): {uniformitems _center};
						case (ctrlenabled (_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_VEST))): {vestitems _center};
						case (ctrlenabled (_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_BACKPACK))): {backpackitems _center};
						default {[]};
					};
					for "_l" from 0 to (lbsize _ctrlList - 1) do {
						_class = _ctrlList lnbdata [_l,0];
						_ctrlList lnbsettext [[_l,2],str ({_x == _class} count _itemsCurrent)];
					};
					["SelectItemRight",[_display,_ctrlList,_index]] call SELF_FUNC;
				};
			};

			_ctrlIcon = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICON + _idc);
			//_ctrlIcon ctrlenable false;
			_ctrlIcon ctrlshow _active;
			_ctrlIcon ctrlenable (!_active && ctrlfade _ctrlTab == 0);

			_ctrlIconBackground = _display displayctrl (IDC_RSCDISPLAYARSENAL_ICONBACKGROUND + _idc);
			_ctrlIconBackground ctrlshow _active;
		} foreach [IDCS_RIGHT];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "SelectItem": 
	{
		private ["_ctrlList","_index","_cursel"];
		_display = _this select 0;
		_ctrlList = _this select 1;
		_index = _this select 2;
		_cursel = lbcursel _ctrlList;
		if (_cursel < 0) exitwith {};
		_item = if (ctrltype _ctrlList == 102) then {_ctrlList lnbdata [_cursel,0]} else {_ctrlList lbdata _cursel};
		private _center = missionnamespace getvariable ["BIS_fnc_arsenal_center",player];

		_ctrlListPrimaryWeapon = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON);
		_ctrlListSecondaryWeapon = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON);
		_ctrlListHandgun = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_HANDGUN);
		
		private _fnc_addWeapon = 
		{
			params ["_unit", "_weapon", "_mags"];
			
			private _weaponCfg = configFile >> "CfgWeapons" >> _weapon;
			if (!isClass _weaponCfg) exitWith { };
			
			_unit addWeapon _weapon;
			private _magazineCfg = configFile >> "CfgMagazines";
			
			{				
				private _magazines = getArray (if (_x == "this") then { _weaponCfg >> "magazines" } else { _weaponCfg >> _x >> "magazines" }) select { getNumber (_magazineCfg >> _x >> "scope") == 2 };
				if (count _magazines > 0) then 
				{
					private _magazine = _magazines select 0;
					_unit addWeaponItem [_weapon, _magazine, true];
					_unit addMagazines [_magazine, _mags];
				};
			}
			forEach getArray (_weaponCfg >> "muzzles");
		};
		
		private _fnc_removeWeapon = 
		{
			params ["_unit", "_weapon"];
			
			private _weaponCfg = configFile >> "CfgWeapons" >> _weapon;
			if (!isClass _weaponCfg) exitWith { };
			
			_unit removeWeapon _weapon;
			private _magazineCfg = configFile >> "CfgMagazines";
			
			{				
				private _magazines = getArray (if (_x == "this") then { _weaponCfg >> "magazines" } else { _weaponCfg >> _x >> "magazines" }) select { getNumber (_magazineCfg >> _x >> "scope") == 2 };
				if (count _magazines > 0) then 
				{
					_unit removeMagazines (_magazines select 0);
				};
			}
			forEach getArray (_weaponCfg >> "muzzles");
		};
		
		switch _index do 
		{
			case IDC_RSCDISPLAYARSENAL_TAB_UNIFORM: 
			{
				if (_item == "") then {
					removeuniform _center;
				} else {
					_items = uniformitems _center;
					_center forceadduniform _item;
					while {count uniformitems _center > 0} do {_center removeitemfromuniform (uniformitems _center select 0);}; //--- Remove default config contents
					{_center additemtouniform _x;} foreach _items;
				};

				//--- Refresh insignia (gets removed when uniform changes)
				//["SelectItem",[_display, _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA),IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA]] spawn SELF_FUNC;
				[_center, _center call _fnc_getUnitInsignia, false] call _fnc_setUnitInsignia;
				
			};
			case IDC_RSCDISPLAYARSENAL_TAB_VEST: 
			{
				if (_item == "") then {
					removevest _center;
				} else {
					_items = vestitems _center;
					_center addvest _item;
					while {count vestitems _center > 0} do {_center removeitemfromvest (vestitems _center select 0);}; //--- Remove default config contents
					{_center additemtovest _x;} foreach _items;
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK: {
				_items = backpackitems _center;
				removebackpack _center;
				if !(_item == "") then {
					_center addbackpack _item;
					while {count backpackitems _center > 0} do {_center removeitemfrombackpack (backpackitems _center select 0);}; //--- Remove default config contents
					{_center additemtobackpack _x;} foreach _items;
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR: {
				if (_item == "") then {removeheadgear _center;} else {_center addheadgear _item;};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_GOGGLES: {
				if (_item == "") then {removegoggles _center} else {_center addgoggles _item;};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_NVGS:
			{
				if (_item == "") then 
				{
					private _weapons = [];
					for "_l" from 0 to (lbsize _ctrlList) do {_weapons set [count _weapons,tolower (_ctrlList lbdata _l)];};
					{
						if (tolower _x in _weapons) then {_center removeweapon _x;};
					} 
					foreach (assigneditems _center);
				} 
				else
				{
					_center addweapon _item; 
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS: 
			{
				if (_item == "") then 
				{
					private _weapons = [];
					for "_l" from 0 to (lbsize _ctrlList) do {_weapons set [count _weapons,tolower (_ctrlList lbdata _l)];};
					{
						if (tolower _x in _weapons) then {_center removeweapon _x;};
					} 
					foreach (assigneditems _center);
				} 
				else 
				{
					[_center, _item] call _fnc_addBinoculars;
				};
			};
			
			case IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON: 
			{
				private _weapon = primaryWeapon _center;
				
				if (_weapon call BIS_fnc_baseWeapon != _item) then 
				{
					if (_item == "") exitWith { [_center, _weapon] call _fnc_removeWeapon };
					
					private _oldWeaponItems = primaryWeaponItems _center apply {toLower _x};
					private _newWeaponItems = _item call BIS_fnc_compatibleItems apply {toLower _x};
					
					[_center, _weapon] call _fnc_removeWeapon;
					[_center, _item, 3] call _fnc_addWeapon;
					
					{_center addPrimaryWeaponItem _x} forEach (_oldWeaponItems arrayIntersect _newWeaponItems);
				};
			};
			
			case IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON: 
			{
				private _weapon = secondaryWeapon _center;
				
				if (_weapon call BIS_fnc_baseWeapon != _item) then 
				{
					if (_item == "") exitWith { [_center, _weapon] call _fnc_removeWeapon };
					
					private _oldWeaponItems = secondaryWeaponItems _center apply {toLower _x};
					private _newWeaponItems = _item call BIS_fnc_compatibleItems apply {toLower _x};
					
					[_center, _weapon] call _fnc_removeWeapon;
					[_center, _item, 3] call _fnc_addWeapon;
					
					{_center addSecondaryWeaponItem _x} forEach (_oldWeaponItems arrayIntersect _newWeaponItems);
				};
			};
			
			case IDC_RSCDISPLAYARSENAL_TAB_HANDGUN: 
			{	
				private _weapon = handgunWeapon _center;
				
				if (_weapon call BIS_fnc_baseWeapon != _item) then 
				{
					if (_item == "") exitWith { [_center, _weapon] call _fnc_removeWeapon };
					
					private _oldWeaponItems = handgunItems _center apply {toLower _x};
					private _newWeaponItems = _item call BIS_fnc_compatibleItems apply {toLower _x};
					
					[_center, _weapon] call _fnc_removeWeapon;
					[_center, _item, 3] call _fnc_addWeapon;
					
					{_center addHandgunItem _x} forEach (_oldWeaponItems arrayIntersect _newWeaponItems);
				};
			};
			
			case IDC_RSCDISPLAYARSENAL_TAB_MAP;
			case IDC_RSCDISPLAYARSENAL_TAB_GPS;
			case IDC_RSCDISPLAYARSENAL_TAB_RADIO;
			case IDC_RSCDISPLAYARSENAL_TAB_COMPASS;
			case IDC_RSCDISPLAYARSENAL_TAB_WATCH: {
				if (_item == "") then {
					_items = [];
					for "_l" from 0 to (lbsize _ctrlList) do {_items set [count _items,tolower (_ctrlList lbdata _l)];};
					{
						if (tolower _x in _items) then {_center unassignitem _x; _center removeitem _x;};
					} foreach (assigneditems _center);
				} else {
					_center linkitem _item;
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_FACE:
			{
				if !(_item isEqualTo "") then { _center setFace _item };
			};
			case IDC_RSCDISPLAYARSENAL_TAB_VOICE: 
			{
				if !(_item isEqualTo "") then { _center setSpeaker _item };
				if (ctrlenabled (_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_VOICE))) then {
					if !(isnil "BIS_fnc_arsenal_voicePreview") then {terminate BIS_fnc_arsenal_voicePreview;};
					BIS_fnc_arsenal_voicePreview = [] spawn {
						scriptname "BIS_fnc_arsenal_voicePreview";
						sleep 0.6;
						_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
						_center directsay "CuratorObjectPlaced";
					};
				};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA: 
			{
				[_center, _item, false] call _fnc_setUnitInsignia;
			};
			case IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC;
			case IDC_RSCDISPLAYARSENAL_TAB_ITEMACC;
			case IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE;
			case IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD: {
				_accIndex = [
					IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,
					IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,
					IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,
					IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD
				] find _index;
				switch true do {
					case (ctrlenabled _ctrlListPrimaryWeapon): {
						if (_item != "") then {
							_center addprimaryweaponitem _item;
						} else {
							_weaponAccessories = _center weaponaccessories primaryweapon _center;
							if (count _weaponAccessories > 0) then {_center removeprimaryweaponitem (_weaponAccessories select _accIndex);};
						};
					};
					case (ctrlenabled _ctrlListSecondaryWeapon): {
						if (_item != "") then {
							_center addsecondaryweaponitem _item;
						} else {
							_weaponAccessories = _center weaponaccessories secondaryweapon _center;
							if (count _weaponAccessories > 0) then {_center removesecondaryweaponitem (_weaponAccessories select _accIndex);};
						};
					};
					case (ctrlenabled _ctrlListHandgun): {
						if (_item != "") then {
							_center addhandgunitem _item;
						} else {
							_weaponAccessories = _center weaponaccessories handgunweapon _center;
							if (count _weaponAccessories > 0) then {_center removehandgunitem (_weaponAccessories select _accIndex);};
						};
					};
				};
			};
		};

		//--- Container Cargo
		if (
			_index in [IDC_RSCDISPLAYARSENAL_TAB_UNIFORM,IDC_RSCDISPLAYARSENAL_TAB_VEST,IDC_RSCDISPLAYARSENAL_TAB_BACKPACK]
			&&
			ctrlenabled (_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _index))
		) then {
			_cargo = (missionnamespace getvariable ["BIS_fnc_arsenal_cargo",objnull]);
			GETVIRTUALCARGO

			_itemsCurrent = [];
			_load = 0;
			switch _index do {
				case IDC_RSCDISPLAYARSENAL_TAB_UNIFORM: {
					_itemsCurrent = uniformitems _center;
					_load = if (uniform _center == "") then {1} else {loaduniform _center};
				};
				case IDC_RSCDISPLAYARSENAL_TAB_VEST: {
					_itemsCurrent = vestitems _center;
					_load = if (vest _center == "") then {1} else {loadvest _center};
				};
				case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK: {
					_itemsCurrent = backpackitems _center;
					_load = if (backpack _center == "") then {1} else {loadbackpack _center};
				};
				default {[]};
			};

			_ctrlLoadCargo = _display displayctrl IDC_RSCDISPLAYARSENAL_LOADCARGO;
			_ctrlLoadCargo progresssetposition _load;

			//--- Weapon magazines (based on current weapons)
			private ["_ctrlList"];
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG);
			_columns = count lnbGetColumnsPosition _ctrlList;
			lbclear _ctrlList;
			_magazines = [];
			{
				_cfgWeapon = configfile >> "cfgweapons" >> _x;
				{
					_cfgMuzzle = if (_x == "this") then {_cfgWeapon} else {_cfgWeapon >> _x};
					{
						private _item = _x;
						if (CONDITION(_virtualMagazineCargo)) then {
							_mag = tolower _item;
							_cfgMag = configfile >> "cfgmagazines" >> _mag;
							if (!(_mag in _magazines) && {getnumber (_cfgMag >> "scope") == 2 || getnumber (_cfgMag >> "scopeArsenal") == 2}) then {
								_magazines set [count _magazines,_mag];
								_value = {_x == _mag} count _itemsCurrent;
								_displayName = gettext (_cfgMag >> "displayName");
								_lbAdd = _ctrlList lnbaddrow ["",_displayName,str _value];
								_ctrlList lnbsetdata [[_lbAdd,0],_mag];
								_ctrlList lnbsetvalue [[_lbAdd,0],getnumber (_cfgMag >> "mass")];
								_ctrlList lnbsetpicture [[_lbAdd,0],gettext (_cfgMag >> "picture")];
								_ctrlList lbsettooltip [_lbAdd * _columns,format ["%1\n%2",_displayName,_item]];
							};
						};
					} foreach getarray (_cfgMuzzle >> "magazines");
					// Magazine wells
					{
						// Find all entries inside magazine well
						{
							// Add all magazines from magazineWell sub class
							{
								private _item = _x;
								if (CONDITION(_virtualMagazineCargo)) then {
									_mag = tolower _item;
									_cfgMag = configfile >> "cfgmagazines" >> _mag;
									if (!(_mag in _magazines) && {getnumber (_cfgMag >> "scope") == 2 || getnumber (_cfgMag >> "scopeArsenal") == 2}) then {
										_magazines set [count _magazines,_mag];
										_value = {_x == _mag} count _itemsCurrent;
										_displayName = gettext (_cfgMag >> "displayName");
										_lbAdd = _ctrlList lnbaddrow ["",_displayName,str _value];
										_ctrlList lnbsetdata [[_lbAdd,0],_mag];
										_ctrlList lnbsetvalue [[_lbAdd,0],getnumber (_cfgMag >> "mass")];
										_ctrlList lnbsetpicture [[_lbAdd,0],gettext (_cfgMag >> "picture")];
										_ctrlList lbsettooltip [_lbAdd * _columns,format ["%1\n%2",_displayName,_item]];
									};
								};
							}foreach (getArray _x);
						}foreach (configProperties [configFile >> "CfgMagazineWells" >> _x,"isarray _x"]);
					} foreach getarray (_cfgMuzzle >> "magazineWell");

				} foreach getarray (_cfgWeapon >> "muzzles");
			} foreach (weapons _center - ["Throw","Put"]);
			_ctrlList lbsetcursel (lbcursel _ctrlList max 0);

			//--- Update counts for all items in the list
			{
				_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
				if (ctrlenabled _ctrlList) then {
					for "_l" from 0 to (lbsize _ctrlList - 1) do {
						_class = _ctrlList lnbdata [_l,0];
						_ctrlList lnbsettext [[_l,2],str ({_x == _class} count _itemsCurrent)];
					};
					["SelectItemRight",[_display,_ctrlList,_index]] call SELF_FUNC;
				};
			} foreach [
				IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG,
				IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL,
				IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW,
				IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT,
				IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC
			];
		};

		//--- Weapon attachments
		_modList = MODLIST;
		if (
			_index in [IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON,IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON,IDC_RSCDISPLAYARSENAL_TAB_HANDGUN]
			&&
			ctrlenabled (_display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _index))
		) then {
			private ["_ctrlList"];

			_cargo = (missionnamespace getvariable ["BIS_fnc_arsenal_cargo",objnull]);
			GETVIRTUALCARGO

			{
				_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
				lbclear _ctrlList;
				_ctrlList lbsetcursel -1;
			} foreach [
				IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,
				IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,
				IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,
				IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD
			];

			//--- Attachments
			_compatibleItems = _item call bis_fnc_compatibleItems;
			{
				private ["_item"];
				_item = _x;
				_itemCfg = configfile >> "cfgweapons" >> _item;
				_scope = if (isnumber (_itemCfg >> "scopeArsenal")) then {getnumber (_itemCfg >> "scopeArsenal")} else {getnumber (_itemCfg >> "scope")};
				if (_scope == 2 && CONDITION(_virtualItemCargo)) then {
					_type = _item call bis_fnc_itemType;
					_idcList = switch (_type select 1) do {
						case "AccessoryMuzzle": {IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE};
						case "AccessoryPointer": {IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_ITEMACC};
						case "AccessorySights": {IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC};
						case "AccessoryBipod": {IDC_RSCDISPLAYARSENAL_LIST + IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD};
						default {-1};
					};
					_ctrlList = _display displayctrl _idcList;
					_lbAdd = _ctrlList lbadd gettext (_itemCfg >> "displayName");
					_ctrlList lbsetdata [_lbAdd,_item];
					_ctrlList lbsetpicture [_lbAdd,gettext (_itemCfg >> "picture")];
					_ctrlList lbsettooltip [_lbAdd,format ["%1\n%2",gettext (_itemCfg >> "displayName"),_item]];
					_itemCfg call ADDMODICON;
				};
			} foreach _compatibleItems;

			//--- Magazines
			_weapon = switch true do {
				case (ctrlenabled _ctrlListPrimaryWeapon): {primaryweapon _center};
				case (ctrlenabled _ctrlListSecondaryWeapon): {secondaryweapon _center};
				case (ctrlenabled _ctrlListHandgun): {handgunweapon _center};
				default {""};
			};

			//--- Select current
			_weaponAccessories = _center weaponaccessories _weapon;
			{
				_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
				_lbAdd = _ctrlList lbadd format ["<%1>",localize "str_empty"];
				_ctrlList lbsetvalue [_lbAdd,-1];
				lbsort _ctrlList;
				for "_l" from 0 to (lbsize _ctrlList - 1) do {
					_data = _ctrlList lbdata _l;
					if (_data != "" && {{_data == _x} count _weaponAccessories > 0}) exitwith {_ctrlList lbsetcursel _l;};
				};
				if (lbcursel _ctrlList < 0) then {_ctrlList lbsetcursel 0;};

				_ctrlSort = _display displayctrl (IDC_RSCDISPLAYARSENAL_SORT + _x);
				["lbSort",[[_ctrlSort,lbcursel _ctrlSort],_x]] call SELF_FUNC;
			} foreach [
				IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE,
				IDC_RSCDISPLAYARSENAL_TAB_ITEMACC,
				IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC,
				IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD
			];
		};

		//--- Calculate load
		_ctrlLoad = _display displayctrl IDC_RSCDISPLAYARSENAL_LOAD;
		_ctrlLoad progresssetposition load _center;


		if (ctrlenabled _ctrlList) then 
		{
			_itemCfg = switch _index do 
			{
				case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK:	{configfile >> "cfgvehicles" >> _item};
				case IDC_RSCDISPLAYARSENAL_TAB_GOGGLES:		{configfile >> "cfgglasses" >> _item};
				case IDC_RSCDISPLAYARSENAL_TAB_FACE:		{ _item call _fnc_getFaceConfig };
				case IDC_RSCDISPLAYARSENAL_TAB_VOICE:		{configfile >> "cfgvoice" >> _item};
				case IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA:	{configfile >> "cfgunitinsignia" >> _item};
				case IDC_RSCDISPLAYARSENAL_TAB_CARGOMAG;
				case IDC_RSCDISPLAYARSENAL_TAB_CARGOMAGALL;
				case IDC_RSCDISPLAYARSENAL_TAB_CARGOTHROW;
				case IDC_RSCDISPLAYARSENAL_TAB_CARGOPUT;
				case IDC_RSCDISPLAYARSENAL_TAB_CARGOMISC:	{configfile >> "cfgmagazines" >> _item};
				default						{configfile >> "cfgweapons" >> _item};
			};
			
			if (BIS_fnc_arsenal_type == 0 || (BIS_fnc_arsenal_type == 1 && !is3DEN)) then 
			{
				["ShowItemInfo",[_itemCfg]] call SELF_FUNC;
				["ShowItemStats",[_itemCfg]] call SELF_FUNC;
			};
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "SelectItemRight": {
		_display = _this select 0;
		_ctrlList = _this select 1;
		_index = _this select 2;
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);

		//--- Get container
		_indexLeft = -1;
		{
			_ctrlListLeft = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _foreachindex);
			if (ctrlenabled _ctrlListLeft) exitwith {_indexLeft = _foreachindex;};
		} foreach [IDCS_LEFT];

		_supply = switch _indexLeft do {
			case IDC_RSCDISPLAYARSENAL_TAB_UNIFORM: {
				gettext (configfile >> "CfgWeapons" >> uniform _center >> "ItemInfo" >> "containerClass")
			};
			case IDC_RSCDISPLAYARSENAL_TAB_VEST: {
				gettext (configfile >> "CfgWeapons" >> vest _center >> "ItemInfo" >> "containerClass")
			};
			case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK: {
				backpack _center
			};
			default {0};
		};
		_maximumLoad = getnumber (configfile >> "CfgVehicles" >> _supply >> "maximumLoad");

		_ctrlLoadCargo = _display displayctrl IDC_RSCDISPLAYARSENAL_LOADCARGO;
		_load = _maximumLoad * (1 - progressposition _ctrlLoadCargo);

		//-- Disable too heavy items
		_rows = lnbsize _ctrlList select 0;
		//_columns = lnbsize _ctrlList select 1;
		_colorWarning = ["IGUI","WARNING_RGB"] call bis_fnc_displayColorGet;
		//_columns = count lnbGetColumnsPosition _ctrlList;
		for "_r" from 0 to (_rows - 1) do {
			_isIncompatible = _ctrlList lnbvalue [_r,1];
			//_mass = _ctrlList lbvalue (_r * _columns);
			_mass = _ctrlList lnbvalue [_r, 0];
			_alpha = [1.0,0.25] select (_mass > _load);
			_color = [[1,1,1,_alpha],[1,0.5,0,_alpha]] select _isIncompatible;
			_ctrlList lnbsetcolor [[_r,1],_color];
			_ctrlList lnbsetcolor [[_r,2],_color];
			_text = _ctrlList lnbtext [_r,1];
			//_ctrlList lbsettooltip [_r * _columns,[_text,_text + "\n(Not compatible with currently equipped weapons)"] select _isIncompatible];
			_ctrlList lnbsettooltip [[_r, 0],[_text,_text + "\n(Not compatible with currently equipped weapons)"] select _isIncompatible];
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "ShowItemInfo": {
		_itemCfg = _this select 0;
		if (isclass _itemCfg) then {
			_itemName = param [1,if (ctrltype _ctrlList == 102) then {_ctrlList lnbtext [_cursel,1]} else {_ctrlList lbtext _cursel}];

			_ctrlInfo = _display displayctrl IDC_RSCDISPLAYARSENAL_INFO_INFO;
			_ctrlInfo ctrlsetfade 0;
			_ctrlInfo ctrlcommit FADE_DELAY;

			_ctrlInfoName = _display displayctrl IDC_RSCDISPLAYARSENAL_INFO_INFONAME;
			_ctrlInfoName ctrlsettext _itemName;

			_ctrlInfoAuthor = _display displayctrl IDC_RSCDISPLAYARSENAL_INFO_INFOAUTHOR;
			_ctrlInfoAuthor ctrlsettext "";
			[_itemCfg,_ctrlInfoAuthor] call bis_fnc_overviewauthor;

			//--- DLC / mod icon
			_ctrlDLC = _display displayctrl IDC_RSCDISPLAYARSENAL_INFO_DLCICON;
			_ctrlDLCBackground = _display displayctrl IDC_RSCDISPLAYARSENAL_INFO_DLCBACKGROUND;
			_dlc = _itemCfg call GETDLC;
			if (_dlc != ""/* && _fullVersion*/) then {

				_dlcParams = modParams [_dlc,["name","logo","logoOver"]];
				_dlcParams params ["_name","_logo","_logoOver"];
				_appId = getnumber (configfile >> "CfgMods" >> _dlc >> "appId");

				_ctrlDLC ctrlsettooltip _name;
				_ctrlDLC ctrlsettext _logo;
				_ctrlDLCBackground ctrlsetfade 0;
				if (_appId > 0) then {
					_ctrlDLC ctrlsetfade 0;
					_ctrlDLC ctrlseteventhandler ["mouseexit",format ["(_this select 0) ctrlsettext '%1';",_logo]];
					_ctrlDLC ctrlseteventhandler ["mouseenter",format ["(_this select 0) ctrlsettext '%1';",_logoOver]];
					_ctrlDLC ctrlseteventhandler [
						"buttonclick",
						format ["uiNamespace setvariable ['RscDisplayDLCPreview_dlc','%1']; ctrlparent (_this select 0) createDisplay 'RscDisplayDLCPreview';",_dlc]
					];
				} else {
					_ctrlDLC ctrlsetfade 0.5;
				};
			} else {
				_ctrlDLC ctrlsetfade 1;
				_ctrlDLCBackground ctrlsetfade 1;
			};
			_ctrlDLC ctrlcommit FADE_DELAY;
			_ctrlDLCBackground ctrlcommit FADE_DELAY;

			//--- Library
/*
			_libraryText = gettext (_itemCfg >> "Library" >> "libTextDesc");
			_ctrlStatsText = _display displayctrl IDC_RSCDISPLAYARSENAL_WEAPON_WEAPONTEXT;
			if (_libraryText != "") then {
				_ctrlStatsText ctrlsetstructuredtext parsetext format ["<t size='0.8'>%1</t>",_libraryText];
				_ctrlStatsText call bis_fnc_ctrlfittotextheight;
				_ctrlStatsText ctrlsetfade 0;
			} else {
				_ctrlStatsText ctrlsetfade 1;
			};
			_ctrlStatsText ctrlcommit FADE_DELAY;
*/
		} else {
			_ctrlInfo = _display displayctrl IDC_RSCDISPLAYARSENAL_INFO_INFO;
			_ctrlInfo ctrlsetfade 1;
			_ctrlInfo ctrlcommit FADE_DELAY;

			_ctrlStats = _display displayctrl IDC_RSCDISPLAYARSENAL_STATS_STATS;
			_ctrlStats ctrlsetfade 1;
			_ctrlStats ctrlcommit FADE_DELAY;
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

			switch _index do {
				case IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON;
				case IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON;
				case IDC_RSCDISPLAYARSENAL_TAB_HANDGUN: {
					_ctrlStats ctrlsetfade 0;
					_statsExtremes = uinamespace getvariable "bis_fnc_arsenal_weaponStats";
					if !(isnil "_statsExtremes") then {
						_statsMin = _statsExtremes select 0;
						_statsMax = _statsExtremes select 1;

						_stats = [
							[_itemCfg],
							STATS_WEAPONS,
							_statsMin
						] call bis_fnc_configExtremes;
						_stats = _stats select 1;

						_statReloadSpeed = linearConversion [_statsMin select 0,_statsMax select 0,_stats select 0,_barMax,_barMin];
						_statDispersion = linearConversion [_statsMin select 1,_statsMax select 1,_stats select 1,_barMax,_barMin];
						_statMaxRange = linearConversion [_statsMin select 2,_statsMax select 2,_stats select 2,_barMin,_barMax];
						_statHit = linearConversion [_statsMin select 3,_statsMax select 3,_stats select 3,_barMin,_barMax];
						_statMass = linearConversion [_statsMin select 4,_statsMax select 4,_stats select 4,_barMin,_barMax];
						_statInitSpeed = linearConversion [_statsMin select 5,_statsMax select 5,_stats select 5,_barMin,_barMax];
						if (getnumber (_itemCfg >> "type") == 4) then {
							[
								[],
								[],
								[_statMaxRange,localize "str_a3_rscdisplayarsenal_stat_range"],
								[_statHit,localize "str_a3_rscdisplayarsenal_stat_impact"],
								[_statMass,localize "str_a3_rscdisplayarsenal_stat_weight"]
							] call _fnc_showStats;
						} else {
							_statHit = sqrt(_statHit^2 * (_statInitSpeed max 0)); //--- Make impact influenced by muzzle speed
							[
								[_statReloadSpeed,localize "str_a3_rscdisplayarsenal_stat_rof"],
								[_statDispersion,localize "str_a3_rscdisplayarsenal_stat_dispersion"],
								[_statMaxRange,localize "str_a3_rscdisplayarsenal_stat_range"],
								[_statHit,localize "str_a3_rscdisplayarsenal_stat_impact"],
								[_statMass,localize "str_a3_rscdisplayarsenal_stat_weight"]
							] call _fnc_showStats;
						};
					};
				};
				case IDC_RSCDISPLAYARSENAL_TAB_UNIFORM;
				case IDC_RSCDISPLAYARSENAL_TAB_VEST;
				case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK;
				case IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR: {
					_ctrlStats ctrlsetfade 0;
					_statsExtremes = uinamespace getvariable "bis_fnc_arsenal_equipmentStats";
					if !(isnil "_statsExtremes") then {
						_statsMin = _statsExtremes select 0;
						_statsMax = _statsExtremes select 1;

						_stats = [
							[_itemCfg],
							STATS_EQUIPMENT,
							_statsMin
						] call bis_fnc_configExtremes;
						_stats = _stats select 1;

						_statArmorShot = linearConversion [_statsMin select 0,_statsMax select 0,_stats select 0,_barMin,_barMax];
						_statArmorExpl = linearConversion [_statsMin select 1,_statsMax select 1,_stats select 1,_barMin,_barMax];
						_statMaximumLoad = linearConversion [_statsMin select 2,_statsMax select 2,_stats select 2,_barMin,_barMax];
						_statMass = linearConversion [_statsMin select 3,_statsMax select 3,_stats select 3,_barMin,_barMax];

						if (getnumber (_itemCfg >> "isbackpack") == 1) then {
							_statArmorShot = _barMin;
							_statArmorExpl = _barMin;
						}; //--- Force no backpack armor

						[
							switch _item do { //--- Easter eggs
								case "H_Hat_Tinfoil_F": {[0.42,localize "STR_A3_C_RscDisplayArsenal_Stat_Tinfoil"]};
								case "H_Beret_blk": {[0.95,localize "STR_difficulty3"]};
								default {[]}
							},
							[_statArmorShot,localize "str_a3_rscdisplayarsenal_stat_passthrough"],
							[_statArmorExpl,localize "str_a3_rscdisplayarsenal_stat_armor"],
							[_statMaximumLoad,localize "str_a3_rscdisplayarsenal_stat_load"],
							[_statMass,localize "str_a3_rscdisplayarsenal_stat_weight"]
						] call _fnc_showStats;
					};
				};
				default {
					_ctrlStats ctrlsetfade 1;
				};
			};
			_ctrlStats ctrlcommit FADE_DELAY;
		} else {
			_ctrlStats = _display displayctrl IDC_RSCDISPLAYARSENAL_STATS_STATS;
			_ctrlStats ctrlsetfade 1;
			_ctrlStats ctrlcommit FADE_DELAY;
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "ShowItem": {
		private ["_display","_ctrlList","_index","_cursel","_item","_center","_action"];
		_display = _this select 0;
		_ctrlList = _this select 1;
		_index = _this select 2;
		_cursel = lbcursel _ctrlList;
		if (_cursel < 0) exitwith {};
		_item = _ctrlList lbdata _cursel;
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);

		_action = "";
		switch _index do {

			case IDC_RSCDISPLAYARSENAL_TAB_UNIFORM;
			case IDC_RSCDISPLAYARSENAL_TAB_VEST;
			case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK;
			case IDC_RSCDISPLAYARSENAL_TAB_HEADGEAR;
			case IDC_RSCDISPLAYARSENAL_TAB_GOGGLES;
			case IDC_RSCDISPLAYARSENAL_TAB_NVGS: {
				_action = "Stand";
			};
			case IDC_RSCDISPLAYARSENAL_TAB_BINOCULARS: {
				_action = if (_item == "") then {"Civil"} else {"Binoculars"};
			};
			case IDC_RSCDISPLAYARSENAL_TAB_PRIMARYWEAPON: {
				_center selectweapon primaryweapon _center;
				_action = if (_item == "") then {"Civil"} else {"PrimaryWeapon"};
				BIS_fnc_arsenal_selectedWeaponType = 0;
			};
			case IDC_RSCDISPLAYARSENAL_TAB_SECONDARYWEAPON: {
				_center selectweapon secondaryweapon _center;
				_action = if (_item == "") then {"Civil"} else {"SecondaryWeapon"};
				BIS_fnc_arsenal_selectedWeaponType = 1;
			};
			case IDC_RSCDISPLAYARSENAL_TAB_HANDGUN: {
				_center selectweapon handgunweapon _center;
				_action = if (_item == "") then {"Civil"} else {"HandGunOn"};
				BIS_fnc_arsenal_selectedWeaponType = 2;
			};
			case IDC_RSCDISPLAYARSENAL_TAB_MAP;
			case IDC_RSCDISPLAYARSENAL_TAB_GPS;
			case IDC_RSCDISPLAYARSENAL_TAB_RADIO;
			case IDC_RSCDISPLAYARSENAL_TAB_COMPASS;
			case IDC_RSCDISPLAYARSENAL_TAB_WATCH;
			case IDC_RSCDISPLAYARSENAL_TAB_FACE;
			case IDC_RSCDISPLAYARSENAL_TAB_VOICE;
			case IDC_RSCDISPLAYARSENAL_TAB_ITEMOPTIC;
			case IDC_RSCDISPLAYARSENAL_TAB_ITEMACC;
			case IDC_RSCDISPLAYARSENAL_TAB_ITEMMUZZLE;
			case IDC_RSCDISPLAYARSENAL_TAB_ITEMBIPOD: {
			};
			case IDC_RSCDISPLAYARSENAL_TAB_INSIGNIA: {
				_action = "Salute";
			};
		};

		if (_action != "" && _action != BIS_fnc_arsenal_action) then {
			if (simulationenabled _center) then {_center playactionnow _action;} else {_center switchaction _action;};
			BIS_fnc_arsenal_action = _action;
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "lbSort": {
		private _input = _this select 0;
		private _idc = (_this select 1);

		private _display = ctrlparent (_input select 0);
		private _sort = _input select 1;
		private _ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _idc);
		private _cursel = lbcursel _ctrlList;
		private _selected = _ctrlList lbdata _cursel;
		if (_sort > 0) then {
			lbsortbyvalue _ctrlList;
		} else {
			lbsort _ctrlList;
		};

		//--- Selected previously selected item (if there was one)
		if (_cursel >= 0) then {
			for '_i' from 0 to (lbsize _ctrlList - 1) do {
				if ((_ctrlList lbdata _i) == _selected) exitwith {_ctrlList lbsetcursel _i;};
			};
		};

		//--- Store sort type for persistent use
		_sortValues = uinamespace getvariable ["bis_fnc_arsenal_sort",[]];
		_sortValues set [_idc,_sort];
		uinamespace setvariable ["bis_fnc_arsenal_sort",_sortValues];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "KeyDown": 
	{
		_display = _this select 0;
		_key = _this select 1;
		_shift = _this select 2;
		_ctrl = _this select 3;
		_alt = _this select 4;
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		_return = false;
		_ctrlTemplate = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_inTemplate = ctrlfade _ctrlTemplate == 0;

		switch true do {
			case (_key == DIK_ESCAPE): {
				if (_inTemplate) then {
					_ctrlTemplate ctrlsetfade 1;
					_ctrlTemplate ctrlcommit 0;
					_ctrlTemplate ctrlenable false;

					_ctrlMouseBlock = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
					_ctrlMouseBlock ctrlenable false;
				} else {
					if (_fullVersion) then {["buttonClose",[_display]] spawn SELF_FUNC;} else {_display closedisplay 2;};
				};
				_return = true;
			};

			//--- Enter
			case (_key in [DIK_RETURN,DIK_NUMPADENTER]): {
				_ctrlTemplate = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
				if (ctrlfade _ctrlTemplate == 0) then {
					if (BIS_fnc_arsenal_type == 0) then {
						["buttonTemplateOK",[_display]] spawn SELF_FUNC;
					} else {
						["buttonTemplateOK",[_display]] spawn GARAGE_FUNC;
					};
					_return = true;
				};
			};

			//--- Prevent opening the commanding menu
			case (_key == DIK_1);
			case (_key == DIK_2);
			case (_key == DIK_3);
			case (_key == DIK_4);
			case (_key == DIK_5);
			case (_key == DIK_1);
			case (_key == DIK_7);
			case (_key == DIK_8);
			case (_key == DIK_9);
			case (_key == DIK_0): {
				_return = true;
			};

			//--- Tab to browse tabs
			case (_key == DIK_TAB): {
				_idc = -1;
				{
					_ctrlTab = _display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _x);
					if !(ctrlenabled _ctrlTab) exitwith {_idc = _x;};
				} foreach [IDCS_LEFT];
				_idcCount = {!isnull (_display displayctrl (IDC_RSCDISPLAYARSENAL_TAB + _x))} count [IDCS_LEFT];
				_idc = if (_ctrl) then {(_idc - 1 + _idcCount) % _idcCount} else {(_idc + 1) % _idcCount};
				if (BIS_fnc_arsenal_type == 0) then {
					["TabSelectLeft",[_display,_idc]] call SELF_FUNC;
				} else {
					["TabSelectLeft",[_display,_idc]] call GARAGE_FUNC;
				};
				_return = true;
			};

			//--- Export to script (Ctrl+C), export to config (Ctrl+Shift+C)
			case (_key == DIK_C): { if (_ctrl) then { ['buttonExport', [_display, ["init", "config"] select _shift]] call (missionNamespace getVariable ([GARAGE_FUNC_NAME, SELF_NAME] select (BIS_fnc_arsenal_type == 0))) } };
			
			//--- Import from script (Ctrl+V)
			case (_key == DIK_V): { if (_ctrl) then { ['buttonImport' ,[_display]] call (missionNamespace getVariable ([GARAGE_FUNC_NAME, SELF_NAME] select (BIS_fnc_arsenal_type == 0))) } };
			
			//--- Save (Ctrl+S)
			case (_key == DIK_S): { if (_ctrl) then { ['buttonSave', [_display]] call SELF_FUNC } };
			
			//--- Open (Ctrl+O)
			case (_key == DIK_O): { if (_ctrl) then {['buttonLoad',[_display]] call SELF_FUNC } };
			
			//--- Randomize (Ctrl+R)
			case (_key == DIK_R): 
			{
				if (_ctrl) then {
					if (BIS_fnc_arsenal_type == 0) then {
						if (_shift) then {
							_soldiers = [];
							{
								_soldiers set [count _soldiers,configname _x];
							} foreach ("getnumber (_x >> 'scope') > 1 && gettext (_x >> 'simulation') == 'soldier'" configclasses (configfile >> "cfgvehicles"));
							[_center, selectRandom _soldiers] call bis_fnc_loadinventory;
							_center switchmove "";
							["ListSelectCurrent",[_display]] call SELF_FUNC;
						} else {
							['buttonRandom',[_display]] call SELF_FUNC;
						};
					} else {
						['buttonRandom',[_display]] call GARAGE_FUNC;
					};
				};
			};
			//--- Toggle interface
			case (_key == DIK_BACKSPACE && !_inTemplate): {
				['buttonInterface',[_display]] call SELF_FUNC;
				_return = true;
			};

			//--- Acctime
			case (_key in (actionkeys "timeInc")): {
				if (acctime == 0) then {setacctime 1;};
				_return = true;
			};
			case (_key in (actionkeys "timeDec")): {
				if (acctime != 0) then {setacctime 0;};
				_return = true;

			};

			//--- Vision mode
			case (_key in (actionkeys "nightvision") && !_inTemplate): {
				_mode = missionnamespace getvariable ["BIS_fnc_arsenal_visionMode",-1];
				_mode = (_mode + 1) % 3;
				missionnamespace setvariable ["BIS_fnc_arsenal_visionMode",_mode];
				switch _mode do {
					//--- Normal
					case 0: {
						camusenvg false;
						false setCamUseTi 0;
					};
					//--- NVG
					case 1: {
						camusenvg true;
						false setCamUseTi 0;
					};
					//--- TI
					default {
						camusenvg false;
						true setCamUseTi 0;
					};
				};
				playsound ["RscDisplayCurator_visionMode",true];
				_return = true;

			};
/*
			//--- Delete template
			case (_key == DIK_DELETE): {
				_ctrlMouseBlock = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
				if !(ctrlenabled _ctrlMouseBlock) then {
					['buttonTemplateDelete',[_display]] call SELF_FUNC;
					_return = true;
				};
			};
*/
		};
		_return
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonCargo": {
		_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		_display = _this select 0;
		_add = _this select 1;

		_selected = -1;
		{
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
			if (ctrlenabled _ctrlList) exitwith {_selected = _x;};
		} foreach [IDCS_LEFT];

		_ctrlList = ctrlnull;
		_lbcursel = -1;
		{
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
			if (ctrlenabled _ctrlList) exitwith {_lbcursel = lbcursel _ctrlList;};
		} foreach [IDCS_RIGHT];
		_item = _ctrlList lnbdata [_lbcursel,0];
		_load = 0;
		_items = [];
		switch _selected do {
			case IDC_RSCDISPLAYARSENAL_TAB_UNIFORM: {
				if (_add > 0) then {_center additemtouniform _item;} else {_center removeitemfromuniform _item;};
				_load = loaduniform _center;
				_items = uniformitems _center;
			};
			case IDC_RSCDISPLAYARSENAL_TAB_VEST: {
				if (_add > 0) then {_center additemtovest _item;} else {_center removeitemfromvest _item;};
				_load = loadvest _center;
				_items = vestitems _center;
			};
			case IDC_RSCDISPLAYARSENAL_TAB_BACKPACK: {
				if (_add > 0) then {_center additemtobackpack _item;} else {_center removeitemfrombackpack _item;};
				_load = loadbackpack _center;
				_items = backpackitems _center;
			};
		};

		_ctrlLoadCargo = _display displayctrl IDC_RSCDISPLAYARSENAL_LOADCARGO;
		_ctrlLoadCargo progresssetposition _load;

		_value = {_x == _item} count _items;
		//_ctrlList lnbsetvalue [[_lbcursel,0],_value];
		_ctrlList lnbsettext [[_lbcursel,2],str _value];

		["SelectItemRight",[_display,_ctrlList,_index]] call SELF_FUNC;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonTemplateOK": 
	{
		private _display = _this select 0;
		private _center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
		private _hideTemplate = true;

		private _ctrlTemplateName = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
		if (ctrlenabled _ctrlTemplateName) then 
		{
			//--- Save
			[
				_center,
				[profilenamespace, ctrltext _ctrlTemplateName],
				[
					face _center,
					speaker _center,
					_center call _fnc_getUnitInsignia
				]
			] call bis_fnc_saveInventory;
		} 
		else 
		{
			//--- Load
			private _ctrlTemplateValue = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
			private _cursel = lnbCurSelRow _ctrlTemplateValue;
			if ((_ctrlTemplateValue lnbValue [_cursel, 0]) >= 0 || _ctrlTemplateValue lnbData [_cursel, 0] == "override") then 
			{
				private _inventory = _ctrlTemplateValue lnbtext [_cursel,0];
				[_center, [profileNamespace, _inventory]] call bis_fnc_loadinventory;
				_center switchMove "";

				//--- Load custom data
				_ctrlTemplateValue = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
				private _data = profilenamespace getvariable ["bis_fnc_saveInventory_data",[]];
				private _name = _ctrlTemplateValue lnbtext [_cursel,0];
				_nameID = _data find _name;
				
				if (_nameID >= 0 && !is3DEN) then
				{
					_data select (_nameID + 1) select 10 params [["_face", ""], ["_speaker",""], ["_insignia",""]];
					if !(_face isEqualTo "") then { _center setFace _face };
					if !(_speaker isEqualTo "") then { _center setSpeaker _speaker };
					[_center, _insignia, false] call _fnc_setUnitInsignia;
				};

				["ListSelectCurrent", [_display]] call SELF_FUNC;
				
			} else {
				_hideTemplate = false;
			};
		};
		if (_hideTemplate) then {
			private _ctrlTemplate = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
			_ctrlTemplate ctrlsetfade 1;
			_ctrlTemplate ctrlcommit 0;
			_ctrlTemplate ctrlenable false;

			private _ctrlMouseBlock = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
			_ctrlMouseBlock ctrlenable false;
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonTemplateCancel": 
	{
		_display = _this select 0;

		_ctrlTemplate = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_ctrlTemplate ctrlsetfade 1;
		_ctrlTemplate ctrlcommit 0;
		_ctrlTemplate ctrlenable false;

		_ctrlMouseBlock = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
		_ctrlMouseBlock ctrlenable false;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonTemplateDelete": 
	{
		// --- confirm delete --- //
		if (_confirmAction isEqualTo true) exitWith
		{
			_this spawn 
			{
				if (["Are you sure?", "Confirm Delete", true, true, _this select 0] call BIS_fnc_guiMessage) then 
				{ 
					isNil { with uinamespace do { ["buttonTemplateDelete", _this, !_confirmAction] call SELF_FUNC } };
				};
			};
		};
		
		_display = _this select 0;
		_ctrlTemplateValue = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_cursel = lnbcurselrow _ctrlTemplateValue;
		_name = _ctrlTemplateValue lnbtext [_cursel,0];
		[_center,[profilenamespace,_name],nil,true] call (uinamespace getvariable (["bis_fnc_saveInventory","bis_fnc_saveVehicle"] select BIS_fnc_arsenal_type));
		['showTemplates',[_display]] call (missionNamespace getVariable ([SELF_NAME, GARAGE_FUNC_NAME] select BIS_fnc_arsenal_type));
		_ctrlTemplateValue lnbsetcurselrow (_cursel max (lbsize _ctrlTemplateValue - 1));

		["templateSelChanged",[_display]] call SELF_FUNC;
/*
		_enableButtons = (lnbsize _ctrlTemplateValue select 0) > 0;
		_ctrlTemplateButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		_ctrlTemplateButtonOK ctrlenable _enableButtons;
		_ctrlTemplateButtonDelete = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
		_ctrlTemplateButtonDelete ctrlenable _enableButtons;
*/
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "templateSelChanged": {
		_display = _this select 0;

		_ctrlTemplate = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_ctrlTemplateValue = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_ctrlTemplateName = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
		_ctrlTemplateName ctrlsettext (_ctrlTemplateValue lnbtext [lnbcurselrow _ctrlTemplateValue,0]);

		_cursel = lnbcurselrow _ctrlTemplateValue;

		_ctrlTemplateButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		_ctrlTemplateButtonOK ctrlenable (_cursel >= 0 && (_display getVariable ["saveMode", false] || _ctrlTemplateValue lnbValue [_cursel, 0] >= 0 || _ctrlTemplateValue lnbData [_cursel, 0] == "override"));

		_ctrlTemplateButtonDelete = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
		_ctrlTemplateButtonDelete ctrlenable (_cursel >= 0);
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "showTemplates": 
	{
		private _CFGVEHICLES = configfile >> "CfgVehicles";
		private _CFGWEAPONS = configfile >> "CfgWeapons";
		private _CFGMAGAZINES = configfile >> "CfgMagazines";
		private _CFGGLASSES = configfile >> "CfgGlasses";
		
		_display = _this select 0;
		_ctrlTemplateValue = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		lnbclear _ctrlTemplateValue;
		private _data = profilenamespace getvariable ["bis_fnc_saveInventory_data",[]];
		private _center = missionnamespace getvariable ["BIS_fnc_arsenal_center",player];
		private _cargo = missionnamespace getvariable ["BIS_fnc_arsenal_cargo",objnull];
		
		GETVIRTUALCARGO
		
		for "_i" from 0 to (count _data - 1) step 2 do 
		{
			private _name = _data select _i;
			private _inventory = _data select (_i + 1);
			private _lbAdd = _ctrlTemplateValue lnbaddrow [_name];
			private _testItem = "";
			
			_ctrlTemplateValue lnbsetpicture [[_lbAdd,1],gettext (_CFGWEAPONS >> (_inventory select 6 select 0) >> "picture")];
			_ctrlTemplateValue lnbsetpicture [[_lbAdd,2],gettext (_CFGWEAPONS >> (_inventory select 7 select 0) >> "picture")];
			_ctrlTemplateValue lnbsetpicture [[_lbAdd,3],gettext (_CFGWEAPONS >> (_inventory select 8 select 0) >> "picture")];
			_ctrlTemplateValue lnbsetpicture [[_lbAdd,4],gettext (_CFGWEAPONS >> (_inventory select 0 select 0) >> "picture")];
			_ctrlTemplateValue lnbsetpicture [[_lbAdd,5],gettext (_CFGWEAPONS >> (_inventory select 1 select 0) >> "picture")];
			_ctrlTemplateValue lnbsetpicture [[_lbAdd,6],gettext (_CFGVEHICLES >> (_inventory select 2 select 0) >> "picture")];
			_ctrlTemplateValue lnbsetpicture [[_lbAdd,7],gettext (_CFGWEAPONS >> (_inventory select 3) >> "picture")];
			_ctrlTemplateValue lnbsetpicture [[_lbAdd,8],gettext (configfile >> "cfgglasses" >> (_inventory select 4) >> "picture")];
			
			_inventory params ["_uniform", "_vest", "_backpack", "_headgear", "_goggles", "_binocular", "_primary", "_secondary", "_handgun", "_items", "_other"];
		
			if (call
			{
				private _allgear = [];
				_allgear pushback (_uniform select 0);
				_allgear append (_uniform select 1);
				_allgear pushback (_vest select 0);
				_allgear append (_vest select 1);
				_allgear pushback (_backpack select 0);
				_allgear append (_backpack select 1);
				_allgear pushback _headgear;
				_allgear pushback _goggles;
				_allgear pushback _binocular;
				_allgear pushback (_primary select 2);
				_allgear pushback (_secondary select 2);
				_allgear pushback (_handgun select 2);
				_allgear append _items;
				if (!is3DEN) then { _allgear append _other }; // face voice insignia
			
				// check all gear against allowed items
				if ((_allgear - [""]) findIf 
				{ 
					_testItem = _x;
					!(_fastLookupTable getVariable [_testItem, false])
				} > -1) exitWith { true };
				
				/*
				if (((_primary select 1) - [""]) findIf 
				{
					_testItem = _x;
					private _cfg = _CFGWEAPONS >> _testItem; 
					(if (isnumber (_cfg >> "scopeArsenal")) then {getnumber (_cfg >> "scopeArsenal")} else {getnumber (_cfg >> "scope")}) != 2 
					|| 
					{ gettext (_cfg >> "model") == "" } 
				} > -1) exitWith { true };
				
				if (((_secondary select 1) - [""]) findIf 
				{ 
					_testItem = _x;
					private _cfg = _CFGWEAPONS >> _testItem; 
					(if (isnumber (_cfg >> "scopeArsenal")) then {getnumber (_cfg >> "scopeArsenal")} else {getnumber (_cfg >> "scope")}) != 2 
					|| 
					{ gettext (_cfg >> "model") == "" } 
				} > -1) exitWith { true };
				
				if (((_handgun select 1) - [""]) findIf 
				{ 
					_testItem = _x;
					private _cfg = _CFGWEAPONS >> _testItem; 
					(if (isnumber (_cfg >> "scopeArsenal")) then {getnumber (_cfg >> "scopeArsenal")} else {getnumber (_cfg >> "scope")}) != 2 
					|| 
					{ gettext (_cfg >> "model") == "" } 
				} > -1) exitWith { true };
				*/
				
				if (_firstAvailable < 0) then { _firstAvailable = _i };
				
				false
			}) 
			then 
			{
				_ctrlTemplateValue lnbSetColor [[_lbAdd,0],[1,1,1,0.25]];
				_ctrlTemplateValue lnbSetValue [[_lbAdd,0],-1];
				_ctrlTemplateValue lnbSetData [[_lbAdd,0],["", "override"] select isNil { _fastLookupTable getVariable _testItem }]; // make load button still available
				_ctrlTemplateValue lnbSetToolTip [[_lbAdd,0], format ["%1 [ %2 ]", toUpper localize "str_a3_itemtype_unknownequipment", _testItem]];
			};
		};
		
		_ctrlTemplateValue lnbSort [0,false];

		private _firstAvailable = -1;
		if !(_display getVariable ["saveMode", false]) then 
		{
			for "_i" from 0 to (lnbSize _ctrlTemplateValue select 0) - 1 do 
			{ 
				if (_ctrlTemplateValue lnbValue [_i, 0] > -1) exitWith 
				{ 
					_firstAvailable = _i;
				};	
			};
		};
		_ctrlTemplateValue lnbSetCurSelRow _firstAvailable;
		
		//["templateSelChanged",[_display]] call SELF
		//['buttonExport',[_display]] call SELF_FUNC;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonImport": 
	{
		startloadingscreen [""];
		
		private _display = _this select 0;
		private _center = missionnamespace getvariable ["BIS_fnc_arsenal_center",player];
		private _cargo = missionnamespace getvariable ["BIS_fnc_arsenal_cargo",objnull];

		GETVIRTUALCARGO

		private _disabledItems = [];

		private _import = copyfromclipboard;
		private _importArray = [_import," 	;='""" + tostring [13,10]] call bis_fnc_splitString;

		if (count _importArray == 1) then 
		{
			//--- Import vehicle class
			private _class = _importArray select 0;
			if (isclass (configfile >> "cfgvehicles" >> _class)) then 
			{
				[_center, _class] call bis_fnc_loadinventory; 
				_center switchMove "";
			};
		} 
		else 
		{
			//--- Import specific items
			_importArray = _importArray + [""];
			_to = 1;
			{
				private _item = _importArray select _foreachindex + 1;
				switch tolower _x do 
				{
					case "to": {_to = parsenumber _item;};

					case "removeallweapons": {removeallweapons _center};
					case "removeallitems": {removeallitems _center};
					case "removeallassigneditems": {removeallassignedItems _center};
					case "removeuniform": {removeuniform _center};
					case "removevest": {removevest _center};
					case "removebackpack": {removebackpack _center};
					case "removeheadgear": {removeheadgear _center};
					case "removegoggles": {removegoggles _center};	
					case "forceadduniform";
					case "adduniform": 
					{
						if (CONDITION(_virtualItemCargo)) then {_center forceadduniform _item} else {ERROR};
					};
					case "addvest": 
					{
						if (CONDITION(_virtualItemCargo)) then {_center addvest _item} else {ERROR};
					};
					case "addbackpack":
					{
						if (CONDITION(_virtualBackpackCargo)) then {_center addbackpack _item} else {ERROR};
					};
					case "addheadgear": 
					{
						if (CONDITION(_virtualItemCargo)) then {_center addheadgear _item} else {ERROR};
					};
					case "addgoggles": 
					{
						if (CONDITION(_virtualItemCargo)) then {_center addgoggles _item} else {ERROR};
					};

					case "additemtouniform": 
					{
						if (CONDITION(_virtualItemCargo + _virtualMagazineCargo)) then {for "_n" from 1 to _to do {_center additemtouniform _item}} else {ERROR};
						_to = 1;
					};
					case "additemtovest": 
					{
						if (CONDITION(_virtualItemCargo + _virtualMagazineCargo)) then {for "_n" from 1 to _to do {_center additemtovest _item;}} else {ERROR};
						_to = 1;
					};
					case "additemtobackpack": 
					{
						if (CONDITION(_virtualItemCargo + _virtualMagazineCargo)) then {for "_n" from 1 to _to do {_center additemtobackpack _item;}} else {ERROR};
						_to = 1;
					};
					case "addweapon": 
					{
						if (CONDITION(_virtualWeaponCargo)) then { _center addweapon _item; } else {ERROR};
					};
					case "addprimaryweaponitem": 
					{
						if (CONDITION(_virtualItemCargo)) then {_center addprimaryweaponitem _item;} else {ERROR};
					};
					case "addsecondaryweaponitem": 
					{
						if (CONDITION(_virtualItemCargo)) then {_center addsecondaryweaponitem _item;} else {ERROR};
					};
					case "addhandgunitem": 
					{
						if (CONDITION(_virtualItemCargo)) then {_center addhandgunitem _item;} else {ERROR};
					};

					case "addmagazine": 
					{
						if (CONDITION(_virtualMagazineCargo)) then {_center addmagazine _item;} else {ERROR};
					};
					case "additem": 
					{
						if (CONDITION(_virtualItemCargo)) then {_center additem _item;} else {ERROR};
					};
					case "assignitem": 
					{
						if (CONDITION(_virtualItemCargo)) then {_center assignitem _item;} else {ERROR};
					};
					case "linkitem": 
					{
						if (CONDITION(_virtualItemCargo)) then {_center linkitem _item;} else {ERROR};
					};

					case "setface": 
					{
						if (_fullVersion) then { if !(_item isEqualTo "") then { _center setFace _item } };
					};
					case "setspeaker": 
					{
						if (_fullVersion) then { if !(_item isEqualTo "") then { _center setSpeaker _item } };
					};
					case "bis_fnc_setunitinsignia": 
					{
						if (_fullVersion) then { [_center, _item, false] call _fnc_setUnitInsignia }; //[_center,_importArray select ((_foreachindex - 3) max 0)] call bis_fnc_setunitinsignia;
					};
				};
			} 
			foreach _importArray;
		};

		//--- Show unavailable items
		if (count _disabledItems > 0) then 
		{
			["showMessage", [_display, localize "STR_A3_RscDisplayArsenal_message_unavailable"]] call SELF_FUNC;
		};

		["ListSelectCurrent",[_display]] call SELF_FUNC;
		//["templateSelChanged",[_display]] call SELF_FUNC;
		endloadingscreen;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonExport":
	{
		[missionnamespace getvariable ["BIS_fnc_arsenal_center", player], _this select 1, _fullVersion] call BIS_fnc_exportInventory spawn { copytoclipboard _this };
		["showMessage", [_this select 0, localize "STR_a3_RscDisplayArsenal_message_clipboard"]] call SELF_FUNC;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonLoad": 
	{
		_display = _this select 0;
		_display setVariable ["saveMode", false];
		
		['showTemplates',[_display]] call ([SELF_FUNC, GARAGE_FUNC] select BIS_fnc_arsenal_type);

		_ctrlTemplate = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_ctrlTemplate ctrlsetfade 0;
		_ctrlTemplate ctrlcommit 0;
		_ctrlTemplate ctrlenable true;

		_ctrlMouseBlock = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
		_ctrlMouseBlock ctrlenable true;
		ctrlsetfocus _ctrlMouseBlock;

		{
			(_display displayctrl _x) ctrlsettext localize "str_disp_int_load";
		} foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TITLE,IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK];
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlshow false;
			_ctrl ctrlenable false;
		} foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TEXTNAME,IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME];
		_ctrlTemplateValue = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		if (lnbcurselrow _ctrlTemplateValue < 0) then {_ctrlTemplateValue lnbsetcurselrow 0;};
		ctrlsetfocus _ctrlTemplateValue;

		//--- Disable LOAD and DELETE buttons when no items are available
/*
		_enableButtons = (lnbsize _ctrlTemplateValue select 0) > 0;
		_ctrlTemplateButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		_ctrlTemplateButtonOK ctrlenable _enableButtons;
		_ctrlTemplateButtonDelete = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
		_ctrlTemplateButtonDelete ctrlenable _enableButtons;
*/
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonSave": 
	{
		_display = _this select 0;
		_display setVariable ["saveMode", true];
		
		['showTemplates',[_display]] call ([SELF_FUNC, GARAGE_FUNC] select BIS_fnc_arsenal_type);

		_ctrlTemplate = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_TEMPLATE;
		_ctrlTemplate ctrlsetfade 0;
		_ctrlTemplate ctrlcommit 0;
		_ctrlTemplate ctrlenable true;
		
		_ctrlMouseBlock = _display displayctrl IDC_RSCDISPLAYARSENAL_MOUSEBLOCK;
		_ctrlMouseBlock ctrlenable true;

		{
			(_display displayctrl _x) ctrlsettext localize "str_disp_int_save";
		} foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TITLE,IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK];
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlshow true;
			_ctrl ctrlenable true;
		} foreach [IDC_RSCDISPLAYARSENAL_TEMPLATE_TEXTNAME,IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME];

		_ctrlTemplateName = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_EDITNAME;
		ctrlsetfocus _ctrlTemplateName;

		_ctrlTemplateValue = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_VALUENAME;
		_ctrlTemplateButtonOK = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONOK;
		_ctrlTemplateButtonOK ctrlenable true;
		_ctrlTemplateButtonDelete = _display displayctrl IDC_RSCDISPLAYARSENAL_TEMPLATE_BUTTONDELETE;
		_ctrlTemplateButtonDelete ctrlenable ((lnbsize _ctrlTemplateValue select 0) > 0);

		["showMessage", [_display,localize "STR_A3_RscDisplayArsenal_message_save"]] call SELF_FUNC;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonRandom": 
	{
		private _CFGWEAPONS = configfile >> "CfgWeapons";
		private _display = _this select 0;
		private _center = missionnamespace getvariable ["BIS_fnc_arsenal_center", player];

		//--- Left sidebar
		{
			_ctrlList = _display displayctrl (IDC_RSCDISPLAYARSENAL_LIST + _x);
			_ctrlList lbsetcursel floor random (lbsize _ctrlList);
		} 
		foreach IDCS;

		//--- Right sidebar (attachments)
		{
			_weaponID = _foreachindex;
			{
				private _acc = selectRandom ((getArray (_x >> "compatibleItems") select { getNumber (_CFGWEAPONS >> _x >> "scope") == 2 }) + [""]);
				if (_acc != "") then 
				{
					switch _weaponID do 
					{
						case 0: {_center addprimaryweaponitem _acc};
						case 1: {_center addsecondaryweaponitem _acc};
						case 2: {_center addhandgunitem _acc};
					};
				};
			} 
			foreach ("true" configclasses (_CFGWEAPONS >> _x >> "WeaponSlotsInfo"));
		} 
		foreach 
		[
			primaryweapon _center,
			secondaryweapon _center,
			handgunweapon _center
		];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonInterface": {
		_display = _this select 0;
		_show = !ctrlshown (_display displayctrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_CONTROLBAR);
		{
			_tab = _x;
			{
				_ctrl = _display displayctrl (_tab + _x);
				_ctrl ctrlshow _show;
				_ctrl ctrlcommit FADE_DELAY;
			} foreach [
				IDC_RSCDISPLAYARSENAL_ICON,
				IDC_RSCDISPLAYARSENAL_ICONBACKGROUND,
				IDC_RSCDISPLAYARSENAL_TAB,
				IDC_RSCDISPLAYARSENAL_LIST,
				IDC_RSCDISPLAYARSENAL_SORT
			];
			_ctrl = _display displayctrl (_tab + IDC_RSCDISPLAYARSENAL_LISTDISABLED);
			_pos = if (_show) then {ctrlposition (_display displayctrl (_tab + IDC_RSCDISPLAYARSENAL_LIST))} else {[0,0,0,0]};
			_ctrl ctrlsetposition _pos;
			_ctrl ctrlcommit 0;
		} foreach IDCS;
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlshow _show;
			_ctrl ctrlcommit FADE_DELAY;
		} foreach [
			IDC_RSCDISPLAYARSENAL_CONTROLSBAR_CONTROLBAR,
			IDC_RSCDISPLAYARSENAL_TABS,
			IDC_RSCDISPLAYARSENAL_FRAMELEFT,
			IDC_RSCDISPLAYARSENAL_FRAMERIGHT,
			IDC_RSCDISPLAYARSENAL_LINEICON,
			IDC_RSCDISPLAYARSENAL_LINETABLEFT,
			IDC_RSCDISPLAYARSENAL_LINETABLEFTSELECTED,
			IDC_RSCDISPLAYARSENAL_LINETABRIGHT,
			IDC_RSCDISPLAYARSENAL_ICON,
			IDC_RSCDISPLAYARSENAL_ICONBACKGROUND,
			IDC_RSCDISPLAYARSENAL_TAB,
			IDC_RSCDISPLAYARSENAL_LIST,
			IDC_RSCDISPLAYARSENAL_LOAD,
			IDC_RSCDISPLAYARSENAL_LOADCARGO,
			IDC_RSCDISPLAYARSENAL_BACKGROUNDLEFT,
			IDC_RSCDISPLAYARSENAL_BACKGROUNDRIGHT,
			IDC_RSCDISPLAYARSENAL_STATS_STATS,
			IDC_RSCDISPLAYARSENAL_INFO_DLCBACKGROUND,
			IDC_RSCDISPLAYARSENAL_INFO_DLCICON,
			IDC_RSCDISPLAYARSENAL_SPACE_SPACE
		];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonSpace": {
		_ctrlButton = _this select 0;
		_display = ctrlparent _ctrlButton;
		_buttonID = [
			IDC_RSCDISPLAYARSENAL_SPACE_SPACEARSENAL,
			IDC_RSCDISPLAYARSENAL_SPACE_SPACEGARAGE
		] find (ctrlidc _ctrlButton);
		_function = [SELF_NAME, GARAGE_FUNC_NAME] select _buttonID;
		BIS_fnc_arsenal_toggleSpace = true;
		_display closedisplay 2;
		//missionnamespace setvariable ["BIS_fnc_arsenal_target",player];
		["Open",true] spawn (missionNamespace getvariable _function);
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonOK": {
		_display = _this select 0;
		_display closedisplay 2;

		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call bis_fnc_textTiles;

		//missionnamespace setvariable ["RscStatic_mode",0];
		//cutrsc ["rscstatic","plain"];

		//--- Apply the loadout on all selected objects
		if (is3DEN) then {
			_center = (missionnamespace getvariable ["BIS_fnc_arsenal_center",player]);
			_inventory = [_center,[_center,"arsenal"]] call bis_fnc_saveInventory;
			{
				[_x,[_center,"arsenal"]] call bis_fnc_loadInventory;
			} foreach (get3DENSelected "object");
			save3DENInventory (get3DENSelected "object");
			setstatvalue ["3DENArsenal",1];
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonClose": {
		_display = _this select 0;
		_message = if (missionname == "Arsenal") then {
			[
				localize "STR_SURE",
				localize "STR_disp_arcmap_exit",
				nil,
				true,
				_display,
				true
			] call bis_fnc_guimessage;
		} else {
			true
		};
		if (_message) then {
			_display closedisplay 2;
			if (missionname == "Arsenal") then {endmission "end1";};
			["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call bis_fnc_textTiles;
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "showMessage": 
	{
		private _script = missionnamespace getvariable ["BIS_fnc_arsenal_message", scriptNull];
		if (!isNull _script) then { terminate _script };

		_script = _this spawn 
		{
			// [display, message]
			disableserialization;
			
			private _ctrlMessage = (_this select 0) displayctrl IDC_RSCDISPLAYARSENAL_MESSAGE;
			_ctrlMessage ctrlsettext (_this select 1);
			_ctrlMessage ctrlsetfade 1;
			_ctrlMessage ctrlcommit 0;
			_ctrlMessage ctrlsetfade 0;
			_ctrlMessage ctrlcommit FADE_DELAY;
			uisleep 5;
			_ctrlMessage ctrlsetfade 1;
			_ctrlMessage ctrlcommit FADE_DELAY;
		};
		
		missionnamespace setvariable ["BIS_fnc_arsenal_message", _script];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "AmmoboxInit": 
	{
		params 
		[
			["_box",objnull,[objnull]], 
			["_allowAll",false,[false]], 
			["_condition",{true},[{}]]
		];

		if ({} isequalto {}) then {
			_box setvariable ["bis_fnc_arsenal_condition",_condition,true];
		};

		if (_allowAll) then 
		{
			[_box,true,true,false] call bis_fnc_addVirtualWeaponCargo;
			[_box,true,true,false] call bis_fnc_addVirtualMagazineCargo;
			[_box,true,true,false] call bis_fnc_addVirtualItemCargo;
			[_box,true,true,false] call bis_fnc_addVirtualBackpackCargo;
		};
		
		[["AmmoboxServer",_box,true],SELF_NAME,false] call bis_fnc_mp;
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "AmmoboxExit": 
	{
		private ["_box"];
		_box = [_this,0,objnull,[objnull]] call bis_fnc_param;
		[["AmmoboxServer",_box,false],SELF_NAME,false] call bis_fnc_mp;
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "AmmoboxServer": 
	{
		_box = [_this,0,objnull,[objnull]] call bis_fnc_param;
		_add = [_this,1,true,[true]] call bis_fnc_param;

		_boxes = missionnamespace getvariable ["bis_fnc_arsenal_boxes",[]];
		_boxes = _boxes - [_box];
		if (_add) then {_boxes = _boxes + [_box];};
		missionnamespace setvariable ["bis_fnc_arsenal_boxes",_boxes];
		publicvariable "bis_fnc_arsenal_boxes";

		["AmmoboxLocal",SELF_NAME,true,isnil "bis_fnc_arsenal_ammoboxServer"] call bis_fnc_mp;
		bis_fnc_arsenal_ammoboxServer = true;
	};
	
	///////////////////////////////////////////////////////////////////////////////////////////
	case "AmmoboxLocal": 
	{
		_boxes = missionnamespace getvariable ["bis_fnc_arsenal_boxes",[]];
		{
			if (isnil {_x getvariable "bis_fnc_arsenal_action"}) then {
				_action = _x addaction [
					localize "STR_A3_Arsenal",
					{
						_box = _this select 0;
						_unit = _this select 1;
						["Open",[nil,_box,_unit]] call SELF_FUNC;
					},
					[],
					6,
					true,
					false,
					"",
					"
						_cargo = _target getvariable ['bis_addVirtualWeaponCargo_cargo',[[],[],[],[]]];
						if ({count _x > 0} count _cargo == 0) then {
							_target removeaction (_target getvariable ['bis_fnc_arsenal_action',-1]);
							_target setvariable ['bis_fnc_arsenal_action',nil];
						};
						_condition = _target getvariable ['bis_fnc_arsenal_condition',{true}];
						alive _target && {_target distance _this < 5 && {vehicle _this == _this}} && {call _condition}
					"
				];
				_x setvariable ["bis_fnc_arsenal_action",_action];
			};
		} foreach _boxes;
	};
};