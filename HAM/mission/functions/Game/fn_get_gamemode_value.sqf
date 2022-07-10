/*
	File: fn_get_gamemode_value.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Returns value for specified key based on gamemode config.

	Parameter(s):
		_Cfg - name of config sub class in gamemode [String]
		_key - Name of select variable [String]
		_default - Default value [Number|String|Array|Boolean]

	Returns:
		value for specified key based on gamemode config [Number|String|Array|Boolean]

	Example(s):
		["difficulty", "aiskill", 0.1] call para_g_fnc_get_gamemode_value;
*/

params [
	"_cfg", // 0: STRING - name of config sub class in gamemode
	"_key", // 1: STRING - name of select variable
	"_default" // 2: NUMBER, STRING, ARRAY, BOOL - default value
];
private _config = configNull;

if (_cfg isEqualType configNull) then
{
	_config = _cfg;
}
else
{
	_config = (missionConfigFile >> "gamemode" >> _cfg);
};


if (!isClass _config) exitWith
{
	"DEBUG: Class not found" call BIS_fnc_log;
	_default
};

// get value for selected difficulty
if (_cfg isEqualTo "difficulty") then
{
	_config = _config >> getText(_config >> "setting");
};

// select key name
_config = (_config >> _key);

private _data = switch (typeName _default) do {
	case "SCALAR":
	{
		if (isNumber (_config)) then
		{
			getNumber _config
		}
		else
		{
			_default
		}
	};
	case "BOOL":
	{
		if (isText (_config)) then
		{
			(getText _config) isEqualTo "true"
		}
		else
		{
			if (isNumber (_config)) then
			{
				(getNumber _config) isEqualTo 1
			}
			else
			{
				_default
			}
		}
	};
	case "ARRAY":
	{
		if (isArray (_config)) then
		{
			getArray _config
		}
		else
		{
			_default
		}
	};
	case "STRING":
	{
		if (isText (_config)) then
		{
			getText _config
		}
		else
		{
			_default
		}
	};
	default
	{
		_default
	};
};
_data
