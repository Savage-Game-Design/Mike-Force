class Draw3D
{
	targets[] = {HEADED_CLIENT_HOST,HEADED_CLIENT};
	// optional: files[] = {"eventhandlers\mission\eh_EntityKilled_yourcustomheader.sqf","eventhandlers\mission\eh_EntityKilled.sqf","eventhandlers\mission\eh_EntityKilled_yourcustomfooter.sqf"};
};
class EachFrame
{
	targets[] = {HEADED_CLIENT_HOST,HEADED_CLIENT};
};
class EntityKilled
{
	targets[] = {HEADED_CLIENT_HOST,DEDICATED_SERVER};
};
class PreloadStarted
{
	targets[] = {HEADED_CLIENT_HOST,HEADED_CLIENT};
};
class PreloadFinished
{
	targets[] = {HEADED_CLIENT_HOST,HEADED_CLIENT};
};
class EntityRespawned
{
	targets[] = {HEADED_CLIENT_HOST,DEDICATED_SERVER};
};
class HandleDisconnect
{
	targets[] = {HEADED_CLIENT_HOST,DEDICATED_SERVER};
};
class PlayerConnected
{
	targets[] = {HEADED_CLIENT_HOST,DEDICATED_SERVER};
};
class MapSingleClick
{
	targets[] = {HEADED_CLIENT_HOST,HEADED_CLIENT};
};
class Map
{
	targets[] = {HEADED_CLIENT_HOST,HEADED_CLIENT};
};
