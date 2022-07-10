/*
    File: fn_scour_actions.sqf
    Author: Savage Game Design
    Public: No

    Description:
	    Perform the manual scout action to supplement automatic marker discovery system

    Parameter(s):
        // junk and don't matter.

    Returns: nothing

    Example(s):
	    ["",true] call vn_mf_fnc_earplugs;
*/

params
[
	"_status" 		// 0 : BOOLEAN - status of earplugs
];

private _playerRef = player; 

// Prevent action being taken if it was used recently

private _lastScout = localNamespace getVariable ["vn_mf_last_scout_time", -1]; 

if (time - _lastScout < vn_mf_g_sites_scout_action_cooldown) exitWith {
    false;
};

localNamespace setVariable ["vn_mf_last_scout_time", time]; 

// Initialise scouting action and setup the draw3D handler

vn_mf_scout_icons_to_draw = [];

if (isNil "vn_mf_scout_draw_handler") then {
    vn_mf_scout_max_distance = 2000;
    vn_mf_scout_fade_time = 10;
    vn_mf_scout_draw_handler = addMissionEventHandler ["Draw3D", {
        private _lastScoutTime = localNamespace getVariable "vn_mf_last_scout_time";
        //if (_lastScoutTime + vn_mf_scout_fade_time < time) exitWith {};
        {
            private _originalOpacity = _x # 14;
            private _opacity = linearConversion [_lastScoutTime, _lastScoutTime + vn_mf_scout_fade_time, time, _originalOpacity, 0, true];
            _x # 1 set [3, _opacity];
            drawIcon3D (_x select [0, 13]);
        } forEach vn_mf_scout_icons_to_draw;
    }];
};

// Find all nearby sites

private _nearbySites = missionNamespace getVariable ["sites",[]] inAreaArray [getPos _playerRef, vn_mf_scout_max_distance, vn_mf_scout_max_distance, 0, false]; 
private _undiscoveredSites = _nearbySites select {!(_x getVariable ["discovered", false])};

private _closestSite = objNull; 
private _distance_to_closest = 10000000000; 
 
{ 
    private _siteRef = _x; 
    private _distance = _playerRef distance2d (getPos _x); // getVariable "_sitePos" 
    if (_distance < _distance_to_closest) then { 
        _closestSite = _x; 
        _distance_to_closest = _distance; 
    }; 
} forEach _undiscoveredSites; 

private _distanceTexts = [
    [100, "Less than 100m"],
    [200, "~150m"],
    [500, "~300m"],
    [1000, "~750m"],
    [2000, "~1500m"],
    [99999999999999, "Too far"]
];

private _fnc_siteToDrawableIcon = {
    private _distance = getPos _this distance2D _playerRef;
    private _isDiscovered = _this getVariable ["discovered", false];
    private _text = if (_isDiscovered) then { toUpper (_this getVariable ["site_type", ""]) } else { "???" };
    // Full opacity up to X metres, then starts reducing linearly.
    private _opacity = 1 - ((_distance - 200 max 0) / vn_mf_scout_max_distance);
    private _distanceText = _distanceTexts select (_distanceTexts findIf {_x # 0 >= _distance}) select 1;

    [
        getMissionPath "img\vn_ico_mf_binoculars_ca.paa", // Texture
        [1, 1, 1, _opacity], // Color
        getPos _this vectorAdd [random (_distance * 0.1), random (_distance * 0.1), 0], // Position AGL
        1, // Width
        1, // Height
        0, // Angle
        format ["%1 %2", _text, _distanceText], //Text Content
        1, // Shadow/Outline
        0.05, // Text size
        "tt2020base_vn", // Font 
        "center", // Text Alignment
        false, // Show when off screen 
        0, // Text offset X 
        -0, // Text offset Y
        _opacity // Original opacity, used for fading
    ]
};

if (player getUnitTrait "scout_multiple") then {
    vn_mf_scout_icons_to_draw = _nearbySites apply {_x call _fnc_siteToDrawableIcon};
} else {
    if !(isNull _closestSite) then {
        vn_mf_scout_icons_to_draw = [_closestSite call _fnc_siteToDrawableIcon];
    };
};

/*

private _directionTo = player getDir _closestSite; 

if (_distance_to_closest < 100) then { 
    [
        [
            "Scouting Result", 
            format ["Within 100m of enemy site, bearing %1", _directionTo toFixed 0]
        ]
    ] call para_c_fnc_postNotification;
}; 

if (_distance_to_closest >= 100 && _distance_to_closest < 200) then { 
    [
        [
            "Scouting Result", 
            format ["Enemy site at bearing %1, approximately 150m.", _directionTo toFixed 0]
        ]
    ] call para_c_fnc_postNotification;
}; 

if (_distance_to_closest >= 200 && _distance_to_closest < 500) then { 
    [["Scouting Result", format ["Enemy site at bearing %1, approximately 300m.", _directionTo toFixed 0]]] call para_c_fnc_postNotification;
}; 
if (_distance_to_closest >= 500 && _distance_to_closest < 1000) then { 
    [["Scouting Result", format ["Enemy site at bearing %1, approximately 750m.", _directionTo toFixed 0]]] call para_c_fnc_postNotification;
}; 
if (_distance_to_closest >= 1000 && _distance_to_closest < 2000) then { 
    [["Scouting Result", format ["Enemy site at bearing %1, approximately 1500m.", _directionTo toFixed 0]]] call para_c_fnc_postNotification;
}; 
if (_distance_to_closest >= 2000) then { 
    [["Scouting Result", format ["Enemy site at bearing %1, several km away.", _directionTo toFixed 0]]] call para_c_fnc_postNotification;
}; 

*/

true



