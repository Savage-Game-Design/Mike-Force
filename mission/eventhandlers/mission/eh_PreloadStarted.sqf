/*
    File: eh_PreloadStarted.sqf
    Author: Savage Game Design
    Public: No

    Description:
	    Preload started event handler with self destruct.

    Parameter(s): none

    Returns: nothing

    Example(s):
	    Not called directly.
*/

// self destruct EH
removeMissionEventHandler ["PreloadStarted",_thisEventHandler ];
