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
Init mission file
*/

#include "..\config\realm.sqf";

real_weather_init = false;

// Check mods if loaded
D_MOD_ACE = isClass(configFile >> "CfgPatches" >> "ace_main");
D_MOD_ACE_MEDICAL = isClass(configFile >> "CfgPatches" >> "ace_medical");
D_MOD_ACEX = isClass(configFile >> "CfgPatches" >> "acex_field_rations");
D_MOD_CBA = isClass(configFile >> "CfgPatches" >> "cba_main");

D_MOD_ACRE = isClass(configFile >> "CfgPatches" >> "acre_main");
D_MOD_TFAR = isClass(configFile >> "CfgPatches" >> "task_force_radio");

D_MOD_CUP_VEHICLES = isClass(configFile >> "CfgPatches" >> "cup_vehicles");

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
	D_LOCATION = "Altis";
	D_GAME_LOCATIONS = [];
	D_START_TYPE = nil;
	D_PING_TIMEOUT = 30;
	D_PING_RANGE = 150;
	
	D_ADD_INTEL_ACTION = [east, independent, west];
	
	D_FRACTION_WEST = nil;
	
	D_FRACTION_WEST_UNITS_TRANSPORT = [];
	D_FRACTION_WEST_UNITS_HELI = [];
	D_FRACTION_WEST_UNITS_BOATS = [];

	D_FRACTION_INDEP = nil;
	
	D_FRACTION_INDEP_UNITS_PATROL = [];
	D_FRACTION_INDEP_UNITS_GARRISON = [];
	D_FRACTION_INDEP_UNITS_CARS = [];
	D_FRACTION_INDEP_UNITS_LIGHT = [];
	D_FRACTION_INDEP_UNITS_HEAVY = [];
	D_FRACTION_INDEP_UNITS_TRANSPORT = [];
	
	D_FRACTION_EAST = nil;
	
	D_FRACTION_EAST_UNITS_PATROL = [];
	D_FRACTION_EAST_UNITS_GARRISON = [];
	D_FRACTION_EAST_UNITS_CARS = [];
	D_FRACTION_EAST_UNITS_LIGHT = [];
	D_FRACTION_EAST_UNITS_HEAVY = [];
	D_FRACTION_EAST_UNITS_TRANSPORT = [];
	
	D_FRACTION_CIV = nil;
	
	D_FRACTION_CIV_UNITS_MENS = [];
	D_FRACTION_CIV_UNITS_CARS = [];
	D_FRACTION_CIV_UNITS_BOATS = [];

	// Global variables	
	mission_requested = false;
		
	//public basic variables
	publicVariable "D_LOCATION";
	publicVariable "D_FRACTION_WEST";
	publicVariable "D_FRACTION_EAST";
	publicVariable "D_FRACTION_INDEP";
	publicVariable "D_FRACTION_CIV";
	publicVariable "mission_requested";
	
	//#include "config\items.sqf";
	//#include "config\stash.sqf";
	//#include "config\fractions.sqf"; 
	
	waitUntil {real_weather_init};
	
	// skip random time
	skipTime ((random 3));
	
	#include "..\addons\code43\oop.h\oop.h"
	#include "classes\city.sqf"
	
	[] execVM "Crossfire.core\planning.sqf";
	
	waitUntil {
		sleep 3;
		systemChat "Wait...";
		mission_requested;
	};
};