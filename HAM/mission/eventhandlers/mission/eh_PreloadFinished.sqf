/*
    File: eh_PreloadFinished.sqf
    Author: Savage Game Design
    Public: No

    Description:
	    Preload finished event handler with self destruct.

    Parameter(s): none

    Returns: nothing

    Example(s):
	    Not called directly.
*/

// self destruct EH
removeMissionEventHandler ["PreloadFinished",_thisEventHandler ];
