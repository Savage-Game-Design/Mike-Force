/*
	File: fn_create_camp_buildings.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Creates a 'camp' environment at the given position.
	
	Parameter(s):
		_position - Position of the camp [Position3D]
	
	Returns:
		Array containing the camp building [Array]
	
	Example(s): none
*/

params ["_position"];

private _campfire = createVehicle ["vn_campfire_burning_f", _position, [], 5, "NONE"];
private _tent =	createVehicle ["Land_vn_o_shelter_06", _campfire getPos [5, random 360], [], 0, "NONE"];

[_campfire, _tent]