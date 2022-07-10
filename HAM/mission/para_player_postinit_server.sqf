/*
	File: para_player_postinit_server.sqf
	Author: Savage Game Design
	Public: No
	
	Description:
		Called on the server after init_client has run on the client.
		It is safe to access the player object in this function.
		Used to finalise the player after initialisation.

		Load order:
			- para_player_preload_client.sqf - Called as soon as possible on the client.
			- para_player_loaded_client.sqf - Called on client as soon as the player is ready
			- para_player_init_server.sqf - Serverside player initialisation.
			- para_player_init_client.sqf - Clientside player initialisation.
			- para_player_postinit_server.sqf - Called on server once all player initialisation is done.
	
	Parameter(s):
		_player - Player being initialised [OBJECT]
		_didJIP - Whether the player JIP'd
	
	Returns:
		None
	
	Example(s):
		None
*/

params ["_player", "_didJIP"];

diag_log format ["Mike Force: Player postinit server - %1", _player];
