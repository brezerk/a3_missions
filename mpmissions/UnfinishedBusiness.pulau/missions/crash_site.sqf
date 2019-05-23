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
		
		[
			player,
			"t_crash_site",
			[localize "TASK_04_DESC",
			localize "TASK_04_TITLE",
			localize "TASK_ORIG_01"],
			objNull,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_crash_site', "unknown"] call BIS_fnc_taskSetType;
		
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
		for "_i" from 1 to 3 do {
			_boom = createVehicle ["Sh_120mm_HE", _markerPos, [], 0, "FLY"];
			_boom setPos [((getPos _boom select 0) + (round(random 10) - 5)), ((getPos _boom select 1) + (round(random 10) - 5)), 250];
			_boom setVelocity [0,0,-50];
			sleep 1;
		};
		
		"Crater" createVehicle (_markerPos); 
		_obj = "Land_Wreck_Plane_Transport_01_F" createVehicle (_markerPos); 
		//test_EmptyObjectForSmoke
		_fire = "test_EmptyObjectForFireBig" createVehicle (_markerPos); 
		_fire attachTo [_obj, [0, 0, 0]];
		
		[_markerPos] remoteExec ["Fn_Task_C130J_CrashSite_Info"];
	};
};