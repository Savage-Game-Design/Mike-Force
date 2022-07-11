/*
	File: fn_armor_calc.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Gear armor calculation functions
	
	Parameter(s):
		_type - switch [String, defaults to "init"]
		_item - payload [String, defaults to "" (empty string)]
		_extra - Extra [Number, defaults to 0]

	Returns:
		Numbers [Number]
	
	Example(s):
		_vestArmor = ["gear",(vest player)] call vn_mf_fnc_armor_calc;
*/

params [
	["_type","init"], 	// _this select 0: STRING - switch
	["_item",""], 		// _this select 1: STRING - payload
	["_extra",0]
];

private ["_armor","_bar","_bar_compare","_color","_colorCompare","_container","_curArmor","_data","_display","_existing_bar","_factorArmor","_finalArmor","_gearArmor","_gearConfig","_headgearArmor","_height","_index","_interactedItem","_maxArmorHeadgear","_maxArmorUniform","_maxArmorVest","_newArmor","_passThrough","_pic","_pos","_remoteContainer","_return","_selectedClass","_selectedItem","_small_height","_text","_totalArmor","_totalArmorMax","_totalArmorUI","_uniformArmor","_uniformArmorStructural","_uniformClass","_uniformConfig","_val","_vestArmor","_weaponsAndItems"];

