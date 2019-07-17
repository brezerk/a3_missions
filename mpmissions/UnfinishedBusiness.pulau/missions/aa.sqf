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
if (hasInterface) then {};

if (isServer) then {
	task_complete_commtower = false;
	task_complete_aa = false;
	csat_aa_01 = objNull;
	csat_comm_tower_01 = objNull;
	
	Fn_Task_Spawn_CSAT_Objectives = {
		private _marker = format ["wp_%1_aa", D_LOCATION];
		private _pos = getMarkerPos _marker;
		private _class = "CUP_O_2S6_RU";
		csat_aa_01 = createVehicle [_class, _pos];
		csat_aa_01 setDir (markerDir _marker);
		private _crew = createVehicleCrew (csat_aa_01);
		_pos = getMarkerPos format ["wp_%1_commtower", D_LOCATION];
		_class = "Land_Communication_F";
		csat_comm_tower_01 = createVehicle [_class, _pos];
		publicVariable "csat_aa_01";
		publicVariable "csat_comm_tower_01";
		switch (D_DIFFICLTY) do {
			case 0: {
				_class = "CUP_O_UH1H_slick_SLA";
			};
			case 1: {
				_class = "CUP_O_UH1H_armed_SLA";
			};
			case 2: {
				_class = "CUP_O_UH1H_gunship_SLA";
			};
		};
		
		_vehicle = createVehicle [_class, (getMarkerPos format["wp_%1_AOC_helicopter", D_LOCATION])];
	};
	
	Fn_Task_Create_CSAT_Triggers = {
		private['_trg'];
		_trg = createTrigger ["EmptyDetector", getPos csat_aa_01];
		_trg setTriggerArea [0, 0, 0, false];
		_trg setTriggerActivation ["NONE", "PRESENT", false];
		_trg setTriggerStatements [
			"!alive csat_aa_01 || !canFire csat_aa_01;",
			"if (isServer) then { call Fn_Task_AA_Complete };",
			""
		];
		_trg = createTrigger ["EmptyDetector", getPos csat_comm_tower_01];
		_trg setTriggerArea [0, 0, 0, false];
		_trg setTriggerActivation ["NONE", "PRESENT", false];
		_trg setTriggerStatements [
			"!alive csat_comm_tower_01;",
			"if (isServer) then { call Fn_Task_Commtower_Complete };",
			""
		];
	};

	Fn_Task_Create_AA = {
		if (hasInterface) then {
			remoteExecCall ["Fn_Local_Create_MissionAA"];
		} else {
			remoteExecCall ["Fn_Local_Create_MissionAA", -2];
		};
	};
	
	Fn_Task_AA_Complete = {
		['t_destroy_aa', 'SUCCEEDED'] call BIS_fnc_taskSetState;
		['t_scat_defend_aa', 'FAILED'] call BIS_fnc_taskSetState;
		task_complete_aa = true;
	};
	
	Fn_Task_Commtower_Complete = {
		['t_destroy_comtower', 'SUCCEEDED'] call BIS_fnc_taskSetState;
		['t_scat_defend_comm_tower', 'FAILED'] call BIS_fnc_taskSetState;
		task_complete_commtower = true;
	};

};