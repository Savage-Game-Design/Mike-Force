# GUI creation in Mikeforce
## Configs
### Basic display
An example can be found in _config\ui\Example\vn_mf_RscDisplayExample.hpp_.
- Create a new file in _config\ui\DisplayName\\_.
- File name: _vn_mf_RscDisplayDisplayName.hpp_.
- The display config should then be created in the following way:
```cpp
class vn_mf_RscDisplayDisplayName
{
    idd = VN_MF_IDD_RSCDISPLAYDISPLAYNAME;
    VN_MF_INIT_DISPLAY(vn_mf_RscDisplayDisplayName)
    class Objects
    {

    };
    class ControlsBackground
    {

    };
    class Controls
    {

    };
};
```
- `VN_MF_IDD_RSCDISPLAYEXAMPLE` is defined in _config\ui\ui_def_idc.hpp_.
- `VN_MF_INIT_DISPLAY` handles the onLoad and onUnload UI eventhandlers. In both cases it will call `para_fnc_ui_initMissionDisplay`, see _paradigm\Client\functions\ui\fn_ui_initMissionDisplay.sqf_ for more info
- From that function `vn_mf_fnc_vn_mf_RscDisplayDisplayName` is called and in which the UI's sqf part should be handled. See the following sections.

### Controls
- Base classes for Mikeforce start with `vn_mf_[...]`.
  - Digetic UIs should be in VN's style
    - This includes using the [Fonts](###Fonts)
  - Everything else should be A3's style
- These are defined in _config\ui\ui_def_ctrl_base.hpp_.
- For idcs use macros, such as `idc = VN_MF_RSCDISPLAYDISPLAYNAME_CONTROLCLASS_IDC`.
- idc macros should be defined in _config\ui\ui_def_idc.hpp_.
- All text should be localized.
- Format for the key is `STR_DISPLAYNAME_CONTROLNAME_ATTRIBUTE` (see example).
  - `ATTRIBUTE` can be `TEXT`, `TOOLTIP`, etc..
- The position of the control should be defined using the following macros:
  - X positions:
    - `UIX_LR(N)` **Left** edge of the screen, goes `N` grids to the **right**.
    - `UIX_CL(N)` **Middle** of the screen, goes `N` grids to the **left**.
    - `UIX_CR(N)` **Middle** of the screen, goes `N` grids to the **right**.
    - `UIX_RL(N)` **Right** edge of the screen, goes `N` grids to the **left**.
```
+---------------------------------------------------------------------------------------+
|Left edge                               Cen|ter                              Right edge|
|                                           |                                           |
|                                           |                                           |
|                                           |                                           |
|                                           |                                           |
| UIX_LR →                         ← UIX_CL | UIX_CR →                         ← UIX_RL |
|                                           |                                           |
|                                           |                                           |
|                                           |                                           |
|                                           |                                           |
|                                           |                                           |
+---------------------------------------------------------------------------------------+
```
-   - Y positions:
      - `UIY_TD(N)` **Top** edge of the screen, going `N` grids **down**.
      - `UIY_CU(N)` **Center** of the screen, going `N` grids **up**.
      - `UIY_CD(N)` **Center** of the screen, going `N` grids **down**.
      - `UIY_BU(N)` **Bottom** edge of the screen, going `N` grids **up**.
```
+---------------------------------------------------------------------------------------+
|                                      ↓ UIY_TD ↓                                       |
|                                                                                       |
|                                                                                       |
|                                                                                       |
|                                      ↑ UIY_CU ↑                                       |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|                                      ↓ UIY_CD ↓                                       |
|                                                                                       |
|                                                                                       |
|                                                                                       |
|                                      ↑ UIY_CD ↑                                       |
+---------------------------------------------------------------------------------------+
```
- `UIW(N)` for the width and
- `UIH(N)` for the height
- **IMPORTANT**: The "screen" consists of a 40x25 grid, so no combination that leaves that area should be used!

Example:
```cpp
class ControlName: vn_mf_RscText
{
    idc = VN_MF_RSCDISPLAYDISPLAYNAME_CONTROLNAME_IDC;
    text = $STR_DISPLAYNAME_CONTROLNAME_TEXT;
    x = UIX_CL(5);
    y = UIY_CU(2.5);
    w = UIW(10);
    h = UIH(5);
};
```

### Fonts
The following fonts can be used for UIs in Mikeforce and VN in general:

<table>
  <tr>
    <td>Font</td>
    <td>Macro</td>
    <td>Details</td>
  </tr>
  <tr>
    <td><code>"tt2020base_vn"</code></td>
    <td><code>USEDFONT</code></td>
    <td>Default font</td>
  </tr>
  <tr>
    <td colspan=3><img src="https://ctrlcctrlv.github.io/TT2020/docs/TT2020Base-Regular.png"></td>
  </tr>
  <tr>
    <td><code>"tt2020base_vn_bold"</code></td>
    <td><code>USEDFONT_B</code></td>
    <td>Bold default font</td>
  </tr>
  <tr>
    <td><code>"tt2020style_e_vn"</code></td>
    <td><code>USEDFONT_ALT</code></td>
    <td>Alternative font</td>
  </tr>
  <tr>
    <td colspan=3><img src="https://ctrlcctrlv.github.io/TT2020/docs/TT2020StyleE-Regular.png"></td>
  </tr>
  <tr>
    <td><code>"tt2020style_e_vn_bold"</code></td>
    <td><code>USEDFONT_ALT_B</code></td>
    <td>Bold alternative font</td>
  </tr>
</table>

The macros are defined in _config\ui\ui_def_base.inc_

## SQF
### para_fnc_ui_initMissionDisplay
Path: paradigm\Client\functions\ui\fn_ui_initMissionDisplay.sqf_<br>
- Saves display to uiNamespace as `para_RscDisplayDisplayName`.
```sqf
_display = uiNamespace getVariable "para_RscDisplayDisplayName";
```
- Adds display to list of open displays in uiNamespace (`"default_displays"`).
```sqf
_openDisplays = uiNamespace getVariable "default_displays";
```
- Saves config classname to display as `"BIS_fnc_initDisplay_configClass"`.
```sqf
missionConfigFile >> (_display getVariable "BIS_fnc_initDisplay_configClass")
```
- Updates these variables when display is closed.
- Calls the display's `para_fnc_[display classname]` function, eg. `para_fnc_parfa_RscDisplayDisplayName`

### vn_mf_fnc_vn_mf_RscDisplayDisplayName
Path: _functions\ui\DisplayName\fn_vn_mf_RscDisplayDisplayName.sqf_
- Handles the onLoad and onUnload UIEHs of the display.
- Params passed are
```
0: _mode - Either "onLoad" or "onUnload" [STRING]
1: _params - List of arguments [ARRAY]
    0: _display - The display [DISPLAY]
    1: _exitCode - (onUnload only) 1 = OK, 2 = CANCEL, 
                   or N for closeDisplay/closeDialog N [NUMBER]
2: _class - Classname of the display [STRING]
```
- Assigns the UIEH to the controls.
- The UIEH are functions from CfgFunctions.
- Passed arguments are those from the UIEH.
```sqf
_ctrl ctrlAddEventhandler ["ButtonClick", vn_mf_fnc_DisplayName_ctrlClick];
```
- Since this script only handles onLoad and onUnload the structure is
```sqf
if (_mode == "onLoad") exitWith {
    /* onLoad code */
};
/* onUnload code */
```
Example:
```sqf
#include "..\ui_def_base.inc"
params ["_mode", "_params", "_class"];

if (_mode == "onLoad") exitWith {
    _params params ["_display"];
    _ctrlLeftTop = _display displayCtrl VN_MF_RSCDISPLAYEXAMPLE_LT_IDC;
    _ctrlLeftTop ctrlAddEventHandler ["MouseEnter", vn_mf_fnc_Example_LTMouseEnter];
};
_params params ["_display", "_exitCode"];
```

### CfgFunctions
_config\functions.hpp_
- Add all needed scripts to CfgFunctions.<br>
Example:
```cpp
class CfgFunctions
{
    class vn_mf
    {
        class DisplayName
        {
            file = "functions\ui\DisplayName";
            class vn_mf_RscDisplayDisplayName;
            class displayName_UIEH; // whatever you want
        };
    };
};
```