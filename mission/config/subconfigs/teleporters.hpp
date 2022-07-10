class objects
{
	class vn_mf_greenhornets_teleporter 
	{
		destinations[] = {"mikeforce_base", "acav_base", "spiketeam_base"};
	};

	class vn_mf_spiketeam_teleporter
	{
		destinations[] = {"mikeforce_base", "acav_base", "greenhornets_base"};
	};

	class vn_mf_mikeforce_teleporter
	{
		destinations[] = {"spiketeam_base", "acav_base", "greenhornets_base"};
	};

	class vn_mf_acav_teleporter
	{
		destinations[] = {"mikeforce_base", "spiketeam_base", "greenhornets_base"};
	};
};

class destinations
{
	class spiketeam_base
	{
		image = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_tel_spikebase_ca.paa";
		position_marker = "mf_respawn_spiketeam";
	};

	class mikeforce_base
	{
		image = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_tel_mikebase_ca.paa";
		position_marker = "mf_respawn_mikeforce";
	};

	class acav_base
	{
		image = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_tel_acavbase_ca.paa";
		position_marker = "mf_respawn_acav";
	};

	class greenhornets_base
	{
		image = "\vn\ui_f_vietnam\ui\wheelmenu\img\icons\vn_ico_mf_tel_airbase_ca.paa";
		position_marker = "mf_respawn_greenhornets";
	};
};
