/*
cfgRemoteExec -- https://community.bistudio.com/wiki/Arma_3:_CfgRemoteExec
-------------------------------------------------------------------------------

this file can be used to stops arbitary remote execution, enabling only a
specified whitelist of functions and commands.

the functions and commands listed in this file are those required by vanilla
mike force to function. you may need to edit this file if you have customised
the mission yourself, or have additional client-side mods permitted that
perform client->server remote execution.
*/

// client -> server remote execution is completely blocked.
// this will break mike force!
#define MODE_REXEC_BLOCKED mode = 0
// client -> server remote execution is blocked, except for the functions/commands
// specified in this config, which are required for Mike Force to run.
#define MODE_REXEC_WHITELIST mode = 1
// client -> server remote execution is allowed for all functions/commands.
// this is the default option for backwards compatability.
#define MODE_REXEC_ALLOWED mode = 2

// JIP flag can not be set when calling remoteExec
#define DISABLE_JIP jip = 0
// JIP flag can be set when calling remoteExec (default)
#define ENABLE_JIP jip = 1

// Sender can only target the server, execution on clients is denied
#define ALLOW_SERVER allowedTargets = 2
// Sender can only target clients, execution on the server is denied
#define ALLOW_CLIENTS allowedTargets = 1
// Sender can target all machines (default)
#define ALLOW_ALL allowedTargets = 0


class CfgRemoteExec {

	class Commands
	{
		// change this to MODE_REXEC_WHITELIST to enable the CfgRemoteExec whitelist
		MODE_REXEC_ALLOWED;
		ENABLE_JIP;

		// needed during player init process to silence radio messages from
		// player's character
		class setSpeaker {
			ALLOW_SERVER;
			DISABLE_JIP;
		};
	};
	
	class Functions
	{
		// change this to MODE_REXEC_WHITELIST to enable the CfgRemoteExec whitelist
		MODE_REXEC_ALLOWED;
		ENABLE_JIP;

		// fundamental to Arma3 -- do not disable
		class BIS_fnc_effectKilledAirDestruction {
			ALLOW_SERVER;
			DISABLE_JIP;
		};

		class BIS_fnc_effectKilledSecondaries {
			ALLOW_SERVER;
			DISABLE_JIP;
		};

		class BIS_fnc_fire {
			ALLOW_SERVER;
			DISABLE_JIP;
		};

		class BIS_fnc_objectVar {
			ALLOW_SERVER;
			DISABLE_JIP;
		};

		class BIS_fnc_setCustomSoundController {
			ALLOW_SERVER;
			DISABLE_JIP;
		};

		// allow admin debug console access
		// https://community.bistudio.com/wiki/Arma_3:_CfgRemoteExec#Notes
		class BIS_fnc_debugConsoleExec {
			ALLOW_SERVER;
			DISABLE_JIP;
		};

		// required by task system initialisiation on players
		class bis_fnc_settasklocal {
			ALLOW_SERVER;
			ENABLE_JIP;
		};

		class bis_fnc_sharedobjectives {
			ALLOW_SERVER;
			ENABLE_JIP;
		};

		// MIKE FORCE SPECIFIC

		// paradigm client initialisiation
		class para_s_fnc_init_player {
			ALLOW_SERVER;
			DISABLE_JIP;
		};
		class para_s_fnc_postinit_player {
			ALLOW_SERVER;
			DISABLE_JIP;
		};

		// paradigm utils

		class para_s_fnc_rehandler {
			ALLOW_SERVER;
			ENABLE_JIP;
		};
		// needed when para_c_fnc_show_notification is called with global target
		class para_c_fnc_show_notification {
			ALLOW_SERVER;
			DISABLE_JIP;
		};

		// rehandler functions

		class vn_mf_fnc_arsenal_trash_cleanup {
			ALLOW_SERVER;
			DISABLE_JIP;
		};
		class vn_mf_fnc_changeteam {
			ALLOW_SERVER;
			DISABLE_JIP;
		};
		class vn_mf_fnc_eatdrink {
			ALLOW_SERVER;
			DISABLE_JIP;
		};
		class vn_mf_fnc_packageforslingloading {
			ALLOW_SERVER;
			DISABLE_JIP;
		};
		class vn_mf_fnc_settrait {
			ALLOW_SERVER;
			DISABLE_JIP;
		};
		class vn_mf_fnc_supplyrequest {
			ALLOW_SERVER;
			DISABLE_JIP;
		};
		class vn_mf_fnc_supporttaskcreate {
			ALLOW_SERVER;
			DISABLE_JIP;
		};
		class vn_mf_fnc_teleport {
			ALLOW_SERVER;
			DISABLE_JIP;
		};

		// change vehicles at a vehicle spawner
		class vn_mf_fnc_veh_asset_handle_change_vehicle_request {
			ALLOW_SERVER;
			DISABLE_JIP;
		};

		/*
		uncomment the lines below to enable zeus functionality.

		WARNING: this is a dangerous option to enable!

		it enables the `bis_fnc_call` function in the whitelist,
		enabling any arbitary remote code execution on the server from clients,
		like this:

		[{allPlayers apply {_x setDamage 1}}] remoteExec ["bs_fnc_call", 2];
		*/

		// class bis_fnc_call {
		// 	ALLOW_SERVER;
		// 	ENABLE_JIP;
		// };

	};

};