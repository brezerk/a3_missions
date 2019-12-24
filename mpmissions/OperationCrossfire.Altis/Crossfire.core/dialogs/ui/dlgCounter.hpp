//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

#include "CustomControlClasses.hpp"
class dlgCounter
{
	idd = -1;
	fadein = 0;
	fadeout = 0;
	duration = 1e+1000;
	onLoad = "uiNamespace setVariable ['ui_score', _this select 0]";
	class ControlsBackground
	{
		
	};
	class Controls
	{
		class frmCounter
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.00097657;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.87597657;
			h = safeZoneH * 0.03819445;
			style = 0+128;
			text = "";
			colorBackground[] = {0,0,0,0.3};
			colorText[] = {0.6314,0.8235,0.9765,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class imgMoney
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.02539063;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.02148438;
			h = safeZoneH * 0.03819445;
			style = 48+2;
			text = "Crossfire.core\data\icons\icon64bank.paa";
			colorBackground[] = {0.702,0.902,0.702,1};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class lblMoney
		{
			type = 0;
			idc = 3701;
			x = safeZoneX + safeZoneW * 0.04980469;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.09472657;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class lblMedical
		{
			type = 0;
			idc = 3703;
			x = safeZoneX + safeZoneW * 0.29394532;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.0703125;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "100 (+0)";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class imgMedical
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.26953125;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.02148438;
			h = safeZoneH * 0.03819445;
			style = 48+2;
			text = "Crossfire.core\data\icons\icon64injured.paa";
			colorBackground[] = {1,0.6,0.6,1};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class imgFuel
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.3671875;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.02148438;
			h = safeZoneH * 0.03819445;
			style = 48+2;
			text = "Crossfire.core\data\icons\icon64bank.paa";
			colorBackground[] = {0.702,0.8,1,1};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class lblFuel
		{
			type = 0;
			idc = 3704;
			x = safeZoneX + safeZoneW * 0.39160157;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.0703125;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "100 (+0)";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class imgResources
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.46484375;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.02148438;
			h = safeZoneH * 0.03819445;
			style = 48+2;
			text = "Crossfire.core\data\icons\icon64castle.paa";
			colorBackground[] = {0,0,0,1};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class lblResources
		{
			type = 0;
			idc = 3705;
			x = safeZoneX + safeZoneW * 0.48925782;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.0703125;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "100 (+0)";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class imgFood
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.5625;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.02148438;
			h = safeZoneH * 0.03819445;
			style = 48+2;
			text = "Crossfire.core\data\icons\icon64bank.paa";
			colorBackground[] = {0.702,0.902,0.702,1};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class lblFood
		{
			type = 0;
			idc = 3706;
			x = safeZoneX + safeZoneW * 0.58691407;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.0703125;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "100 (+0)";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class imgMoneyPersonal
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.171875;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.02148438;
			h = safeZoneH * 0.03819445;
			style = 48+2;
			text = "Crossfire.core\data\icons\icon64coin.paa";
			colorBackground[] = {0,0,0,1};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class lblMoneyPersonal
		{
			type = 0;
			idc = 3702;
			x = safeZoneX + safeZoneW * 0.19628907;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.0703125;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "100500 $";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class imgScouts
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.66015625;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.02148438;
			h = safeZoneH * 0.03819445;
			style = 48+2;
			text = "Crossfire.core\data\icons\icon64swords.paa";
			colorBackground[] = {0,0,0,1};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class lblScouts
		{
			type = 0;
			idc = 3707;
			x = safeZoneX + safeZoneW * 0.68457032;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.04589844;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "0 / 4";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class imgRank
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.73339844;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.02148438;
			h = safeZoneH * 0.03819445;
			style = 48+2;
			text = "Crossfire.core\data\icons\icon64shield.paa";
			colorBackground[] = {0,0,0,1};
			colorText[] = {0.949,0.949,0.949,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class lblRank
		{
			type = 0;
			idc = 3708;
			x = safeZoneX + safeZoneW * 0.7578125;
			y = safeZoneY + safeZoneH * 0.00694445;
			w = safeZoneW * 0.11914063;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "Private";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		
	};
	
};


