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

if (hasInterface) then {
	Fn_Local_Jet_GetOut = {
		[0, 5] execVM "addons\brezblock\utils\fade.sqf";
		//doGetOut player;
		moveOut player;
	};
		
	Fn_Local_Jet_Player_DoParadrop = {
		params ['_diffclty'];
		private ['_dmgType'];
		//do some damage
		if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
			_dmgType = ["leg_l", "leg_r", "hand_r", "hand_l", "head"];
			[player, 1, selectRandom _dmgType, "bullet"] call ace_medical_fnc_addDamageToUnit;
		};
		[1, 3] execVM "addons\brezblock\utils\fade.sqf";
		player setUnconscious true;
		[_diffclty] execVM "gear\player.sqf";
	};
		
	Fn_Local_Jet_Player_Land = {
		call Fn_Local_MissionIntro_Fail;
		player setUnconscious false;
		call Fn_Local_Create_Mission_CrashSite;
		call Fn_Local_Create_RegroupMission;
	};
};