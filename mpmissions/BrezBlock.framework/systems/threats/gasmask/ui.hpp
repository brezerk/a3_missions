//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)
#ifndef HG_GasMaskHUDhpp
#define HG_GasMaskHUDhpp 1
//Create a header guard to prevent duplicate include.

class RscGasMaskPicture
{
    idc = -1;
    type = 0;
    style = 48;
	size = 1;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    font = "RobotoCondensedLight";
    sizeEx = 1;
	lineSpacing = 0;
    text = "";
    fixedWidth = 0;
	shadow = 0;
};

class GasMaskHUD {
	idd = -1;
	movingEnable = 0;
	duration = 1000000000;
	fadein = 0;
	fadeout = 0;
	onLoad = "uiNamespace setVariable ['bb_gasmask_hud', _this select 0]";
	name = "GasMaskHUD";
	controls[] = {"Condencate", "GasMask"};
	class Condencate: RscGasMaskPicture
	{
		idc = 9901;
		x = safeZoneX;
		y = safeZoneY;
		w = safeZoneW;
		h = safeZoneH;
		colorText[] = {1,1,1,0};
		text = "addons\BrezBlock.framework\data\threats\gasmask\hud_03_condensate01.paa";
	};
	class GasMask: RscGasMaskPicture
	{
		idc = 9900;
		x = safeZoneX;
		y = safeZoneY;
		w = safeZoneW;
		h = safeZoneH;
		text = "addons\BrezBlock.framework\data\threats\gasmask\hud_03.paa";
	};
	
	
};

#endif