/*
    File: fn_arsenal_trash_cleanup_init.sqf
    Author: Savage Game Design
    Public: Yes

    Description:
        Called to remove ground weapon holders in the area of the arsenal.

    Parameter(s):
        None

    Returns:
        None

    Example(s):
        [_target] call vn_mf_fnc_arsenal_trash_cleanup;
*/

params ["_target"];

private _objects = _target nearObjects ["GroundWeaponHolder",20];
{
	deleteVehicle _x;
} forEach _objects;