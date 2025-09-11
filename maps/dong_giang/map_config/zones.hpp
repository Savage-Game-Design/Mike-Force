//////////////////////////////////////////////////////////////////////////////
// FOB MILLER ROUTES

// FOB MILLER TOWARDS FOB MITCH BRANCH START
zone_da_nam_valley[] = {
	{"zone_da_nam"},
};

zone_da_nam[] = {
	{"zone_south_eastern_village"},
	{"zone_da_nam_valley"},
};

zone_south_eastern_village[]= {
	{"zone_splintered_forest"},
	{"zone_da_nam"},
};

zone_splintered_forest[] = {
	{"zone_ta_tieng"},
	{"zone_canyon"},
	{"zone_south_eastern_village"},
};

// SOUTHERN MOST BRANCH SPLIT
zone_ta_tieng[] = {
	{"zone_south_western_village"},
	{"zone_splintered_forest"},
};

zone_south_western_village[] = {
	{"zone_radio_relay_oscar"},
	{"zone_ta_tieng"},
};

zone_radio_relay_oscar[] = {
	{"zone_south_western_village"},
	{"zone_thon_59b"},
};
// END SOUTHERN MOST BRANCH SPLIT

// SOUTHERN MIDDLE BRANCH SPLIT
zone_canyon[] = {
	{"zone_pa_roh"},
	{"zone_splintered_forest"},
};

zone_pa_roh[] = {
	{"zone_thon_59b"},
	{"zone_canyon"},
};

zone_thon_59b[] = {
	{"zone_cr_toonh"},
	{"zone_radio_relay_oscar"},
	{"zone_pa_roh"},
};
// END SOUTHERN MIDDLE BRANCH SPLIT

// FOB MILLER TAKING THE VALLEY
zone_plei_boh[] = {
	{"zone_kon_kap"},
};

zone_kon_kap[] = {
	{"zone_radio_relay_cudgel"},
	{"zone_plei_boh"},
};

zone_radio_relay_cudgel[] = {
	{"zone_sung_la"},
	{"zone_kon_kap"},
	{"zone_pavn_camp"},
};

zone_sung_la[] = {
	{"zone_radio_relay_george"},
	{"zone_radio_relay_cudgel"},
};

zone_radio_relay_george[] = {
	{"zone_dong_giang"},
	{"zone_sung_la"},
};

zone_dong_giang[] = {
	{"zone_junctions"},
	{"zone_radio_relay_george"},
};

zone_junctions[] = {
	{"zone_dak_pa_r"},
	{"zone_dong_giang"},
};

zone_dak_pa_r[] = {
	{"zone_cr_toonh"},
	{"zone_junctions"},
};

zone_cr_toonh[] = {
	{"zone_drawbridge"},
	{"zone_dak_pa_r"},
	{"zone_thon_59b"},
};


// END FOB MILLER TAKING THE VALLEY

//////////////////////////////////////////////////////////////////////////////
// FOB MITCH ROUTES

// FOB MITCH NORTHERN ROUTE TOWARDS LZ
zone_drawbridge[] = {
	{"zone_cr_toonh"};
	{"zone_ia_puh"},
};

zone_ia_puh[] = {
	{"zone_northern_jungle"},
	{"zone_drawbridge"},
};

zone_northern_jungle[] = {
	{"zone_dai_son"},
	{"zone_battle_hill"},
	{"zone_ia_puh"},
};

// START LZ SUBBRANCH
zone_battle_hill[] = {
	{"zone_pa_toi"},
	{"zone_northern_jungle"},
};

zone_pa_toi[] = {
	{"zone_lz_two"},
};

zone_lz_two[] = {
	{"zone_lz_three"},
};

zone_lz_three[] = {
	{"zone_lz_one"},
};
// END LZ SUBBRANCH

zone_dai_son[] = {
	{"zone_temple"},
	{"zone_pavn_base"},
	{"zone_northern_jungle"},
};

zone_temple[] = {
	{"zone_abandoned_outpost"},
	{"zone_dai_son"},
};

// TODO leave this as a stop?
zone_pavn_base[] = {
	{"zone_abandoned_outpost"},
	{"zone_dai_son"},
};

zone_abandoned_outpost[] = {
	{"zone_pavn_camp"},
	{"zone_temple"},
	{"zone_pavn_base"},
};

zone_pavn_camp[] = {
	{"zone_abandoned_outpost"},
	{"zone_radio_relay_cudgel"},
};

