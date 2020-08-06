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
Spawn start objectives, triggers for game intro and players allocation
*/

//Player side triggers
// Client side code
if (hasInterface) then {
	
	Fn_Local_WaitForPlanning = {
		cutText [localize "INFO_WAIT_01", "PLAIN DOWN", 2];
	};
	
	Fn_Local_Planned = {
		cutText [localize "INFO_WAIT_02", "PLAIN DOWN", 2];
	};

	Fn_Local_MakeEnemies = {
		playSound "radio_chatter_02";
	};

	Fn_Local_Create_MissionIntro = {
		switch (playerSide) do {
			case east: {

			};
			case civilian: {

			};
			case west: {
				if ((roleDescription player find "SpecOps") >= 0) then {
					waitUntil {!isNull obj_specops_target};
					switch (typeOf obj_specops_target) do {
						case "C_scientist_F": {
							[getPos obj_specops_target] call Fn_Local_Create_Mission_KillDoctor;
						};
						case "B_Slingload_01_Ammo_F": {
							[getPos obj_specops_target] call Fn_Local_Create_Mission_DestroyAmmo;
						};
						case "Land_wpp_Turbine_V1_off_F": {
							[getPos obj_specops_target] call Fn_Local_Create_Mission_DestroyWindMill;
						};
						case "Land_dp_smallTank_F": {
							[getPos obj_specops_target] call Fn_Local_Create_Mission_DestroyFuel;
						};
					};
				} else {
					[
						player,
						"t_arrive_to_island",
						[
						format [localize "TASK_02_DESC", D_LOCATION],
						format [localize "TASK_02_TITLE", D_LOCATION],
						localize "TASK_ORIG_01"],
						getMarkerPos "mrk_airfield",
						"CREATED",
						0,
						true
					] call BIS_fnc_taskCreate;
					['t_arrive_to_island', "land"] call BIS_fnc_taskSetType;
				};
			};
		};
	};
	
	Fn_Local_MissionIntro_Fail = {
		private _task = ['t_arrive_to_island', player] call BIS_fnc_taskReal;
		if (!isNull _task) then {
			["TaskFailed",["", (format [localize "TASK_02_TITLE", D_LOCATION])]] call BIS_fnc_showNotification;
			_task setTaskState "Failed";
		};
	};
};