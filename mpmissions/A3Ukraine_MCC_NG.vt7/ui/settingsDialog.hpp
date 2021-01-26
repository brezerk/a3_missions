//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

#include "CustomControlClasses.hpp"
class SettingsDialog
{
	idd = 3773;
	onUnload = "params ['_display', '_exitCode']; if (isNil 'D_ROLE') then { [_exitCode] execVM 'ui\SettingsDialogHandler.sqf'; };";
	
	class ControlsBackground
	{
		
	};
	class Controls
	{
		class bkrDialog : BB_IGUIBack 
		{
			idc = 1801;
			x = safeZoneX + safeZoneW * 0.323125;
			y = safeZoneY + safeZoneH * 0.25333334;
			w = safeZoneW * 0.36125;
			h = safeZoneH * 0.52;
			colorBackground[] = {0,0,0,0.7};
			
		};
		class frmGeneral : BB_RscFrame 
		{
			idc = 1800;
			x = safeZoneX + safeZoneW * 0.329375;
			y = safeZoneY + safeZoneH * 0.26333334;
			w = safeZoneW * 0.3475;
			h = safeZoneH * 0.14444445;
			text = "";
			
		};
		class frmFractions : BB_RscFrame 
		{
			idc = 1800;
			x = safeZoneX + safeZoneW * 0.504375;
			y = safeZoneY + safeZoneH * 0.41;
			w = safeZoneW * 0.1725;
			h = safeZoneH * 0.3;
			text = "";
			
		};
		class frmAdvanced : BB_RscFrame 
		{
			idc = 1800;
			x = safeZoneX + safeZoneW * 0.329375;
			y = safeZoneY + safeZoneH * 0.41;
			w = safeZoneW * 0.1725;
			h = safeZoneH * 0.3;
			text = "";
			
		};
		class lblDifficlty : BB_RscText 
		{
			idc = 1000;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.26444445;
			w = safeZoneW * 0.345625;
			h = safeZoneH * 0.02222223;
			text = "$STR_FROM_01_INFO_01";
			
		};
		class lblLocation : BB_RscText 
		{
			idc = 1001;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.33111112;
			w = safeZoneW * 0.35125;
			h = safeZoneH * 0.02222223;
			text = "$STR_FROM_01_INFO_02";
			
		};
		class cbLocation : BB_RscCombo 
		{
			idc = 2100;
			x = safeZoneX + safeZoneW * 0.333125;
			y = safeZoneY + safeZoneH * 0.36333334;
			w = safeZoneW * 0.33875;
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
		class cbDifficlty : BB_RscCombo 
		{
			idc = 2101;
			x = safeZoneX + safeZoneW * 0.333125;
			y = safeZoneY + safeZoneH * 0.29777778;
			w = safeZoneW * 0.339375;
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
		class lblMedical01 : BB_RscText 
		{
			idc = 1002;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.42222223;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.02222223;
			text = "$STR_ACE_Medical_Treatment_AdvancedBandages_DisplayName";
			tooltip = "$STR_ACE_Medical_Treatment_AdvancedBandages_Description";
		};
		class cbMedical01 : BB_RscCombo 
		{
			idc = 2102;
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
		class bntStart : BB_RscButton 
		{
			idc = 1600;
			x = safeZoneX + safeZoneW * 0.333125;
			y = safeZoneY + safeZoneH * 0.72222223;
			w = safeZoneW * 0.340625;
			h = safeZoneH * 0.03333334;
			text = "$STR_FROM_01_CMD_01";
			colorBackground[] = {0,0,0,0.9};
			colorBackgroundActive[] = {0.1569,0.5882,0.1569,1};
			action = "execVM 'ui\applySettings.sqf';";
			
		};
		class lblMedical02 : BB_RscText 
		{
			idc = 1002;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.49555556;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.02222223;
			text = "$STR_ACE_Medical_Treatment_HolsterRequired_DisplayName";
			tooltip = "$STR_ACE_Medical_Treatment_HolsterRequired_Description";
			
		};
		class cbMedical02 : BB_RscCombo 
		{
			idc = 2103;
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
		class lblFractionWest : BB_RscText 
		{
			idc = 1002;
			x = safeZoneX + safeZoneW * 0.503125;
			y = safeZoneY + safeZoneH * 0.42222223;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.02222223;
			text = "$STR_FROM_01_INFO_05";
			
		};
		class cbFractionWest : BB_RscCombo 
		{
			idc = 2105;
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
		class lblFractionClass : BB_RscText 
		{
			idc = 1002;
			x = safeZoneX + safeZoneW * 0.503125;
			y = safeZoneY + safeZoneH * 0.49555556;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.02222223;
			text = "$STR_FROM_01_INFO_06";
		};
		class cbFractionClass : BB_RscCombo 
		{
			idc = 2106;
			x = safeZoneX + safeZoneW * 0.508125;
			y = safeZoneY + safeZoneH * 0.52888889;
			w = safeZoneW * 0.165;
			h = safeZoneH * 0.02222223;
			onLBSelChanged = "execVM 'ui\settingsDialog_vehicleSelectionChanged.sqf';";
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		
		class lblVehicleInfo : BB_RscText 
		{
			idc = 1003;
			style = 0+16;
			x = safeZoneX + safeZoneW * 0.503125;
			y = safeZoneY + safeZoneH * 0.56888889;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.12847222;
			text = "";
			
		};
		/*
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
		*/
		class lblMedical03 : BB_RscText 
		{
			idc = 1002;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.56888889;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.02222223;
			text = "$STR_ACE_Medical_Fractures_DisplayName";
			tooltip = "$STR_ACE_Medical_Fractures_Description";
			
		};
		class cbMedical03 : BB_RscCombo 
		{
			idc = 2104;
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
		class lblMedical04 : BB_RscText 
		{
			idc = 1002;
			x = safeZoneX + safeZoneW * 0.328125;
			y = safeZoneY + safeZoneH * 0.64222223;
			w = safeZoneW * 0.170625;
			h = safeZoneH * 0.02222223;
			text = "$STR_ACE_Medical_Limping_DisplayName";
			tooltip = "$STR_ACE_Medical_Limping_Description";
		};
		class cbMedical04 : BB_RscCombo 
		{
			idc = 2109;
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
		class bkrCaption : BB_IGUIBack 
		{
			idc = 1801;
			x = safeZoneX + safeZoneW * 0.323125;
			y = safeZoneY + safeZoneH * 0.22777778;
			w = safeZoneW * 0.36125;
			h = safeZoneH * 0.02444445;
			colorBackground[] = {0.1569,0.5882,0.1569,1};
			
		};
		class lblCaption : BB_RscText 
		{
			idc = 1000;
			x = safeZoneX + safeZoneW * 0.3275;
			y = safeZoneY + safeZoneH * 0.22777778;
			w = safeZoneW * 0.345625;
			h = safeZoneH * 0.02222223;
			text = "$STR_ONLOAD_NAME";
			
		};
		
	};
	
};
