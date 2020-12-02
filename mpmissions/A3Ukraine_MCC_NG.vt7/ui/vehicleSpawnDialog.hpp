//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

#include "CustomControlClasses.hpp"
class vehicleSpawnDialog
{
	idd = 3873;
	
	class ControlsBackground
	{
		
	};
	class Controls
	{
		class bkrDialog : IGUIBack 
		{
			idc = 1901;
			x = safeZoneX + safeZoneW * 0.323125;
			y = safeZoneY + safeZoneH * 0.25333334;
			w = safeZoneW * 0.36125;
			h = safeZoneH * 0.52;
			colorBackground[] = {0,0,0,0.7};
			
		};
		class frmGeneral : RscFrame 
		{
			idc = 1900;
			x = safeZoneX + safeZoneW * 0.329375;
			y = safeZoneY + safeZoneH * 0.26333334;
			w = safeZoneW * 0.3475;
			h = safeZoneH * 0.19777779;
			text = "";
			
		};
		class frmAdvanced : RscFrame 
		{
			idc = 1900;
			x = safeZoneX + safeZoneW * 0.329375;
			y = safeZoneY + safeZoneH * 0.46444446;
			w = safeZoneW * 0.3475;
			h = safeZoneH * 0.24333333;
			text = "";
			
		};
		class lblFaction : RscText 
		{
			idc = 1100;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.26444445;
			w = safeZoneW * 0.345625;
			h = safeZoneH * 0.02222223;
			text = "$STR_FROM_02_INFO_01";
			
		};
		class cbFaction : RscCombo 
		{
			idc = 2201;
			x = safeZoneX + safeZoneW * 0.333125;
			y = safeZoneY + safeZoneH * 0.29777778;
			w = safeZoneW * 0.339375;
			h = safeZoneH * 0.02222223;
			onLBSelChanged = "execVM 'ui\vehicleSpawnDialog_factionSelectionChanged.sqf';";
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class lblClass : RscText 
		{
			idc = 1101;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.33111112;
			w = safeZoneW * 0.35125;
			h = safeZoneH * 0.02222223;
			text = "$STR_FROM_02_INFO_02";
			
		};
		class cbClass : RscCombo 
		{
			idc = 2200;
			x = safeZoneX + safeZoneW * 0.333125;
			y = safeZoneY + safeZoneH * 0.36333334;
			w = safeZoneW * 0.33875;
			h = safeZoneH * 0.02222223;
			onLBSelChanged = "execVM 'ui\vehicleSpawnDialog_factionSelectionChanged.sqf';";
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		
		class lblVehicle : RscText 
		{
			idc = 1102;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.39777779;
			w = safeZoneW * 0.35125;
			h = safeZoneH * 0.02222223;
			text = "$STR_FROM_02_INFO_02";
			
		};
		class cbVehicle : RscCombo 
		{
			idc = 2202;
			x = safeZoneX + safeZoneW * 0.333125;
			y = safeZoneY + safeZoneH * 0.42888890;
			w = safeZoneW * 0.33875;
			h = safeZoneH * 0.02222223;
			onLBSelChanged = "execVM 'ui\vehicleSpawnDialog_vehicleSelectionChanged.sqf';";
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		
		class imgLogo : RscPicture 
		{
			idc = 2210;
			x = safeZoneX + safeZoneW * 0.333125;
			y = safeZoneY + safeZoneH * 0.45753781;
			w = safeZoneW * 0.16796875;
			h = safeZoneH * 0.25694445;
			colorBackground[] = {0.502,0.502,0.502,1};
			text = "";
		};
		
		class lblVehicleInfo : RscText 
		{
			idc = 1202;
			style = 0+16;
			x = safeZoneX + safeZoneW * 0.503125;
			y = safeZoneY + safeZoneH * 0.47257111;
			w = safeZoneW * 0.16796875;
			h = safeZoneH * 0.25694445;
			text = "$STR_FROM_01_INFO_05";
		};
		
		class bntSpawn : RscButton 
		{
			idc = 1800;
			x = safeZoneX + safeZoneW * 0.333125;
			y = safeZoneY + safeZoneH * 0.72222223;
			w = safeZoneW * 0.340625;
			h = safeZoneH * 0.03333334;
			text = "$STR_FROM_02_CMD_01";
			colorBackground[] = {0,0,0,0.9};
			colorBackgroundActive[] = {0.1569,0.5882,0.1569,1};
			action = "execVM 'ui\vehicleSpawnDialog_spawn.sqf';";
			
		};
		
