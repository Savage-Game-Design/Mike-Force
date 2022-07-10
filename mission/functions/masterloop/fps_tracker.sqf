/*
    File: fps_tracker.sqf
    Author: Savage Game Design
    Public: No

    Description:
	Set fps on player locally on server.

    Parameter(s): none

    Returns: nothing

    Example(s):
	Not called directly.
*/

["setfps", diag_fps] call para_c_fnc_call_on_server;
