/*
    File: fn_tr_getMapPosClick.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
		Alled by "MouseButtonClick" Map-Eventhandler in the SupportRequest Page
		Creates local Marker, if needed, and moves it to clicked Maplocation
		Name is probably a bit missleading, but noone should use that stuff anyway and i am too lazy/can't be bothered to change it atm ¯\_(ツ)_/¯
    
    Parameter(s):
		_0 - Control [Control]
		_ - Not used [Any]
		_2 - X Position on Screen [Number]
		_3 - Y Position on Screen [Number]
    
    Returns: nothing
    
    Example(s): none
*/

disableSerialization;

_worldCoord = (_this#0) ctrlMapScreenToWorld [(_this#2), (_this#3)];
_markerName = format["%1_missionMarker",getPlayerUID player];

if(isNil _markerName)then
{
	
	_marker = createMarkerLocal [_markerName, _worldCoord];
	_marker setMarkerShapeLocal "ELLIPSE";
	_marker setMarkerColorLocal "ColorBlack";
	_marker setMarkerSizeLocal [10, 10];
	_marker setMarkerAlphaLocal 1;
};
_markerName setMarkerPosLocal _worldCoord;
