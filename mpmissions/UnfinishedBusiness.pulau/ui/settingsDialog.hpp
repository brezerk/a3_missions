/***************************************************************************
 *   Copyright (C) 2008-2019 by Oleksii S. Malakhov <brezerk@gmail.com>    *
 *                                                                         *
 *   This program is free software: you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation, either version 3 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>. *
 *                                                                         *
 ***************************************************************************/

/*
Settings dialog control
// GUI EDITOR OUTPUT (by brezerk, v1.063, #Banake)
*/

//FIXME: remove RscText;

class SettingsDialogControl {
	idd = 3773;
	class controls {
		class frmDialog: RscFrame
		{
			idc = 1800;
			x = 0.417501 * safezoneW + safezoneX;
			y = 0.368 * safezoneH + safezoneY;
			w = 0.211406 * safezoneW;
			h = 0.209 * safezoneH;
			colorBackground[] = 
			{
				0,
				0,
				0,
				0.8
			};
		};
		class lxlDifficlty: RscText
		{
			idc = 1000;
			text = "Select difficlty level:"; //--- ToDo: Localize;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.195937 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class lblLocation: RscText
		{
			idc = 1001;
			text = "Select mission location:"; //--- ToDo: Localize;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.201094 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class cbLocation: RscCombo
		{
			idc = 2100;
			text = "Random"; //--- ToDo: Localize;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.478 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class cbDifficlty: RscCombo
		{
			idc = 2101;
			text = "Easy"; //--- ToDo: Localize;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class bntStart: RscButton
		{
			idc = 1600;
			text = "Start mission"; //--- ToDo: Localize;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.190781 * safezoneW;
			h = 0.033 * safezoneH;
			action = "execVM 'ui\applySettings.sqf';";
		};
	};

};

