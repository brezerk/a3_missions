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

//FIME: move to global common config

D_THREAT_CHEM_LOCAL = 0;
D_THREAT_CHEM_AREAL = 1;
D_THREAT_RAD_LOCAL  = 0;
bb_threat_chem_areas = [];
bb_threat_rad_areas  = [];
bb_srv_dmg_chem = 0;
bb_local_fog = 0;
bb_next_wave = false;

Fn_SetEnv = {
	null = [
		true, //boolean, if true snowflakes made out of particles will be created
		3000000, //number, life time of the SNOW STORM expressed in seconds
		30,   //seconds/number, a random number will be generated based on your input value and used to set the frequency for played ambient sounds
		true, //boolean, if true you will see breath vapors for all units, however if you have many units in your mission you should set this false to diminish the impact on frames
		15,    //seconds/number, if higher than 0 burst of snow will be generated at intervals based on your value
		false, //boolean, if is true occasionally a random object will be pushed by the wind during the snow burst if the later is enabled
		false, //boolean, vanilla fog will be managed by the script if true, otherwise the values you set in editor will be used 
		true, // boolean, if true particles will be used to create sort of waves of fog and snow
		true, //boolean, if is true the wind will blow with force otherwise default value from Eden or other script will be used
		true   //boolean, if is true the at random units will sneeze/caugh and will shiver when snow burst occurs
	] execVM "AL_snowstorm\al_snow.sqf";
	[emp_me,500,true,true,0] execVM 'AL_emp\emp_starter.sqf';
};

{
	[(markerPos _x), 10, 15, 1000, false] call BrezBlock_fnc_Systems_Refuel_Station;
} forEach ["wp_fuel_01", "wp_fuel_02", "wp_fuel_03", "wp_fuel_04", "wp_fuel_05", "wp_fuel_06"];


if (isServer) then {
	[120] spawn  BrezBlock_fnc_Utils_Garbage_Collector;
	
	//box00 addItemCargoGlobal ["rvg_antiRad", 10];
	
	box01 addItemCargoGlobal ["Mask_M40", 1];
	box01 addItemCargoGlobal ["Mask_M40_OD", 1];
	box01 addItemCargoGlobal ["Mask_M50", 1];

	box02 addItemCargoGlobal ["Mask_M40", 11];
	box02 addItemCargoGlobal ["Mask_M40_OD", 13];
	box02 addItemCargoGlobal ["Mask_M50", 8];
	box02 addItemCargoGlobal ["rvg_antiRad", 15];
	


	trgReSpawn01 = createTrigger ["EmptyDetector", getPos respawn01];
	trgReSpawn01 setTriggerArea [0, 0, 0, false];
	trgReSpawn01 setTriggerActivation ["NONE", "PRESENT", false];
	trgReSpawn01 setTriggerStatements [
			"!alive respawn01",
			"remoteExecCall ['Fn_Local_RespawnWave', [0,-2] select isDedicated];",
			""
	];

	trgReSpawn02 = createTrigger ["EmptyDetector", getPos respawn02];
	trgReSpawn02 setTriggerArea [0, 0, 0, false];
	trgReSpawn02 setTriggerActivation ["NONE", "PRESENT", false];
	trgReSpawn02 setTriggerStatements [
			"!alive respawn02",
			"remoteExecCall ['Fn_Local_RespawnWave', [0,-2] select isDedicated];",
			""
	];

	trgReSpawn03 = createTrigger ["EmptyDetector", getPos respawn03];
	trgReSpawn03 setTriggerArea [0, 0, 0, false];
	trgReSpawn03 setTriggerActivation ["NONE", "PRESENT", false];
	trgReSpawn03 setTriggerStatements [
			"!alive respawn03",
			"remoteExecCall ['Fn_Local_RespawnWave', [0,-2] select isDedicated];",
			""
	];

};
//

/*
[obj_haz01, 10, 0.05] spawn BrezBlock_fnc_Local_Systems_Chemical_Local;
//[obj_haz03, 10, 0.05] spawn BrezBlock_fnc_Local_Systems_Chemical_Local;
[obj_haz02, 200, 0.05] spawn BrezBlock_fnc_Local_Systems_Chemical_Areal;
//[obj_haz04, 200, 0.05] spawn BrezBlock_fnc_Local_Systems_Chemical_Areal;
*/


if (hasInterface) then {
	[obj_haz01, 1000, 0.05] spawn BrezBlock_fnc_Local_Systems_Chemical_Areal;
	[obj_haz02, 1000, 0.05] spawn BrezBlock_fnc_Local_Systems_Chemical_Areal;
	[obj_haz03, 1000, 0.05] spawn BrezBlock_fnc_Local_Systems_Chemical_Areal;
	{
		//null = [_x,15,0.05,"H_PilotHelmetFighter_B","Item_ChemicalDetector_01_watch_F",true,10,true] execVM "AL_radiation\radioactive_object.sqf";
		[_x, (10 + random(5)), 0.05] spawn BrezBlock_fnc_Local_Systems_Radiation_Local;
	} forEach [rad_01, rad_02, rad_03, rad_04, rad_05, rad_06, rad_07, rad_08];
};





//null = [rad_obj_02,15,0.05,"H_PilotHelmetFighter_B","Item_ChemicalDetector_01_watch_F",true,10,true] execVM "AL_radiation\radioactive_object.sqf";
//null = [rad_obj_03,15,0.05,"H_PilotHelmetFighter_B","Item_ChemicalDetector_01_watch_F",true,10,true] execVM "AL_radiation\radioactive_object.sqf";
//null = [rad_obj_01,30,0.02,"H_PilotHelmetFighter_B","Item_ChemicalDetector_01_watch_F",false,10,true] execvm "AL_radiation\radioactive_object.sqf";



/*
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
	
};*/



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
