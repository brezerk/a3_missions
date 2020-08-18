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
		switch (side player) do {
			case east: {
				call Fn_Local_Create_EAST_MissionIntro;
			};
			case civilian: {
				call Fn_Local_Create_CIV_MissionIntro;
			};
			case west: {	
				if (player getVariable ["is_civilian", false]) then {
					call Fn_Local_Create_CIV_MissionIntro;
				} else {
					call Fn_Local_Create_WEST_MissionIntro;
				};
			};
		};
	};
	
	Fn_Local_MissionIntro_Fail = {
		switch (side player) do {
			case west: {
				private _task = ['t_arrive_to_island', player] call BIS_fnc_taskReal;
				if (!isNull _task) then {
					["TaskFailed",["", (format [localize "TASK_02_TITLE", D_LOCATION])]] call BIS_fnc_showNotification;
					_task setTaskState "Failed";
				};
				_task = ['t_wait_for_orders', player] call BIS_fnc_taskReal;
				if (!isNull _task) then {
					["TaskSucceeded",["", (format [localize "TASK_18_TITLE", D_LOCATION])]] call BIS_fnc_showNotification;
					_task setTaskState "Succeeded";
				};
			};
			case east: {
				call Fn_Local_Create_EAST_MissionCrashSite;
			};
			case civilian: {
				if (player getVariable ["is_assault_group", false]) then {
					private _task = ['t_arrive_to_island', player] call BIS_fnc_taskReal;
					if (!isNull _task) then {
						["TaskFailed",["", (format [localize "TASK_02_TITLE", D_LOCATION])]] call BIS_fnc_showNotification;
						_task setTaskState "Failed";
					};
				} else {
				call Fn_Local_Create_CIV_MissionIntro;
				};
			};
		};
	};
};