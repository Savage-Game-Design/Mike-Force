
if (isNil "vn_mf_arsenal_food_drink_overlay_enabled") then {[true, "arsenalOpened", {
    params ["_display"];
    
    private _ctrlListCargoMagAll = _display displayCtrl 986;
    // add selection handler to list of all magazines     
    _ctrlListCargoMagAll ctrlAddEventHandler ["LbSelChanged", {
        _this spawn {
            params ["_ctrlLnb", "_selIndex"];
            // check if selected item has "food" in
            private _selectedMagazine = _ctrlLnb lnbData [_selIndex, 0];
            private _cfgInteractions = missionConfigFile >> "CfgItemInteractions";
            if (!isNumber (_cfgInteractions >> _selectedMagazine >> "food")) exitWith {};
            private _foodCfg = _cfgInteractions >> _selectedMagazine;
        
            private _display = ctrlParent _ctrlLnb;
            private _ctrlStats = _display displayCtrl 28644;
            _ctrlStats ctrlSetFade 0;
            _ctrlStats ctrlCommit 0;
            
            // update stats texts/progress bars
            private _statBaseIdc = 27349;
            {
                _x params ["_text", "_fnc_stat"];
                private _statBar = _display displayCtrl (_statBaseIdc + _forEachIndex);
                _statBar ctrlSetTextColor [1,1,1,1];

				private _progPos = (_foodCfg call _fnc_stat);
				if (0 > _progPos) then {
					_statBar ctrlSetTextColor [1,0,0,1];
					_progPos = abs _progPos;
				};
				_statBar progressSetPosition (_progPos);
                private _statText = _display displayCtrl (_statBaseIdc + _forEachIndex + 5);
                _statText ctrlSetText _text;
            } forEach [
                ["FOOD", {getNumber (_this >> "food")}],
                ["WATER", {getNumber (_this >> "water")}],
                ["USES", {(100 - getNumber (_this >> "consume")) / 100}],
                ["", {0}]
            ];
        };
    }];
    }] call BIS_fnc_addScriptedEventHandler};
vn_mf_arsenal_food_drink_overlay_enabled = True;