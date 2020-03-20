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

[stup, 30, "SmokeShell", 0.8] execvm "AL_swarmer\al_hive.sqf";

if (isServer) then {
	// ACTIVE DURING NITGHT AND DAY
	["wp_strigoi_1",100,true,0.1,50] execvm "AL_strigoi\strigoi.sqf";
	["wp_strigoi_2",100,true,0.1,50] execvm "AL_strigoi\strigoi.sqf";
	["wp_strigoi_3",100,true,0.1,50] execvm "AL_strigoi\strigoi.sqf";
	["wp_strigoi_4",100,true,0.1,50] execvm "AL_strigoi\strigoi.sqf";
	["wp_strigoi_5",100,true,0.1,50] execvm "AL_strigoi\strigoi.sqf";
	["wp_strigoi_6",100,true,0.1,50] execvm "AL_strigoi\strigoi.sqf";
	["wp_strigoi_7",100,true,0.1,50] execvm "AL_strigoi\strigoi.sqf";
	
	{
		{ _x setFuelCargo 1000; } forEach (nearestObjects [getMarkerPos _x, ["Land_fs_feed_F"], 100]); 
    } forEach ["wp_fuel01", "wp_fuel02", "wp_fuel03", "wp_fuel04", "wp_fuel05"];
	
};

/*
while {true} do {
	if (isServer) then {
		my_dust_storm_duration = 240 + random 600;
		publicVariable "my_dust_storm_duration";
		pause_between_dust_storm = 240 + random 600;
		publicVariable "my_dust_storm_duration";
	};
	waitUntil {(!isNil "my_dust_storm_duration") and (!isNil "pause_between_dust_storm")};
	null = [340,my_dust_storm_duration,false,false,false,0.3] execvm "AL_dust_storm\al_duststorm.sqf";
	sleep (my_dust_storm_duration + pause_between_dust_storm);
};
*/
