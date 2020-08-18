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
		[0, 5] execVM "addons\BrezBlock.framework\utils\fade.sqf";
		moveOut player;
	};
		
	Fn_Local_Jet_Player_DoParadrop = {
		params ['_diffclty'];
		//do some damage
		if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
			private _dmgType = ["leg_l", "leg_r", "hand_r", "hand_l"];
			for "_i" from 0 to (random 2) do {
				[player, ((random 2) + 1), (selectRandom _dmgType), "stab"] call ace_medical_fnc_addDamageToUnit;
			};
		};
		[1, 3] execVM "addons\BrezBlock.framework\utils\fade.sqf";
		player setUnconscious true;
		[_diffclty] execVM "UnfinishedBusiness.core\gear\player.sqf";
	};
	
	Fn_Local_Jet_Player_DoPreason = {
		params ['_diffclty'];
		//do some damage
		[_diffclty] execVM "UnfinishedBusiness.core\gear\prisoner.sqf";
		if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
			private _dmgType = ["leg_l", "leg_r", "hand_r", "hand_l"];
			for "_i" from 0 to (random 1) do {
				[player, ((random 2) + 1), (selectRandom _dmgType), "stab"] call ace_medical_fnc_addDamageToUnit;
			};
		};
		[player, true] remoteExec ["setCaptive",0];
		[player, "Acts_AidlPsitMstpSsurWnonDnon_loop"] remoteExec ["switchMove",0];
		[
			player,
			"Cut Binds",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",
			"true",
			"true",
			{},
			{},
			{
				[player, false] remoteExec ["setCaptive", 0];
				[player, "Acts_AidlPsitMstpSsurWnonDnon_out"] remoteExec ["switchMove",0];
			},
			{},
			[],
			5,
			10,
			true,
			false
		] call BIS_fnc_holdActionAdd;
		[1, 3] execVM "addons\BrezBlock.framework\utils\fade.sqf";
	};
		
	Fn_Local_Jet_Player_Land = {
		call Fn_Local_MissionIntro_Fail;
		//if ((side player) == west) then {
			call Fn_Local_Create_Mission_CrashSite;
		//};
		if (player getVariable ["is_assault_group", false]) then {
			player setUnconscious false;
			call Fn_Local_Create_RegroupMission;
		};
	};
};
