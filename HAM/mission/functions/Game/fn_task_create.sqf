/*
	File: fn_task_create.sqf
	Author: Savage Game Design
	Public: No

	Description:
		Creates a task that's defined by the gamemode config.

	Parameter(s):
		_class - Current Task [String]
		_taskMarker - zone to create the task in [String]
		_parameters - Extra parameters passed to the task at runtime [Array, defaults to [] (empty array)]
		_taskgroupID - groupID that invoked the task [String, defaults to "NA"]
		_targetGroupIds - Teams to send task to, all groups if blank [Array, defaults to [] (empty array)]

	Returns:
		[taskClass, taskDataStore, scriptHandle] if task created [] if not [Array]

	Example(s):
		['task_1'] call vn_mf_fnc_task_create;
		['task_1'] call vn_mf_fnc_task_create;
		['task_1', 'zone_ba_ria', ['pos', [0,0,0]]] call vn_mf_fnc_task_create;
*/

params [
	"_class",			 	// 0: STRING - Current Task
	"_taskMarker",				// 1: zone to create the task in
	["_parameters", []],    // 2: Extra parameters passed to the task at runtime
	["_taskgroupID","NA"],	// 3: groupID that invoked the task
	["_targetGroupIds", []] // 4: Teams to send task to, all groups if blank
];

private _accepted_groups = (missionConfigFile >> "gamemode" >> "teams") call BIS_fnc_getCfgSubClasses; // ["MikeForce","SpikeTeam","ACAV","GreenHornets"]

private _taskConfig = (missionConfigFile >> "gamemode" >> "tasks" >> _class);
if (isClass _taskConfig) then
{
	private _taskname = getText (_taskConfig >> "taskname");
	private _taskformatdata = getText (_taskConfig >> "taskformatdata");
	private _taskdesc = getText (_taskConfig >> "taskdesc");
	private _taskgroups = getArray (_taskConfig >> "taskgroups");
	private _requestgroups = getArray (_taskConfig >> "requestgroups");
	private _tasktype = getText (_taskConfig >> "tasktype");
	//taskScript is expected to be code, that returns the code we actually want to run.
	private _taskScript = call compile getText (_taskConfig >> "taskScript");
	private _taskCategory = getText (_taskConfig >> "taskcategory");

	private _taskClass = configName _taskConfig;

	if !(_targetGroupIds isEqualTo []) then {
		_taskGroups = _taskGroups select {_x in _targetGroupIds};
	};

	private _targetGroups = [];
	private _grp = [];
	{
		_grp = missionNamespace getVariable [_x, []];
		if !(_grp isEqualTo []) then
		{
			_targetGroups pushBackUnique _grp;
		};
	} forEach _taskgroups;

	private _isAllowed = true;
	if !(_requestgroups isEqualTo []) then
	{
		_isAllowed = false;

		{
			if (_taskgroupID in _accepted_groups) exitWith {_isAllowed = true;};
		} forEach _requestgroups;
	};

	["_isAllowed %1 _targetGroups %2 taskClass %3 _taskgroupID %4 _requestgroups %5",_isAllowed,_targetGroups, _taskClass, _taskgroupID, _requestgroups] call BIS_fnc_logFormat;
	if (_isAllowed) exitWith
	{
		//Use the counter to make sure our task ID is unique.
		vn_mf_taskCounter = vn_mf_taskCounter + 1;
		private _taskFrameworkId = format ["%1-%2", vn_mf_taskCounter, _taskClass];
		//Copy task details into the datastore.
		private _taskDataStore = false call para_g_fnc_create_namespace;
		_taskDataStore setVariable ["taskId", _taskFrameworkId];
		_taskDataStore setVariable ["taskClass", _taskClass];
		_taskDataStore setVariable ["taskRequestedBy", _taskGroupId];
		_taskDataStore setVariable ["taskConfig", _taskConfig];
		_taskDataStore setVariable ["taskSubtasks", []];
		_taskDataStore setVariable ["taskGroups", _taskGroups];
		_taskDataStore setVariable ["taskMarker", _taskMarker];
		_taskDataStore setVariable ["taskCategory", _taskCategory];
		_taskDataStore setVariable ["taskType", _taskType];

		//Load the additional parameters into the task data store.
		{
			//Do a validity check on each parameter. We can do away with this if it's a performance issue.
			if (_x isEqualType [] && {count _x == 2} && {(_x select 0) isEqualType ""}) then {
				_taskDataStore setVariable [_x select 0, _x select 1];
			} else {
				["Invalid format passed to task_create for %1", _taskClass] call BIS_fnc_logFormat;
			};
		} forEach _parameters;

		//Format the name, allowing it to use anything from the task data store.
		//We need to do it this way, as concatenating arrays has issues when the format string returns nil/
		private _formatData = _taskDataStore call compile _taskformatdata;
		private _nameFormatParams = [_taskName];
		_nameFormatParams append _formatData;
		private _formattedTaskName = format _nameFormatParams;

		private _descFormatParams = [_taskDesc];
		_descFormatParams append _formatData;
		private _formattedTaskDesc = format _descFormatParams;


		//Arrays are a terrible way to store data. They're brittle, and difficult to change.
		//That's why anything that isn't these should go in the taskDataStore.
		//So I repeat - DO NOT ADD THINGS TO THIS ARRAY. Add them to the data store instead.
		private _taskEntry = [_taskFrameworkId, _taskDataStore];
		vn_mf_tasks pushBack _taskEntry;

		//Send our task data to the client before we call a BIS task function, to make sure it's there for the client.
		call vn_mf_fnc_task_update_clients;
		[true, _taskFrameworkId, [_formattedTaskDesc,_formattedTaskName,_taskmarker], objNull, "CREATED", 100, false, _tasktype, true] call BIS_fnc_taskCreate;

		[_taskFrameworkId, _taskScript, [_taskDataStore], 5] call para_g_fnc_scheduler_add_job;
		["taskCreated", _taskDataStore] call para_g_fnc_event_dispatch;
		[_taskFrameworkId] remoteExecCall ["vn_mf_fnc_task_client_on_task_created", 0];

		//Explicitly inform players if there's a new support task for their team
		{
			if (_taskCategory == "SUP") then {
				["NewSupportRequest", ["", _formattedTaskName]] remoteExec ["para_c_fnc_show_notification", _x];
			};
		} forEach _targetGroups;

		_taskEntry
	};
	[]
};
