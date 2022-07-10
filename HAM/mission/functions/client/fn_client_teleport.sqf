/*
    File: fn_client_teleport.sqf
    Author: Savage Game Design
    Public: No

    Description:
	    Execute teleport remote exec.

    Parameter(s):
        _teleporterName - Name of the source teleporter
        _destination - Name of the destination

    Returns: nothing

    Example(s):
        [_teleporter, _dest] call vn_mf_fnc_client_teleport
*/

['teleport',_this] call para_c_fnc_call_on_server;
