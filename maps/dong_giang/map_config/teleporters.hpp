class objects
{
	class vn_mf_greenhornets_teleporter 
	{
		destinations[] = {"mikeforce_base", "acav_base", "spiketeam_base", "arty_base", "comms_tower"};
	};

	class vn_mf_spiketeam_teleporter
	{
		destinations[] = {"mikeforce_base", "acav_base", "greenhornets_base", "arty_base", "comms_tower"};
	};

	class vn_mf_mikeforce_teleporter
	{
		destinations[] = {"spiketeam_base", "acav_base", "greenhornets_base", "arty_base", "comms_tower"};
	};

	class vn_mf_acav_teleporter
	{
		destinations[] = {"mikeforce_base", "spiketeam_base", "greenhornets_base", "arty_base", "comms_tower"};
	};

	class vn_mf_artybase_teleporter
	{
		destinations[] = {"mikeforce_base", "spiketeam_base", "acav_base", "greenhornets_base", "comms_tower"};
	};

    class vn_mf_commstower_teleporter
	{
		destinations[] = {"mikeforce_base", "spiketeam_base", "acav_base", "greenhornets_base", "arty_base"};
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

	class arty_base
	{
        // TODO: better image?
		image = "\A3\ui_f\data\map\markers\nato\b_art.paa";
		position_marker = "mf_respawn_arty_base";
	};

	class comms_tower
	{
        // TODO: better image?
		image = "\A3\ui_f\data\map\markers\nato\b_recon.paa";
		position_marker = "mf_respawn_comms_tower";
	};
};
