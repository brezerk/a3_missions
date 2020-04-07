//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)
#ifndef HG_SurvivalHUDhpp
#define HG_SurvivalHUDhpp 1


//Create a header guard to prevent duplicate include.
class BB_Survival_HUD
{
	idd = -1;
	movingEnable = 0;
	fadein = 0;
	fadeout = 0;
	name = "BB_Survival_HUD";
	duration = 1e+1000;
	onLoad = "uiNamespace setVariable ['bb_survival_hud', _this select 0]";
	class ControlsBackground
	{
	};
	class Controls
	{
		/*
		class frmCounter
		{
			type = 0;
			idc = 2990;
			x = safeZoneX + safeZoneW - (safeZoneW * 0.02441407);
			y = safeZoneY + safeZoneH * 0.59826389;
			w = safeZoneW * 0.02441407;
			h = safeZoneH * 0.20833334;
			style = 0+128;
			text = "";
			colorBackground[] = {0,0,0,0.3};
			colorText[] = {0.6314,0.8235,0.9765,1};
			font = "RobotoCondensedLight";
			sizeEx = 1;
		};*/
		class imgFood
		{
			type = 0;
			idc = 2991;
			x = safeZoneX + safeZoneW - (safeZoneW * 0.035);
			y = safeZoneY + safeZoneH * 0.60;
			w = safeZoneW * 0.035;
			h = safeZoneW * 0.035;
			style = 48+2;
			text = "addons\BrezBlock.framework\data\survival\food.paa";
			colorBackground[] = {0,0,0,1};
			colorText[] = {0.949,0.949,0.949,0.7};
			font = "RobotoCondensedLight";
			sizeEx = 1;
			
		};
		class imgWater
		{
			type = 0;
			idc = 2992;
			x = safeZoneX + safeZoneW - (safeZoneW * 0.035);
			y = (safeZoneY + safeZoneH * 0.60) + (safeZoneW * 0.035);
			w = safeZoneW * 0.035;
			h = safeZoneW * 0.035;
			style = 48+2;
			text = "addons\BrezBlock.framework\data\survival\hydration.paa";
			colorBackground[] = {0,0,0,1};
			colorText[] = {0.949,0.949,0.949,0.7};
			font = "RobotoCondensedLight";
			sizeEx = 1;
			
		};
		class imgTempEnv
		{
			type = 0;
			idc = 2993;
			x = safeZoneX + safeZoneW - (safeZoneW * 0.035);
			y = (safeZoneY + safeZoneH * 0.60) + (safeZoneW * 0.035 * 2);
			w = safeZoneW * 0.035;
			h = safeZoneW * 0.035;
			style = 48+2;
			text = "addons\BrezBlock.framework\data\survival\weather-hot.paa";
			colorBackground[] = {0,0,0,1};
			colorText[] = {0.949,0.949,0.949,0.7};
			font = "RobotoCondensedLight";
			sizeEx = 1;
			
		};
		class imgTemp
		{
			type = 0;
			idc = 2994;
			x = safeZoneX + safeZoneW - (safeZoneW * 0.035);
			y = (safeZoneY + safeZoneH * 0.60) + (safeZoneW * 0.035 * 3);
			w = safeZoneW * 0.035;
			h = safeZoneW * 0.035;
			style = 48+2;
			text = "addons\BrezBlock.framework\data\survival\temperature.paa";
			colorBackground[] = {0,0,0,1};
			colorText[] = {0.949,0.949,0.949,0.7};
			font = "RobotoCondensedLight";
			sizeEx = 1;
			
		};
		class imgHealth
		{
			type = 0;
			idc = 2995;
			x = safeZoneX + safeZoneW - (safeZoneW * 0.035);
			y = (safeZoneY + safeZoneH * 0.60) + (safeZoneW * 0.035 * 4);
			w = safeZoneW * 0.035;
			h = safeZoneW * 0.035;
			style = 48+2;
			text = "addons\BrezBlock.framework\data\survival\health-normal.paa";
			colorBackground[] = {0,0,0,1};
			colorText[] = {0.949,0.949,0.949,0.7};
			font = "RobotoCondensedLight";
			sizeEx = 1;
			
		};
		class imgSymptom01
		{
			type = 0;
			idc = 2996;
			x = safeZoneX + safeZoneW - (safeZoneW * 0.035);
			y = (safeZoneY + safeZoneH * 0.60) + (safeZoneW * 0.035 * 5);
			w = safeZoneW * 0.035;
			h = safeZoneW * 0.035;
			style = 48+2;
			text = "addons\BrezBlock.framework\data\survival\stomach.paa";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,0.6,0.6,0.9};
			font = "RobotoCondensedLight";
			sizeEx = 1;
			
		};
		class imgSymptom02
		{
			type = 0;
			idc = 2997;
			x = safeZoneX + safeZoneW - (safeZoneW * 0.035);
			y = (safeZoneY + safeZoneH * 0.60) + (safeZoneW * 0.035 * 6);
			w = safeZoneW * 0.035;
			h = safeZoneW * 0.035;
			style = 48+2;
			text = "addons\BrezBlock.framework\data\survival\vomiting.paa";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,0.6,0.6,0.9};
			font = "RobotoCondensedLight";
			sizeEx = 1;
			
		};
		class imgSymptom03
		{
			type = 0;
			idc = 2998;
			x = safeZoneX + safeZoneW - (safeZoneW * 0.035);
			y = (safeZoneY + safeZoneH * 0.60) + (safeZoneW * 0.035 * 7);
			w = safeZoneW * 0.035;
			h = safeZoneW * 0.035;
			style = 48+2;
			text = "addons\BrezBlock.framework\data\survival\stimulator.paa";
			colorBackground[] = {0,0,0,1};
			colorText[] = {1,0.6,0.6,0.9};
			font = "RobotoCondensedLight";
			sizeEx = 1;
			
		};
	};
};

#endif
