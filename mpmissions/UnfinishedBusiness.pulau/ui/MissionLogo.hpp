//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

#include "CustomControlClasses.hpp"
class MissionLogo
{
	idd = 2772;
	
	class ControlsBackground
	{
		
	};
	class Controls
	{
		class lblText
		{
			type = 0;
			idc = 2700;
			x = safeZoneX + safeZoneW * 0.31835938;
			y = safeZoneY + safeZoneH * 0.27430556;
			w = safeZoneW * 0.36328125;
			h = safeZoneH * 0.03819445;
			style = 0+2;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 1;
		};
		
		class imgLogo : RscPicture 
		{
			idc = 2710;
			x = safeZoneX + safeZoneW * 0.29125;
			y = safeZoneY + safeZoneH * 0.21555556;
			w = safeZoneW * 0.4225;
			h = safeZoneH * 0.57;
			text = "";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		
	};
	
};
