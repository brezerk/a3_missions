/***************************************************************************************
 * Copyright (C) 2008-2020 by Oleksii S. Malakhov <brezerk@gmail.com>                  *
 *                                                                                     *
 * This program is is licensed under a                                                 *
 * Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. *
 *                                                                                     *
 * You should have received a copy of the license along with this                      *
 * work. If not, see <http://creativecommons.org/licenses/by-nc-nd/4.0/>.              *
 *                                                                                     *
 **************************************************************************************/

#include "config\realm.sqf";

real_weather_init = false;
D_LOCATION = nil;

[] execVM "addons\code43\real_weather\real_weather.sqf";

if (isServer) then {

	_westHQ = createCenter west;
	_eastHQ = createCenter east;
	_indepHQ = createCenter independent;
	_civilianHQ = createCenter civilian;
	
	waitUntil {real_weather_init};
	
	{ { _x  setFlagTexture "addons\apl\data\uaflag.paa"; } forEach ((getMarkerPos _x) nearObjects ["FlagPole_F", 150]) } forEach ["wp_main"];
	
	waitUntil {time > 10};
		
};
