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

missionNamespace setVariable ["bg_spectator_enabled", false];
missionNamespace setVariable ["CasualGame", false];

#include "config\realm.sqf";

bg_spectator_enabled = false;
real_weather_init = false;
D_LOCATION = nil;

//disable targets from moving automatically
nopop = true;

[] execVM "addons\code43\real_weather\real_weather.sqf";

if (isServer) then {

	_westHQ = createCenter west;
	_eastHQ = createCenter east;
	_indepHQ = createCenter independent;
	_civilianHQ = createCenter civilian;
	
	waitUntil {real_weather_init};

	{ private _marker = _x; { _x  setFlagTexture "addons\apl\data\uaflag.paa"; } forEach ((getMarkerPos _marker) nearObjects ["FlagPole_F", 500]) } forEach ["wp_main", "wp_sso"];
	
	waitUntil {time > 10};
		
};
