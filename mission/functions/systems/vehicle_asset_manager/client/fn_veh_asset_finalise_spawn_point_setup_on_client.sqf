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

// not a player, shouldn't be executing this (will never see wheel menu)
if (!hasInterface) exitWith {
    nil;
};

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

/*
===============================================================================
Need to limit the number categories in the wheel menu, taking into account
persistent wheel menu entries configured in `configs\wheel_menu_actions.hpp`.
===============================================================================
*/

// may be resized, so deep copy
private _categories = +(_spawnPoint get "settings" get "categories");

// entries shown due to conditions when accessing *object* wheel menu
private _target = _spawnPoint get 'object';
private _objActions = para_c_wheel_menu_actions_always
    select {(call (_x get "condition") isEqualType true)}
    select {call (_x get "condition")}
    ;

// entries shown due to conditions when accessing *player* wheel menu
private _target = player;
private _playerActions = para_c_wheel_menu_actions_always
    select {(call (_x get "condition") isEqualType true)}
    select {call (_x get "condition")}
    ;

private _categoryLimit = 10 - (count _objActions) - (count _playerActions);

if ((count _categories) > _categoryLimit) then {

    diag_log format [
        "WARN: %1: Too many categories configured (%2), only loading first %3 categories: spawnClass='%4' spawnPos=%5",
        _fnc_scriptName,
        count _categories,
        _categoryLimit,
        _spawnPoint get 'settings' get 'name',
        _spawnPoint get 'spawnLocation' get 'pos'
    ];

    _categories resize _categoryLimit;
};


/*
===============================================================================
Create wheel menu.

Also limit number of vehicles in sub menus to a maximum of 9 entries.
(wheel menu max 10, plus need a 'back to categories' entry.
===============================================================================
*/

_categories apply {

    private _category = _x;
    // may be resized, so deep copy
    private _vehs = +(_category get "vehicles");
    // require one free wheel menu entry for the back button.
    if (count _vehs > 9) then {

        diag_log format [
            "WARN: %1: Too many vehicles in category (%2), only loading first %3 vehicles: spawnClass='%4' spawnPos=%5",
            _fnc_scriptName,
            count _vehs,
            9,
            _spawnPoint get 'settings' get 'name',
            _spawnPoint get 'spawnLocation' get 'pos'
        ];

        _vehs resize 9;
    };

    private _subMenuActions = _vehs apply {
        createHashMapFromArray [
            ["text", getText (configFile >> "CfgVehicles" >> (_x get "classname") >> "displayName")],
            // vehicles don't have icon data, so make do with the category icon instead
            ["iconPath", _category get "icon"],
            ["functionArguments", [_spawnPoint get "id", _x get "classname"]],
            ["function", "vn_mf_fnc_veh_asset_request_vehicle_change_client"]
        ]
    };

    private _categoryAction = createHashMapFromArray [
        ["text", (_category get "name") call para_c_fnc_localize],
        ["iconPath", _category get "icon"],
        ["submenuActions", _submenuActions]
    ];

    [_spawnPoint get "object", _categoryAction] call para_c_fnc_wheel_menu_add_obj_action;
};

//TODO Setup "return vehicle to spawn" action as zeus
// DJ note -- i've previously done something with this via an addAction.
// Return to spawn only makes sense for wrecks as a way to skip wreck packaging.
// (zeus can just delete abandoned respawn configured vehicles).

// ----------------------
// Interaction overlay
// ----------------------
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
