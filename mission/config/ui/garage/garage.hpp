import RscDisplayGarage;

class vn_mf_garage_disp_garage : RscDisplayGarage {
	onLoad = "with uiNamespace do { ['Init', _this] call vn_mf_fnc_garage_open }";
	onUnload = "with uiNamespace do { ['Exit', _this] call vn_mf_fnc_garage_open }";
};