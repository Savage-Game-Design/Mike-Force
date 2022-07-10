//Include paradigm configs
#include "paradigm.hpp"

// Defines
#include "defines.hpp"
// Functions
#include "functions.hpp"
// Gamemode
#include "gamemode.hpp"
// UI
#include "interface.hpp"
// item interactions
#include "interactions.hpp"
// logistics configs
#include "logistics.hpp"
// notifications configs
#include "notifications.hpp"
// arsenal additions
#include "arsenal.hpp"
//TFAR configs
#include "tfar.hpp"
// sound configs
#include "sounds.hpp"
// Artillery module config
#include "artillery.hpp"
// Wheel menu actions
#include "wheel_menu_actions.hpp"
// Respawn template definitions
#include "respawn_templates.hpp"
// Tutorial and field manual entries
#include "hints.hpp"
// Welcome screen shown on join
#include "welcome_screen.hpp"
// Changelog
#include "changelog.hpp"

// Include map-specific config
#include "..\map_config\init.hpp"

// load profile namespace variables for runtime use
__EXEC(allProfileNamespaceVars = allVariables profileNamespace);