		/*
		class lblMedical01 : RscText 
		{
			idc = 1102;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.42222223;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.02222223;
			text = "$STR_ACE_Medical_Treatment_AdvancedBandages_DisplayName";
			tooltip = "$STR_ACE_Medical_Treatment_AdvancedBandages_Description";
		};
		class cbMedical01 : RscCombo 
		{
			idc = 2202;
			x = safeZoneX + safeZoneW * 0.333125;
			y = safeZoneY + safeZoneH * 0.45555556;
			w = safeZoneW * 0.164375;
			h = safeZoneH * 0.02222223;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		
		class lblMedical02 : RscText 
		{
			idc = 1102;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.49555556;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.02222223;
			text = "$STR_ACE_Medical_Treatment_HolsterRequired_DisplayName";
			tooltip = "$STR_ACE_Medical_Treatment_HolsterRequired_Description";
			
		};
		class cbMedical02 : RscCombo 
		{
			idc = 2203;
			x = safeZoneX + safeZoneW * 0.333125;
			y = safeZoneY + safeZoneH * 0.52888889;
			w = safeZoneW * 0.164375;
			h = safeZoneH * 0.02222223;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		
		class cbFractionWest : RscCombo 
		{
			idc = 2205;
			x = safeZoneX + safeZoneW * 0.508125;
			y = safeZoneY + safeZoneH * 0.45555556;
			w = safeZoneW * 0.164375;
			h = safeZoneH * 0.02222223;
			onLBSelChanged = "execVM 'ui\settingsDialog_cbFactionChanged.sqf';";
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class lblFractionClass : RscText 
		{
			idc = 1102;
			x = safeZoneX + safeZoneW * 0.503125;
			y = safeZoneY + safeZoneH * 0.49555556;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.02222223;
			text = "$STR_FROM_01_INFO_06";
			
		};
		class cbFractionClass : RscCombo 
		{
			idc = 2206;
			x = safeZoneX + safeZoneW * 0.508125;
			y = safeZoneY + safeZoneH * 0.52888889;
			w = safeZoneW * 0.165;
			h = safeZoneH * 0.02222223;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		*/
		/*
		class lblFractionIndep : RscText 
		{
			idc = 1002;
			x = safeZoneX + safeZoneW * 0.503125;
			y = safeZoneY + safeZoneH * 0.56888889;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.02222223;
			text = "$STR_FROM_01_INFO_07";
			
		};
		class cbFractionIndep : RscCombo 
		{
			idc = 2107;
			x = safeZoneX + safeZoneW * 0.508125;
			y = safeZoneY + safeZoneH * 0.60222223;
			w = safeZoneW * 0.164375;
			h = safeZoneH * 0.02222223;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class lblFractionCiv : RscText 
		{
			idc = 1002;
			x = safeZoneX + safeZoneW * 0.503125;
			y = safeZoneY + safeZoneH * 0.64222223;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.02222223;
			text = "$STR_FROM_01_INFO_08";
			
		};
		class cbFractionCiv : RscCombo 
		{
			idc = 2108;
			x = safeZoneX + safeZoneW * 0.508125;
			y = safeZoneY + safeZoneH * 0.67555556;
			w = safeZoneW * 0.164375;
			h = safeZoneH * 0.02222223;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		
		class lblMedical03 : RscText 
		{
			idc = 1102;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.56888889;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.02222223;
			text = "$STR_ACE_Medical_Fractures_DisplayName";
			tooltip = "$STR_ACE_Medical_Fractures_Description";
			
		};
		class cbMedical03 : RscCombo 
		{
			idc = 2204;
			x = safeZoneX + safeZoneW * 0.333125;
			y = safeZoneY + safeZoneH * 0.60222223;
			w = safeZoneW * 0.164375;
			h = safeZoneH * 0.02222223;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class lblMedical04 : RscText 
		{
			idc = 1102;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.64222223;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.02222223;
			text = "$STR_ACE_Medical_Limping_DisplayName";
			tooltip = "$STR_ACE_Medical_Limping_Description";
		};
		class cbMedical04 : RscCombo 
		{
			idc = 2209;
			x = safeZoneX + safeZoneW * 0.333125;
			y = safeZoneY + safeZoneH * 0.67555556;
			w = safeZoneW * 0.164375;
			h = safeZoneH * 0.02222223;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		*/
		class bkrCaption : IGUIBack 
		{
			idc = 1901;
			x = safeZoneX + safeZoneW * 0.323125;
			y = safeZoneY + safeZoneH * 0.22777778;
			w = safeZoneW * 0.36125;
			h = safeZoneH * 0.02444445;
			colorBackground[] = {0.1569,0.5882,0.1569,1};
			
		};
		class lblCaption : RscText 
		{
			idc = 1100;
			x = safeZoneX + safeZoneW * 0.3275;
			y = safeZoneY + safeZoneH * 0.22777778;
			w = safeZoneW * 0.345625;
			h = safeZoneH * 0.02222223;
			text = "$STR_ONLOAD_NAME";
			
		};
		
	};
	
};
