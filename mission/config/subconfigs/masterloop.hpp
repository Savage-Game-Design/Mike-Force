//
class init
{
	file = "functions\core\masterloop\init.sqf";
};
class events
{
	condition = "alive player";
	file = "functions\core\masterloop";
	class debug_monitor
	{
		delay = 1;
	};
	class fps_tracker
	{
		delay = 5;
	};
	class critical_stats
	{
		delay = 2;
	};
	class once_a_minute
	{
		delay = 60;
	};
};
