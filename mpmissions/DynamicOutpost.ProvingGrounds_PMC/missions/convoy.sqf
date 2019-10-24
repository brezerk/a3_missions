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
Spawn start objectives, triggers and mainline story
*/

// Client side code
if (hasInterface) then {	
	// Intended to be executed on player side (but nit dedicated tho);
	Fn_Local_Task_Create_Convoy = {
		params ['_marker'];
		private ["_trg"];
		_trg = createTrigger ["EmptyDetector", getMarkerPos _marker];
		_trg setTriggerArea [100, 100, 0, false];
		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		_trg setTriggerStatements [
			"(vehicle player) in thisList",
			"[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_08', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;",
			""
		];
		[
			player,
			"t_ua_convoy_found",
			[localize "TASK_16_DESC",
			localize "TASK_16_TITLE",
			localize "TASK_ORIG_01"],
			getMarkerPos _marker,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_ua_convoy_found', "unknown"] call BIS_fnc_taskSetType;
		playSound "outpost_convoy";
		playSound "rhs_usa_land_rc_15";
	};
	
	Fn_Local_Task_Create_Convoy_DestroyHeavy = {
		[
			player,
			"t_ua_convoy_destroy_heavy",
			[localize "TASK_17_DESC",
			localize "TASK_17_TITLE",
			localize "TASK_ORIG_01"],
			getPos ua_heavy_02,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_ua_convoy_destroy_heavy', "destroy"] call BIS_fnc_taskSetType;
	};
};

if (isServer) then {
	Fn_Task_Create_Convoy = {
		//ua_convoy_01
		private ["_spawnposition"];
		_spawnposition = ["wp_ua_convoy", 6] call BrezBlock_fnc_Get_RND_Index;
		{
			private _type = typeName _x;
			if (_type == "GROUP") then {
				{
					_x setVariable ["BB_CorpseTTL", -1];
				} count units _x;
			};
		} forEach ([_spawnposition, "ua_convoy_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces_Guard);
		[_spawnposition] remoteExecCall ["Fn_Local_Task_Create_Convoy", [0,-2] select isDedicated];
		
		trgConvoyFound = createTrigger ["EmptyDetector", getMarkerPos _spawnposition];
		trgConvoyFound setTriggerArea [125, 125, 0, false];
		trgConvoyFound setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		trgConvoyFound setTriggerStatements [
			"this",
			"call Fn_Task_Create_Convoy_DestroyHeavy; deleteVehicle trgConvoyFound;",
			""
		];
		
		{
			if (_x inArea trgConvoyFound) then {
				_x setVariable ["BB_CorpseTTL", -1];
			};
		} count allDeadMen;

	}; // Fn_Task_Create_Convoy

	Fn_Task_Create_Convoy_DestroyHeavy = {
		private ["_affectedUnits"];
		_affectedUnits = [];
		['t_ua_convoy_found', 'Succeeded', localize 'TASK_16_TITLE'] remoteExecCall ['Fn_Local_SetPersonalTaskState', [0,-2] select isDedicated];
		[] remoteExecCall ["Fn_Local_Task_Create_Convoy_DestroyHeavy", [0,-2] select isDedicated];
		trgUralDestroyed = createTrigger ["EmptyDetector", getPos ua_heavy_02];
		trgUralDestroyed setTriggerArea [0, 0, 0, false];
		trgUralDestroyed setTriggerActivation ["NONE", "PRESENT", false];
		trgUralDestroyed setTriggerStatements [
			"!alive ua_heavy_02",
			"['t_ua_convoy_destroy_heavy', 'Succeeded', localize 'TASK_17_TITLE'] remoteExecCall ['Fn_Local_SetPersonalTaskState', [0,-2] select isDedicated]; deleteVehicle trgUralDestroyed;",
			""
		];
		// kill alive units if any
		{ if ((side _x) isEqualTo independent && _x distance ua_heavy_02 < 100) then { _affectedUnits pushBack _x; }; } forEach (allUnits - _affectedUnits);
		{ 
			//systemChat format ['OKAY! %1', _x distance ua_heavy_02];
			if (_x isKindOf 'Man') then { 
				[_x, 1.0, "body", "bullet"] call ace_medical_fnc_addDamageToUnit;
				[_x, true, true] call ace_medical_fnc_setDead; //deleteVehicle _x; 
			} else {
				{ 
					[_x, 1.0, "body", "bullet"] call ace_medical_fnc_addDamageToUnit;
					[_x, true, true] call ace_medical_fnc_setDead;
				} foreach crew _x;
			};
		} foreach _affectedUnits;
	}; // Fn_Task_Create_Convoy_DestroyHeavy
};
