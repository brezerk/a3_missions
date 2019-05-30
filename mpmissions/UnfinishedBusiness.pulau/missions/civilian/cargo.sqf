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
Spawn start objectives, triggers for informator contact
*/

//Player side triggers
// Client side code

	Fn_Task_Civilian_FloodedShip_Info = {
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


if (isServer) then {
	Fn_Task_Create_Civilian_FloodedShip = {
		params ["_markerPos"];
		private ["_obj"];

		//spawn creater and wreck
		"Crater" createVehicle (_markerPos); 
		_obj = "Land_Wreck_Traw2_F" createVehicle ([((_markerPos select 0) + 10), ((_markerPos select 1) + 10), ((_markerPos select 2))]); 
		_obj = "Land_Wreck_Traw_F" createVehicle ([((_markerPos select 0) + 10), ((_markerPos select 1) + 10), ((_markerPos select 2))]); 
		
		/* does not seems to be working now?
		_fire = "ModuleEffectsSmoke_F" createVehicle (_markerPos); 
		_fire setVariable ["ParticleDensity",40 ,true];
		_fire setVariable ["ParticleSize", 15,true];
		_fire setVariable ["EffectSize", 5, true];
		_fire setVariable ["ParticleLifeTime", 180, true];
		*/
		
		[_markerPos] remoteExec ["Fn_Task_Civilian_FloodedShip_Info"];
	};
};