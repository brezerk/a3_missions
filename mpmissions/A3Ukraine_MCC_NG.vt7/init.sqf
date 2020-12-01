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

#include "config\realm.sqf";

real_weather_init = false;

// Check mods if loaded
D_MOD_ACE = isClass(configFile >> "CfgPatches" >> "ace_main");
D_MOD_ACE_MEDICAL = isClass(configFile >> "CfgPatches" >> "ace_medical");
D_MOD_ACEX = isClass(configFile >> "CfgPatches" >> "acex_field_rations");
D_MOD_CBA = isClass(configFile >> "CfgPatches" >> "cba_main");

D_MOD_ACRE = isClass(configFile >> "CfgPatches" >> "acre_main");
D_MOD_TFAR = isClass(configFile >> "CfgPatches" >> "task_force_radio");
D_MOD_CUP_VEHICLES = isClass(configFile >> "CfgPatches" >> "CUP_Vehicles_Core");

D_MOD_RHS_AFRF = false; // tbd
D_MOD_RHS_USAF = false; // tbd
D_MOD_RHS_GREF = false; // tbd
D_MOD_RHS_SAF = false; // tbd

[] execVM "addons\code43\real_weather\real_weather.sqf";

if (isServer) then {

	_westHQ = createCenter west;
	_eastHQ = createCenter east;
	_indepHQ = createCenter independent;
	_civilianHQ = createCenter civilian;
	
	D_DIFFICLTY = nil;
	D_LOCATION = nil;
	D_START_TYPE = nil;
	
	// Global variables	
	mission_requested = false;
	mission_generated = false;
	
	/*
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		tf_give_personal_radio_to_regular_soldier = true;
		publicVariable "tf_give_personal_radio_to_regular_soldier";

		tf_no_auto_long_range_radio = true;
		publicVariable "tf_no_auto_long_range_radio";

		tf_same_sw_frequencies_for_side = true;
		publicVariable "tf_same_sw_frequencies_for_side";
		
		private _settingsSwWest = false call TFAR_fnc_generateSwSettings;
		_settingsSwWest set [2, ["311","312","313","314","315","316","317","318"]];
		tf_freq_west = _settingsSwWest;
		publicVariable "tf_freq_west";
		
		private _settingsSwEast = false call TFAR_fnc_generateSwSettings;
		_settingsSwEast set [2, ["101","110","117","134","195","131","171","188"]];
		tf_freq_east = _settingsSwEast;
		publicVariable "tf_freq_east";
	};*/
	

	waitUntil {real_weather_init};
	waitUntil {time > 10};
	//Fix MCC time multiplier issue
	//setTimeMultiplier 5;
	
	//{ { _x  setFlagTexture "addons\apl\data\uaflag.paa"; } forEach ((getPosATL _x) nearObjects ["FlagPole_F", 150]) } forEach [a3mcc_main];
	
	//upa_flag_01 setFlagTexture "addons\apl\data\upaflag.paa";
};
