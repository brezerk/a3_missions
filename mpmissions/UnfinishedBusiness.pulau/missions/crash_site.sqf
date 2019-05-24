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
Crash site side-mission code
*/

// Intended to be executed on player side
Fn_Task_C130J_CrashSite_Info = {
	if (!isDedicated) then {
		params['_markerPos'];
		private ["_trg"];
				
		_trg = createTrigger ["EmptyDetector", _markerPos];
		_trg setTriggerArea [50, 50, 0, false];
		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		_trg setTriggerStatements [
			"(vehicle player) in thisList",
			"[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_01', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;",
			""
		];
		
		_trg = createTrigger ["EmptyDetector", _markerPos];
		_trg setTriggerArea [18, 18, 0, false];
		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
		_trg setTriggerStatements [
			"this",
			"['t_crash_site', 'SUCCEEDED'] call BIS_fnc_taskSetState;",
			""
		];
	};
};

// Server-only code
if (isServer) then {
	/*
	Spawn random heli crash site
		Arguments: None
		Usage: call Fn_Task_Create_HelicopterCrashSite
	*/
	Fn_Task_Create_C130J_CrashSite = {
		params ["_markerPos"];
		
		//do envonmental damage
		for "_i" from 1 to 5 do {
			_boom = createVehicle ["Sh_120mm_HE", _markerPos, [], 0, "FLY"];
			_boom setPos [((getPos _boom select 0) + (round(random 25) - 10)), ((getPos _boom select 1) + (round(random 25) - 10)), 250];
			_boom setVelocity [0,0,-50];
			sleep 1;
		};
		
		//let is fall
		sleep 1;
		
		//spawn creater and wreck
		"Crater" createVehicle (_markerPos); 
		_obj = "Land_Wreck_Plane_Transport_01_F" createVehicle (_markerPos); 
		//put fire and smoke
		_fire = "test_EmptyObjectForFireBig" createVehicle (_markerPos); 
		_fire attachTo [_obj, [0, 0, 0]];
		
		/* does not seems to be working now?
		_fire = "ModuleEffectsSmoke_F" createVehicle (_markerPos); 
		_fire setVariable ["ParticleDensity",40 ,true];
		_fire setVariable ["ParticleSize", 15,true];
		_fire setVariable ["EffectSize", 5, true];
		_fire setVariable ["ParticleLifeTime", 180, true];
		*/
		
		[_markerPos] remoteExec ["Fn_Task_C130J_CrashSite_Info"];
	};
};