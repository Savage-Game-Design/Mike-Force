class wipe_save
{
    title = $STR_vn_mf_param_wipe_save;
    values[] = {0, 1};
    texts[] = {"False", "True"};
    default = 0;
};

class wipe_save_desc
{
    title = $STR_vn_mf_param_wipe_save_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer0
{
    title = "";
    values[] = {""};
    texts[] = {""};
    default = "";
};

class enable_ranks
{
    title = $STR_vn_mf_param_enable_ranks;
    values[] = {0, 1};
    texts[] = {"False", "True"};
    default = 0;
};

class enable_ranks_desc
{
    title = $STR_vn_mf_param_enable_ranks_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer21 : Spacer0 {};

class allow_map_markers
{
    title = $STR_vn_mf_param_allow_map_markers;
    values[] = {0, 1};
    texts[] = {"False", "True"};
    default = 1;
};

class allow_map_markers_desc
{
    title = $STR_vn_mf_param_allow_map_markers_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer1 : Spacer0 {};

class hard_ai_limit
{
    title = $STR_vn_mf_param_hard_ai_limit;
    values[] = {60, 80, 100, 120, 140, 160, 180, 200};
    texts[] = {"60", "80 (recommended)", "100", "120", "140", "160", "180", "200"};
    default = 80;
};

class hard_ai_limit_desc
{
    title = $STR_vn_mf_param_hard_ai_limit_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer1_0 : Spacer0 {};

class ai_scaling
{
    title = $STR_vn_mf_param_ai_scaling;
    values[] = {25, 50, 75, 100, 150, 200, 250, 300};
    texts[] = {"25%", "50%", "75%", "100%", "150%", "200%", "250%", "300%"};
    default = 100;
};

class ai_scaling_desc
{
    title = $STR_vn_mf_param_ai_scaling_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer1_1 : Spacer0 {};

// gamemode specific start
class buildables_require_vehicles
{
    title = $STR_vn_mf_buildables_require_vehicles;
    values[] = {0, 1};
    texts[] = {"False", "True"};
    default = 0;
};

class buildables_require_vehicles_desc
{
    title = $STR_vn_mf_buildables_require_vehicles_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer2 : Spacer1 {};

class dawn_length
{
    title = $STR_vn_mf_dawn_length;
    values[] = {600, 1200, 1800, 2400, 3600, 5400, 7200, 9000, 10800};
    texts[] = {"10 minutes", "20 minutes", "30 minutes", "40 minutes", "1 hour", "1.5 hours", "2 hours", "2.5 hours", "3 hours"};
    default = 1200;
};

class Spacer3 : Spacer1 {};

class day_length
{
    title = $STR_vn_mf_day_length;
    values[] = {3600, 5400, 7200, 9000, 10800, 21600, 43200, 86400, 172800};
    texts[] = {"1 hour", "1.5 hours", "2 hours", "2.5 hours", "3 hours", "6 hours", "12 hours", "24 hours", "48 hours"};
    default = 7200;
};

class Spacer4 : Spacer1 {};

class dusk_length
{
    title = $STR_vn_mf_dusk_length;
    values[] = {600, 1200, 1800, 2400, 3600, 5400, 7200, 9000, 10800};
    texts[] = {"10 minutes", "20 minutes", "30 minutes", "40 minutes", "1 hour", "1.5 hours", "2 hours", "2.5 hours", "3 hours"};
    default = 1200;
};

class Spacer5 : Spacer1 {};

class night_length
{
    title = $STR_vn_mf_night_length;
    values[] = {600, 1200, 1800, 2400, 3600, 5400, 7200, 9000, 10800, 21600, 43200, 86400, 172800};
    texts[] = {"10 minutes", "20 minutes", "30 minutes", "40 minutes", "1 hour", "1.5 hours", "2 hours", "2.5 hours", "3 hours", "6 hours", "12 hours", "24 hours", "48 hours"};
    default = 1200;
};

class Spacer7 : Spacer1 {};

class building_sandbag_value
{
    title = $STR_vn_mf_building_sandbag_value;
    values[] = {10};
    texts[] = {"Default (10)"};
    default = 10;
};

class building_sandbag_value_desc
{
    title = $STR_vn_mf_building_sandbag_value_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer8 : Spacer1 {};

class advanced_revive
{
    title = $STR_vn_mf_advanced_revive;
    values[] = {1, 0};
    texts[] = {"True (Default)", "False"};
    default = 1;
};

class advanced_revive_desc
{
    title = $STR_vn_mf_advanced_revive_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer9 : Spacer1 {};

class snake_header
{
    title = $STR_vn_mf_param_snake_header;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer11 : Spacer1 {};

class snake_bite_chance
{
    title = $STR_vn_mf_param_snake_bite_chance;
    values[] = {0, 15, 25, 35, 50, 65, 75};
    texts[] = {"0% (Off)", "15%", "25%", "35%", "50% (Default)", "65%", "75%"};
    default = 50;
};

class snake_bite_chance_desc
{
    title = $STR_vn_mf_param_snake_bite_chance_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class snake_bite_distance
{
    title = $STR_vn_mf_param_snake_bite_distance;
    values[] = {25, 50, 75, 100, 125, 150};
    texts[] = {"25cm", "50cm", "75cm", "1m (Default)", "1.25m", "1.5m"};
    default = 100;
};

class snake_bite_distance_desc
{
    title = $STR_vn_mf_param_snake_bite_distance_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class snake_bite_frequency
{
    title = $STR_vn_mf_param_snake_bite_frequency;
    values[] = {150, 300, 450, 600};
    texts[] = {"2.5 minutes", "5 minutes (Default)", "7.5 minutes", "10 minutes"};
    default = 300;
};

class snake_bite_frequency_desc
{
    title = $STR_vn_mf_param_snake_bite_frequency_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class snake_bite_extra_time
{
    title = $STR_vn_mf_param_snake_bite_extra_time;
    values[] = {150, 300, 450, 600};
    texts[] = {"2.5 minutes", "5 minutes (Default)", "7.5 minutes", "10 minutes"};
    default = 300;
};

class snake_bite_extra_time_desc
{
    title = $STR_vn_mf_param_snake_bite_extra_time_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer12 : Spacer1 {};

class teams_header
{
    title = $STR_vn_mf_param_teams_header;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer13 : Spacer1 {};

class max_players_acav
{
    title = $STR_vn_mf_max_players_acav;
    values[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30, 35, 40, 45, 50, 99};
    texts[] = {"0 players", "1 player", "2 players", "3 players", "4 players", "5 players", "6 players", "7 players", "8 players", "9 players", "10 players", "15 players", "20 players", "25 players", "30 players", "35 players", "40 players", "45 players", "50 players", "Default (99 players)"};
    default = 99;
};

class max_players_greenhornets
{
    title = $STR_vn_mf_max_players_greenhornets;
    values[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30, 35, 40, 45, 50, 99};
    texts[] = {"0 players", "1 player", "2 players", "3 players", "4 players", "5 players", "6 players", "7 players", "8 players", "9 players", "10 players", "15 players", "20 players", "25 players", "30 players", "35 players", "40 players", "45 players", "50 players", "Default (99 players)"};
    default = 99;
};

class max_players_mikeforce
{
    title = $STR_vn_mf_max_players_mikeforce;
    values[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30, 35, 40, 45, 50, 99};
    texts[] = {"0 players", "1 player", "2 players", "3 players", "4 players", "5 players", "6 players", "7 players", "8 players", "9 players", "10 players", "15 players", "20 players", "25 players", "30 players", "35 players", "40 players", "45 players", "50 players", "Default (99 players)"};
    default = 99;
};

class max_players_spiketeam
{
    title = $STR_vn_mf_max_players_spiketeam;
    values[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30, 35, 40, 45, 50, 99};
    texts[] = {"0 players", "1 player", "2 players", "3 players", "4 players", "5 players", "6 players", "7 players", "8 players", "9 players", "10 players", "15 players", "20 players", "25 players", "30 players", "35 players", "40 players", "45 players", "50 players", "Default (99 players)"};
    default = 6;
};


class Spacer14 : Spacer1 {};

class enable_air_support
{
    title = $STR_vn_mf_enable_air_support;
    values[] = {0, 1, 2};
    texts[] = {"Off", "On (Default)", "Unique Supports Only"};
    default = 1;
};

class enable_air_support_desc
{
    title = $STR_vn_mf_enable_air_support_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};
  
