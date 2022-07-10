/*
    File: fn_consume.sqf
    Author: Savage Game Design
    Public: No

    Description:
	Food and drink player handler.

    Parameter(s): none

    Returns: nothing

    Example(s):
	call vn_mf_fnc_consume;
*/
private _item = "";
private _interacted_item = uiNamespace getVariable ["vn_mf_interacted_item",[]];
if !(_interacted_item isEqualTo []) then
{
	_item = _interacted_item select 1;
};

private _water = 0;
private _food = 0;
private _consume = 1;
private _removeonempty = 1;

private _item_config = (missionConfigFile >> "CfgItemInteractions" >> _item);
if (isClass _item_config) then
{
	_consume = getNumber(_item_config >> "consume");
	_water = getNumber(_item_config >> "water");
	_food = getNumber(_item_config >> "food");
	_cures = count getArray(_item_config >> "cures");
	_removeonempty = getNumber(_item_config >> "removeonempty");

	// only consume item if consume var is greater than 0
	if (_consume > 0) then
	{
		private _mag_size_max = getNumber (configfile >> "CfgMagazines" >> _item >> "count");
		// allow all magazines with greater than 1 bullet
		if (_mag_size_max > _consume) then
		{
			private _mag_size = 0;
			private _mag_count = 0;
			private _all_mags = (magazinesAmmoCargo uniformContainer player + magazinesAmmoCargo vestContainer player + magazinesAmmoCargo backpackContainer player);
			{
				if (_item isEqualTo (_x select 0)) then
				{

					_mag_size = _mag_size + (_x select 1);
					_mag_count = _mag_count + 1;
				};
			} forEach _all_mags;

			// remove all
			player removeMagazines _item;


			// calculate final buff given based on available count
			_water = linearConversion [0, _consume, _mag_size, 0, _water, true];
			_food = linearConversion [0, _consume, _mag_size, 0, _food, true];

			if (_water == 0 && _food == 0 && _cures == 0) then {
				{["EmptyFoodItem"] call para_c_fnc_show_notification} remoteExecCall ["call",player];
			};

			_mag_size = _mag_size - _consume;

			_added_mag_count = 0;

			if (_mag_size > 0) then
			{
				// Add full magazines back to player
				for "_i" from 1 to floor (_mag_size / _mag_size_max) do
				{
					player addMagazine [_item, _mag_size_max];
					_added_mag_count = _added_mag_count + 1;
				};
				// Add last non full magazine
				if ((_mag_size % _mag_size_max) > 0) then
				{
					player addMagazine [_item, floor (_mag_size % _mag_size_max)];
					_added_mag_count = _added_mag_count + 1;
				};
			};
			// add back empty items
			if (_removeonempty isEqualTo 0) then
			{
				for "_i" from 1 to floor (_mag_count - _added_mag_count) do
				{
					player addMagazine [_item, 0];
				};
			};
		} else {
			// remove whole item
			player removeMagazine _item;
		};
	};

	// change stats related to ammount of item consumed
	["eatdrink", [_water,_food,_item]] call para_c_fnc_call_on_server;

}
else
{
	["attempt to consume item not in configs: %1", _item] call BIS_fnc_logFormat;
};