_factorArmor =
{
	params ["_passThrough","_armor"];
	((_armor - (_armor*_passThrough))/2 + _armor)
};
_return = 0;
switch _type do
{
	case "gear":
	{
		private ["_gearArmor","_gearConfig","_passThrough","_armor"];
		_gearConfig = (configfile >> "CfgWeapons" >> _item);
		_passThrough = getNumber(_gearConfig >> "ItemInfo" >> "passThrough");
		_armor = getNumber(_gearConfig >> "ItemInfo" >> "armor");
		_gearArmor = ([_passThrough,_armor] call _factorArmor);
		{
			_gearArmor = _gearArmor + ([getNumber(_x >> 'passThrough'),getNumber(_x >> 'armor')] call _factorArmor)
		} forEach ("isClass _x" configclasses (_gearConfig >> "ItemInfo" >> "HitpointsProtectionInfo"));
		_return = _gearArmor;
	};
	case "uniform":
	{
		private ["_uniformClass","_uniformArmor","_uniformConfig","_uniformArmorStructural"];
		_uniformClass = _item;
		if (isClass (configFile >> "CfgWeapons" >> _item)) then
	{
			_uniformClass = gettext (configFile >> "CfgWeapons" >> _item >> "ItemInfo" >> "uniformclass");
		};
		_uniformConfig = (configfile >> "cfgvehicles" >> _uniformClass);
		_uniformArmor = getNumber(_uniformConfig >> "armor");
		_uniformArmorStructural = getNumber(_uniformConfig >> "armorStructural");
		{
			_uniformArmor = _uniformArmorStructural + ([getNumber(_x >> 'passThrough'),getNumber(_x >> 'armor')] call _factorArmor)
		} forEach ("isClass _x" configclasses (_uniformConfig >> "HitPoints"));
		_return = _uniformArmor;
	};
	case "maxArmorInit":
	{
		private ["_curArmor","_maxArmorUniform","_maxArmorVest","_maxArmorHeadgear"];
		_maxArmorUniform = 0;
		{
			_curArmor = ([getNumber(_x >> 'passThrough'),getNumber(_x >> 'armor')] call _factorArmor) + getNumber(_x >> 'armorStructural');
			{_curArmor = _curArmor + ([getNumber(_x >> 'passThrough'),getNumber(_x >> 'armor')] call _factorArmor)} forEach ("isClass _x" configclasses (_x >> "HitPoints"));
			if (_curArmor > _maxArmorUniform) then
		{
				_maxArmorUniform = _curArmor;
			};
		} forEach (("isclass _x && getnumber (_x >> 'scope') == 2 && getText (_x >> 'uniformClass') != ''") configclasses (configfile >> "CfgVehicles"));
		_maxArmorVest = 0;
		{
			_curArmor = ([getNumber(_x >> 'itemInfo' >> 'passThrough'),getNumber(_x >> 'itemInfo' >> 'armor')] call _factorArmor);
			{_curArmor = _curArmor + ([getNumber(_x >> 'passThrough'),getNumber(_x >> 'armor')] call _factorArmor)} forEach ("isClass _x" configclasses (_x >>  "ItemInfo" >> "HitpointsProtectionInfo"));
			if (_curArmor > _maxArmorVest) then
		{
				_maxArmorVest = _curArmor;
			};
		} forEach (("isclass _x && getnumber (_x >> 'scope') == 2 && getnumber (_x >> 'itemInfo' >> 'type') in [701]") configclasses (configfile >> "cfgweapons"));
		_maxArmorHeadgear = 0;
		{
			_curArmor = ([getNumber(_x >> 'itemInfo' >> 'passThrough'),getNumber(_x >> 'itemInfo' >> 'armor')] call _factorArmor);
			{_curArmor = _curArmor + ([getNumber(_x >> 'passThrough'),getNumber(_x >> 'armor')] call _factorArmor)} forEach ("isClass _x" configclasses (_x >>  "ItemInfo" >> "HitpointsProtectionInfo"));
			if (_curArmor > _maxArmorHeadgear) then
		{
				_maxArmorHeadgear = _curArmor;
			};
		} forEach (("isclass _x && getnumber (_x >> 'scope') == 2 && getnumber (_x >> 'itemInfo' >> 'type') in [605]") configclasses (configfile >> "cfgweapons"));
		missionNamespace setVariable ["vn_mf_MAX_ARMOR",[_maxArmorUniform,_maxArmorVest,_maxArmorHeadgear,(_maxArmorUniform + _maxArmorVest + _maxArmorHeadgear)]];

	};
	case "selectItem":
	{
		private ["_arr","_exit","_data","_name","_text","_pic"];
		_item params ["_control","_index"];
		if (_index isEqualType []) then
	{
			_index = (_index select 0) select 1;
		};
		_text = _control lbText _index;
		_data = _control lbData _index;
		_pic = _control lbPicture _index;
		_val = _control lbValue _index;
		if (_data == "") then
	{
			_container = switch (_extra) do
		{
				case 633: { uniformContainer player };
				case 638: { vestContainer player };
				case 632: { vn_mf_targetContainer };
				case 640: { vn_mf_secondaryContainer };
				default { backpackContainer player };
			};
			_weaponsAndItems = ((getWeaponCargo  _container) select 0);
			_weaponsAndItems append ((getItemCargo _container) select 0);
			_data = _weaponsAndItems param [_val,""];
		};
		uiNamespace setVariable ["vn_mf_interacted_item",[_text,_data,_pic,_val]];
	};
	case "init":
	{
		_item params ["_unit","_targetContainer","_secondaryContainer"];
		vn_mf_targetContainer = _targetContainer;
		vn_mf_secondaryContainer = objNull;
		if !(isNull _secondaryContainer) then
	{
			vn_mf_targetContainer = _secondaryContainer;
			vn_mf_secondaryContainer = _targetContainer;
		};

		waitUntil {(!isNull findDisplay 602)};
		if (!isNull findDisplay 602) then
	{
			disableSerialization;
			_display = findDisplay 602;

			// init custom sub menu handler
			{
				_container = _display displayCtrl _x;
				_container ctrlAddEventHandler ["LBDblClick",format["[_this,%1] call vn_mf_fnc_ui_sub_menu;",_x]];
			} forEach [619,633,638];
			// armor stats init
			{
				_remoteContainer = _display displayCtrl _x;
				_remoteContainer ctrlAddEventHandler ["LBDrag",format["['selectItem',_this,%1] call vn_mf_fnc_armor_calc;['refresh'] call vn_mf_fnc_armor_calc;",_x]];
				_remoteContainer ctrlAddEventHandler ["LBSelChanged",format["['selectItem',_this,%1] call vn_mf_fnc_armor_calc;['refresh'] call vn_mf_fnc_armor_calc;",_x]];
			} forEach [632,640];

			_color = [0.6,0.6,0.6,1];
			_colorCompare = [0.4,0.6,1,0.4];

			// UniformLoad
			_bar = _display ctrlCreate ["vn_mf_RscCustomProgress", 7304];
			uiNameSpace setVariable ["RscCustomProgressUniform", _bar];
			_bar ctrlSetTextColor _color;

			_existing_bar = _display displayCtrl 6304;
			_pos = ctrlPosition _existing_bar;
			_height = (_pos select 3) / 2;
			_existing_bar ctrlSetPosition [_pos select 0,(_pos select 1)+_height,_pos select 2,_height];
			_existing_bar ctrlCommit 0;
			_bar ctrlSetPosition [_pos select 0,_pos select 1,_pos select 2,_height];
			_bar ctrlCommit 0;

			// VestLoad
			_bar = _display ctrlCreate ["vn_mf_RscCustomProgress", 7305];
			uiNameSpace setVariable ["RscCustomProgressVest", _bar];
			_bar ctrlSetTextColor _color;

			_existing_bar = _display displayCtrl 6305;
			_pos = ctrlPosition _existing_bar;
			_height = (_pos select 3) / 2;
			_small_height = _height;
			_existing_bar ctrlSetPosition [_pos select 0,(_pos select 1)+_height,_pos select 2,_height];
			_existing_bar ctrlCommit 0;
			_bar ctrlSetPosition [_pos select 0,_pos select 1,_pos select 2,_height];
			_bar ctrlCommit 0;

			// SlotHeadgear
			_bar = _display ctrlCreate ["vn_mf_RscCustomProgress", 7240];
			uiNameSpace setVariable ["RscCustomProgressHeadgear", _bar];
			_bar ctrlSetTextColor _color;

			_existing_bar = _display displayCtrl 6240;
			_pos = ctrlPosition _existing_bar;
			_height = _pos select 3;

			_bar ctrlSetPosition [_pos select 0,(_pos select 1)+_height,_pos select 2,_small_height];
			_bar ctrlCommit 0;

			// TotalLoad;
			_existing_bar = _display displayCtrl 6308;
			_pos = ctrlPosition _existing_bar;
			_height = (_pos select 3) / 2;

			_existing_bar ctrlSetPosition [_pos select 0,(_pos select 1)+_height,_pos select 2,_height];
			_existing_bar ctrlCommit 0;

			// TotalLoad compare;
			_bar = _display ctrlCreate ["vn_mf_RscTotalArmorProgress", 7308];
			_bar ctrlSetTextColor _color;

			_bar ctrlSetPosition [_pos select 0,_pos select 1,_pos select 2,_height];
			_bar ctrlCommit 0;

			_bar_compare = _display ctrlCreate ["vn_mf_RscCustomProgress", 7309];
			_bar_compare ctrlSetTextColor _colorCompare;

			_bar_compare ctrlSetPosition [_pos select 0,_pos select 1,_pos select 2,_height];
			_bar_compare ctrlCommit 0;

			uiNameSpace setVariable ["RscCustomProgressTotal", [_bar,_bar_compare]];

			["refresh"] call vn_mf_fnc_armor_calc;
		};
	};
	case "refresh":
	{
		private ["_selectedClass","_newArmor","_totalArmor","_totalArmorMax","_selectedItem","_bar","_uniformArmor","_finalArmor","_vestArmor","_headgearArmor","_totalArmorUI","_bar_compare"];
		disableSerialization;
		if (!isNull findDisplay 602) then
	{
		  _selectedClass = "";
		  _interactedItem = uiNamespace getVariable ["vn_mf_interacted_item",[]];
		  if !(_interactedItem isEqualTo []) then
	  {
			  _selectedClass = _interactedItem select 1;
		  };
		  if (isNil "vn_mf_MAX_ARMOR") then
	  {
			  ["maxArmorInit"] call vn_mf_fnc_armor_calc;
		  };
		  _totalArmor = 0;
		  _totalArmorMax = vn_mf_MAX_ARMOR select 3;
		  _newArmor = 0;
		  _selectedItem =  getnumber (configFile >> "CfgWeapons" >> _selectedClass >> "ItemInfo" >> "type");
		  _bar = uiNameSpace getVariable "RscCustomProgressUniform";
		  _uniformArmor = ["uniform",(uniform player)] call vn_mf_fnc_armor_calc;
		  _totalArmor = _totalArmor + _uniformArmor;
		  _finalArmor = linearConversion [0,vn_mf_MAX_ARMOR select 0,_uniformArmor,0.01,1,true];
		  _bar progressSetPosition _finalArmor;
		  if (_selectedItem == 801) then
	  {
			  _newArmor = _newArmor + (["uniform",_selectedClass] call vn_mf_fnc_armor_calc);
		  }
	  else
	  {
			  _newArmor = _newArmor + _uniformArmor;
		  };
		  _bar = uiNameSpace getVariable "RscCustomProgressVest";
		  _vestArmor = ["gear",(vest player)] call vn_mf_fnc_armor_calc;
		  _totalArmor = _totalArmor + _vestArmor;
		  _finalArmor = linearConversion [0,vn_mf_MAX_ARMOR select 1,_vestArmor,0.01,1,true];
		  _bar progressSetPosition _finalArmor;
		  if (_selectedItem == 701) then
	  {
			  _newArmor = _newArmor + (["gear",_selectedClass] call vn_mf_fnc_armor_calc);
		  }
	  else
	  {
			  _newArmor = _newArmor + _vestArmor;
		  };
		  _bar = uiNameSpace getVariable "RscCustomProgressHeadgear";
		  _headgearArmor = ["gear",(headgear player)] call vn_mf_fnc_armor_calc;
		  _totalArmor = _totalArmor + _headgearArmor;
		  _finalArmor = linearConversion [0,vn_mf_MAX_ARMOR select 2,_headgearArmor,0.01,1,true];
		  _bar progressSetPosition _finalArmor;
		  if (_selectedItem == 605) then
	  {
			  _newArmor = _newArmor + (["gear",_selectedClass] call vn_mf_fnc_armor_calc);
		  }
	  else
	  {
			  _newArmor = _newArmor + _headgearArmor;
		  };
		  _totalArmorUI = uiNameSpace getVariable "RscCustomProgressTotal";
		  _bar = _totalArmorUI select 0;
		  _finalArmor = linearConversion [0,_totalArmorMax,_totalArmor,0.01,1,true];
		  _bar progressSetPosition _finalArmor;
		  _bar_compare = _totalArmorUI select 1;
		  _finalArmor = linearConversion [0,_totalArmorMax,_newArmor,0.01,1,true];
		  _bar_compare progressSetPosition _finalArmor;
		};
	};
};
_return
