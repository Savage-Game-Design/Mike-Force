/*
    File: fn_init_performance_logging.sqf
    Author: Savage Game Design
    Public: No

    Description:
		Starts regular performance logging.

    Parameter(s): None

    Returns: Nothing

    Example(s):
		call vn_mf_fnc_init_performance_logging
*/

para_g_log_identifier = "MIKEFORCE";

private _performanceLoggingPeriod = localNamespace getVariable ["vn_mf_performance_logging_period", 30];

["performance_logging", vn_mf_fnc_log_performance_data, [], _performanceLoggingPeriod] call para_g_fnc_scheduler_add_job;