  class enable_arty_support
{
    title = $STR_vn_mf_enable_arty_support;
    values[] = {0, 1};
    texts[] = {"Off", "On (Default)"};
    default = 1;
};

class Spacer15 : Spacer1 {};

class medical_header
{
    title = $STR_vn_mf_param_medical_header;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer16 : Spacer1 {};

class headshot_kill
{
    title = $STR_vn_mf_param_headshot_kill;
    values[] = {0, 1};
    texts[] = {"Off (Default)", "On"};
    default = 0;
};

class headshot_kill_desc
{
    title = $STR_vn_mf_param_headshot_kill_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};
class bleedout_time
{
    title = $STR_vn_mf_param_bleedout_time;
    values[] = {100, 200, 300, 400, 500};
    texts[] = {"100", "200", "300 (Default)", "400", "500"};
    default = 300;
};

class bleedout_time_desc
{
    title = $STR_vn_mf_param_bleedout_time_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class always_allow_withstand
{
    title = $STR_vn_mf_always_allow_withstand;
    values[] = {0, 1};
    texts[] = {"Off", "On (Default)"};
    default = 1;
};


class always_allow_withstand_desc
{
    title = $STR_vn_mf_always_allow_withstand_desc;

    values[] = {""};
    texts[] = {""};
    default = "";
};

class withstand_percentage
{
    title = $STR_vn_mf_param_withstand_percentage;
    values[] = {50, 70, 80, 100};
    texts[] = {"50%", "30%", "20% (Default)", "0%"};
    default = 80;
};

class withstand_percentage_desc
{
    title = $STR_vn_mf_param_withstand_percentage_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class remove_bandage_item
{
    title = $STR_vn_mf_param_remove_bandage_item;
    values[] = {0, 1};
    texts[] = {"Off", "On (Default)"};
    default = 1;
};


class remove_bandage_item_desc
{
    title = $STR_vn_mf_param_remove_bandage_item_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class remove_revive_item
{
    title = $STR_vn_mf_param_remove_revive_item;
    values[] = {0, 1};
    texts[] = {"Off (Default)", "On"};
    default = 0;
};

class remove_revive_item_desc
{
    title = $STR_vn_mf_param_remove_revive_item_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class revive_requirement
{
    title = $STR_vn_mf_param_revive_requirement;
    values[] = {0, 1};
    texts[] = {"Off (Default)", "On"};
    default = 0;
};

class respawn_delay
{
    title = $STR_vn_mf_param_respawn_delay;
    values[] = {5, 10, 20, 30};
    texts[] = {"5 seconds", "10 seconds", "20 seconds (Default)", "30 seconds"};
    default = 20;
};
  
class Spacer17 : Spacer1 {};

class hunger_loss_rate
{
    title = $STR_vn_mf_param_hunger_loss_rate;
    values[] = {1, 5, 10, 25, 50, 100};
    texts[] = {"0.01%", "0.05% (Default)", "0.1%", "0.25%", "0.5%", "1%"};
    default = 5;
};

class hunger_loss_rate_desc
{
    title = $STR_vn_mf_param_hunger_loss_rate_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class thirst_loss_rate
{
    title = $STR_vn_mf_param_thirst_loss_rate;
    values[] = {1, 5, 10, 25, 50, 100};
    texts[] = {"0.01%", "0.05%", "0.1% (Default)", "0.25%", "0.5%", "1%"};
    default = 10;
};

class thirst_loss_rate_desc
{
    title = $STR_vn_mf_param_thirst_loss_rate_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer18: Spacer1 {};

class enable_stamina
{
    title = $STR_vn_mf_param_enable_stamina;
    values[] = {1, 0};
    texts[] = {"True", "False"};
    default = 1;
};

class set_stamina
{
    title = $STR_vn_mf_param_set_stamina;
    values[] = {0, 1, 2, 3};
    texts[] = {"Normal", "Default", "FastDrain", "Exhausted"};
    default = 1;
};

class Spacer19: Spacer1 {};

class cleanup_header
{
    title = $STR_vn_mf_param_cleanup_header;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class Spacer20: Spacer1 {};

class cleanup_min_player_distance
{
    title = $STR_vn_mf_param_cleanup_min_player_distance;
    values[] = {10, 50, 100, 200, 300, 400, 500, 1000};
    texts[] = {"10m", "50m", "100m", "200m", "300m", "400m", "500m", "1000m"};
    default = 400;
};

class cleanup_min_player_distance_desc
{
    title = $STR_vn_mf_param_cleanup_min_player_distance_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class cleanup_max_bodies
{
    title = $STR_vn_mf_param_cleanup_max_bodies;
    values[] = {10, 25, 50, 75, 100, 125, 150, 200};
    texts[] = {"10", "25", "50", "75", "100", "125", "150", "200"};
    default = 50;
};

class cleanup_placed_gear
{
    title = $STR_vn_mf_param_cleanup_placed_gear;
    values[] = {1, 0};
    texts[] = {"Yes", "No"};
    default = 1;
};

class cleanup_placed_gear_desc
{
    title = $STR_vn_mf_param_cleanup_placed_gear_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class cleanup_placed_gear_lifetime
{
    title = $STR_vn_mf_param_cleanup_placed_gear_lifetime;
    values[] = {60, 120, 180, 300, 600, 1800, 3600};
    texts[] = {"1 minute", "2 minutes", "3 minutes", "5 minutes", "10 minutes", "30 minutes", "1 hour"};
    default = 300;
};

class cleanup_dropped_gear
{
    title = $STR_vn_mf_param_cleanup_dropped_gear;
    values[] = {1, 0};
    texts[] = {"Yes", "No"};
    default = 1;
};

class cleanup_dropped_gear_desc
{
    title = $STR_vn_mf_param_cleanup_dropped_gear_desc;
    values[] = {""};
    texts[] = {""};
    default = "";
};

class cleanup_dropped_gear_lifetime
{
    title = $STR_vn_mf_param_cleanup_dropped_gear_lifetime;
    values[] = {60, 120, 180, 300, 600, 1800, 3600};
    texts[] = {"1 minute", "2 minutes", "3 minutes", "5 minutes", "10 minutes", "30 minutes", "1 hour"};
    default = 300;
};
