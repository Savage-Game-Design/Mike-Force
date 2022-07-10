/*
    File: fn_setlocaleh.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Local object cleanup.
		[!:warning] The `_player` variable is passsed from the parent scope!
    
    Parameter(s):
		_objects - [_object] array of objects [Array, defaults to [] (empty array)]
			_object - Object [Object]
    
    Returns: nothing
    
    Example(s):
		[_object] call vn_mf_fnc_setlocaleh (server)
			or
		["setlocaleh", [[_object]]] call para_c_fnc_call_on_server;
*/

params
[
	["_objects",[],[[]]]	// 0 : ARRAY of Objects
];
{
	if (!isNull _x) then {
		// adds event handler to objects
		_x addEventHandler ["Local", {
	        	params ["_entity", "_isLocal"];
        		if (_isLocal && {!isNull _entity}) then
			{
        			deleteVehicle _entity;
				"removed temp object" call BIS_fnc_log;
        		};
	        }];
	};
} forEach _objects;
