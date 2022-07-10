/*
    File: eh_TaskSetAsCurrent.sqf
    Author: Savage Game Design
    Public: No
    
    Description:
        Fired on the client when 'TaskSetAsCurrent' event fires.
    
    Parameter(s):
    	_unit - The player to whom the event handler is assigned [Object]
    	_task - The new current task [Task]
    
    Returns: nothing
    
    Example(s): none
*/

params ["_unit", "_task"];

if (!isNull _task) then {
	_unit setVariable ["lastTask", _task];
};
