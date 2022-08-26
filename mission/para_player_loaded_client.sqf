/*
	File: para_player_loaded_client.sqf
	Author: Savage Game Design
	Public: Yes
	
	Description:
		Called on the client once the player has finished loading into the game.
		Only called once the player is ready to be initialised.
		It is safe to access the player object in this function.
		Do things such as setting up loading screens here.

		Note: The server may *not* have finished initialising at this point.
		Don't do anything on the server yet.

		Load order:
			- para_player_preload_client.sqf - Called as soon as possible on the client.
			- para_player_loaded_client.sqf - Called on client as soon as the player is ready
			- para_player_init_server.sqf - Serverside player initialisation.
			- para_player_init_client.sqf - Clientside player initialisation.
			- para_player_postinit_server.sqf - Called on server once all player initialisation is done.
	
	Parameter(s):
		_player - Player that joined [OBJECT]
		_didJIP - Whether the player is JIPing [BOOLEAN]

	
	Returns:
		None
	
	Example(s):
		//In description.ext
		use_paradigm_init = 1;
*/

params ["_player", "_didJIP"];

//Voice fixes. Run in combination with setSPeaker on the server.
private _fnc_disableChatter = {
	player disableConversation true;
	[player, "NoVoice"] remoteExec ["setSpeaker", 0];
	{ _x disableAI "RADIOPROTOCOL"; _x setSpeaker "NoVoice"; } forEach allPlayers;
};
[] call _fnc_disableChatter;
player addEventHandler ["Respawn", _fnc_disableChatter];
[true, "arsenalClosed", {
	[player, "NoVoice"] remoteExec ["setSpeaker", 0];
}] call BIS_fnc_addScriptedEventHandler;

//Pin the player in place, and disable camera/shooting/etc, without disabling user input.
//This way they can still exit if they want.
player enableSimulation false;

// Start loading screen, so we wait while server init completes.
startLoadingScreen ["Welcome to Mike Force!", "MikeForce_loadingScreen"];
[selectRandom (getArray(missionConfigFile >> "gamemode" >> "loadingScreens" >> "images")),5002] call vn_mf_fnc_update_loading_screen;