class VN_TimerOverlay
{
	idd = 1200;
	fadein = 0;
	fadeout = 10000;
	duration = 10000;
	class Controls
    {
        class Holder: vn_mf_RscControlsGroupNoScrollbarHV
        {
            onLoad = "uiNamespace setVariable ['#VN_MF_TimerOverlay_Holder', (_this#0)];";
            // private _ctrlBasePosition = [safeZoneX + safezoneW - UIW(9.5), safeZoneY + safezoneH - UIH(10), UIW(9.5), UIH(1)];
            x = safeZoneX + safezoneW;
            y = safeZoneY + safezoneH - UIH(20);
            w = UIW(9.5);
            h = UIH(2);
            class Controls
            {
                class Title: VN_MF_Overlay_Title_Background
                {
                    x = 0;
                    y = 0;
                    w = UIW(14);
                    h = UIH(1);
                    text = "";
                    onLoad = "uiNamespace setVariable ['#VN_MF_TimerOverlay_Title', (_this#0)];";
                };
                class Message: VN_MF_Overlay_Text_Background
                {
                    x = 0;
                    y = UIH(1);
                    w = UIW(14);
                    h = UIH(1);
                    text = "";
                    onLoad = "uiNamespace setVariable ['#VN_MF_TimerOverlay_Message', (_this#0)];";
                };
            };
        };
    };
};