/*
    File: fn_veh_asset_finalise_spawn_point_setup_on_client.sqf
    Author: Spoffy
    Date: 2023-05-26
    Last Update: 2023-05-26
    Public: No
    
    Description:
        Sets up the client side of a spawn point.

        The spawn point data object should already exist, and have all relevant variables set on it.
    
    Parameter(s):
        _spawnPoint - Spawnpoint to finalise setup for [HashMap]

    Returns:
        Nothing
    
    Example(s):
        ["32"] call vn_mf_fnc_veh_asset_finalise_spawn_point_setup_on_client;
*/

params ["_spawnPoint"];

//============
// Validation 
//============

if (isNil "_spawnPoint") exitWith {
    ["ERROR", "Attempted to finalise a non-existent spawn point"] call para_g_fnc_log;
};

private _requiredVariables = [
    'settings'
];

private _missingVariables = _requiredVariables select {!(_x in _spawnPoint)} apply {
    ["ERROR", format ["Missing variable when finalising spawn point %1", _x]] call para_g_fnc_log;
    _x
};

if (count _missingVariables > 0) exitWith {};

//========
// Logic
//========

//TODO Setup change vehicle actions
/*
{


} forEach (_spawnPoint get "settings" getOrDefault ['vehicles', []]);
*/

//TODO Setup "return vehicle to spawn" action as zeus

//TODO Setup interaction overlay
private _name = _spawnPoint get 'settings' get 'name';
private _vehicles = _spawnPoint get 'settings' get 'vehicles';
if (_name isEqualTo '' && _vehicles isNotEqualTo []) then {
    private _editorSubcategory = (getText (configFile >> 'CfgVehicles' >> (_vehicles # 0) >> 'editorSubcategory'));
    _name = getText (configFile >> 'CfgEditorSubcategories' >> _editorSubcategory >> 'displayName');
};


_spawnPoint get 'object' setVariable ["#para_InteractionOverlay_Data", [
    _name call para_c_fnc_localize, 
    "", 
    "%1",
    {[
        [_this getVariable "veh_asset_spawnPointId"] call vn_mf_fnc_veh_asset_describe_status
    ]}, 
    true
]];
