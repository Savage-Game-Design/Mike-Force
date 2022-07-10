/*
	File: fn_group_init.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Creates and initialize groups and duty officers
	
	Parameter(s): none
	
	Returns: nothing
	
	Example(s):
		call vn_mf_fnc_group_init;
*/

vn_mf_duty_officers = [];
vn_mf_groups = [];

// Create all groups agents and join into all groups
private _groups = "true" configClasses (_gamemode_config >> "teams" );
{
	private _config = _x;
	private _groupName = configName _x;
	private _class = getText(_config >> "unit");
	private _marker = "duty_officer_" + tolower(_groupName);
	private _location = getMarkerPos _marker;
	private _direction = markerDir _marker;
	if !(_location isEqualTo [0,0,0]) then
	{
		// duty officer agent
		private _agent = createAgent [_class, _location, [], 0, "NONE"];
		_agent allowDamage false;
		_agent setDir _direction;

		_id = _agent spawn {
			removeAllWeapons _this;
			_this switchmove "";
			uiSleep 1;
			_this enableSimulationGlobal false;
			_this disableAI "ALL";
			_this setCaptive true;
		};
		
		//Set up custom interaction overlay
		_agent setVariable ["#para_InteractionOverlay_ConfigClass", "DutyOfficer", true];

		// set group name as global var and reference to group server side
		missionNamespace setVariable [_groupName, []]; //initialize group array
		publicVariable _groupName;

		// save duty officers to array for later use
		vn_mf_duty_officers pushBack _agent;

		//create a list of active groups(replacement for allGroups)
		vn_mf_groups pushBack _groupName;
	};
} forEach _groups;

// broadcast duty officers
publicVariable "vn_mf_duty_officers";


