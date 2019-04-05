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
Spawn start objectives, triggers for bmp2 repair
*/

if (isServer) then {
	Fn_Task_Create_RepairHeavy = {
			// Damage HEAVY
		trgHeavyDoDamage = createTrigger ["EmptyDetector", getMarkerPos "wp_defend_01"];
		trgHeavyDoDamage setTriggerArea [(650 + (random 650)), (650 + (random 650)), 0, false];
		trgHeavyDoDamage setTriggerActivation ["VEHICLE", "PRESENT", false];
		trgHeavyDoDamage triggerAttachVehicle [ua_heavy_01];
		trgHeavyDoDamage setTriggerStatements [
			"this",
			"call Fn_Task_Create_RepairHeavy_DoDamage;",
			""
		];
	};
	/*
		Disable ua_heavy_01
	*/
	Fn_Task_Create_RepairHeavy_DoDamage = {
		//    
		private ["_randomElement"];
		_randomElement = selectRandom [
			"HitLTrack",
			"HitRTrack",
			"hitEngine"
			];
		[ua_heavy_01, [_randomElement, 0.95, true]] remoteExec ["setHitPointDamage"];
		//spawn smoke
		//_smoke = ["SmokeShell", position ua_heavy_01] remoteExec ["createVehicle"];
		//[_smoker, [ua_heavy_01,[0,0,0]]]  remoteExec ["attachto"];
		[
			independent,
			"t_repair_heavy",
			[localize "TASK_05_DESC",
			localize "TASK_05_TITLE",
			localize "TASK_ORIG_01"],
			getPos ua_heavy_01,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_repair_heavy', "repair"] call BIS_fnc_taskSetType;
		trgHeavyRepaired = createTrigger ["EmptyDetector", getPos ua_heavy_01];
		trgHeavyRepaired setTriggerArea [0, 0, 0, false];
		trgHeavyRepaired setTriggerActivation ["NONE", "PRESENT", false];
		trgHeavyRepaired triggerAttachVehicle [ua_heavy_01];
		trgHeavyRepaired setTriggerStatements [
			"triggerActivated trgHeavyDoDamage && canMove ua_heavy_01;",
			"['t_repair_heavy', 'SUCCEEDED'] call BIS_fnc_taskSetState; deleteVehicle trgHeavyDestroyed; deleteVehicle trgHeavyDoDamage; [1000] call Fn_Modify_Rating;",
			""
		];
		trgHeavyDestroyed = createTrigger ["EmptyDetector", getPos ua_heavy_01];
		trgHeavyDestroyed setTriggerArea [0, 0, 0, false];
		trgHeavyDestroyed setTriggerActivation ["NONE", "PRESENT", false];
		trgHeavyDestroyed triggerAttachVehicle [ua_heavy_01];
		trgHeavyDestroyed setTriggerStatements [
			"triggerActivated trgHeavyDoDamage && !alive ua_heavy_01;",
			"['t_repair_heavy', 'FAILED'] call BIS_fnc_taskSetState; deleteVehicle trgHeavyRepaired; deleteVehicle trgHeavyDoDamage;",
			""
		];
	};
};