/*
    File: fn_sites_check_standard_site_completed.sqf
    Author: @dijksterhuis
    Public: Yes
    
    Description:

        Standardised check for whether a site should be considered completed or not.

        'Standardised' here basically means typical Mike Force sites where players need
        to clear/destroy/spike certain objects to complete that site and progress.

        The check also covers the cases where
            * some 'arma' has happened, yeeting the object far away from the site
            * a player has picked up a site object and walked away from the site
            * a player has loaded a site object as vehicle cargo

    Parameter(s):

        * _objectsToCheck           -- [ARRAY]: the objects in the site whose presence
                                       needs to be checked
        * _centrepointObjectOrPos   -- [OBJECT/POSITION]: centrepoint for the area search.
                                       either an object (usually the _siteStore simple
                                       object), or a position array
        * _checkRadius              -- [NUMBER]: how far away from the site do we need to
                                       check for the objects before considering them
                                       "gone".
        * _checkIsRectangle         -- [BOOL]: whether the search area is an ellipse
                                       (default) or rectangular
    
    Returns:

        true if site is completed, false otherwise
    
    Example(s):

        // circular area search using _storeStore object as centre
        [
            _siteStore getVariable ["aaGuns", []],
            _siteStore,
            20
        ] call vn_mf_fnc_sites_check_standard_site_completed;

        // circular area search using some other position as centre
        [
            _siteStore getVariable ["staticMgs", []],
            [0, 0, 0],
            10,
            false
        ] call vn_mf_fnc_sites_check_standard_site_completed;

        // rectangular area search
        [
            _siteStore getVariable ["mortars", []],
            _siteStore,
            5,
            true
        ] call vn_mf_fnc_sites_check_standard_site_completed;

*/

params [
	"_objectsToCheck",
	"_centrepointObjectOrPos",
	"_checkRadius",
	["_checkIsRectangle", false]
];

private _objectsInArea = _objectsToCheck inAreaArray [
	_centrepointObjectOrPos,
	_checkRadius,
	_checkRadius,
	0,
	false
];

_objectsInArea findIf {alive _x} == -1
