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
if (hasInterface) then {
	Fn_Local_Create_Mission_DestroyAmmo = {
		params['_pos'];
		if (playerSide == west) then {
			[
				player,
				"t_destroy_ammo",
				[format [localize "TASK_12_DESC", D_LOCATION],
				localize "TASK_12_TITLE",
				localize "TASK_ORIG_01"],
				_pos,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
		};
	};
	Fn_Local_Create_Mission_DestroyFuel = {
		params['_pos'];
		if (playerSide == west) then {
			[
				player,
				"t_destroy_fuel",
				[format [localize "TASK_13_DESC", D_LOCATION],
				localize "TASK_13_TITLE",
				localize "TASK_ORIG_01"],
				_pos,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
		};
	};
	Fn_Local_Create_Mission_DestroyWindMill = {
		params['_pos'];
		if (playerSide == west) then {
			[
				player,
				"t_destroy_windmill",
				[format [localize "TASK_14_DESC", D_LOCATION],
				localize "TASK_14_TITLE",
				localize "TASK_ORIG_01"],
				_pos,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
		};
	};
	Fn_Local_Create_Mission_KillDoctor = {
		params['_pos'];
		if (playerSide == west) then {
			[
				player,
				"t_kill_doctor",
				[format [localize "TASK_15_DESC", D_LOCATION],
				localize "TASK_15_TITLE",
				localize "TASK_ORIG_01"],
				_pos,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
		};
	};
	
	Fn_Local_Task_KillDoctor_Complete = {
		switch (playerSide) do {
			case west: {
				['t_kill_doctor', 'Succeeded', localize "TASK_15_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
			case independent: {
				['t_indep_defend_doctor', 'Failed', localize "TASK_15_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
		};
	};
	
	Fn_Local_Task_DestroyWindMill_Complete = {
		switch (playerSide) do {
			case west: {
				['t_destroy_windmill', 'Succeeded', localize "TASK_14_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
			case independent: {
				['t_indep_defend_windmill', 'Failed', localize "TASK_14_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
		};
	};
	
	Fn_Local_Task_DestroyFuel_Complete = {
		switch (playerSide) do {
			case west: {
				['t_destroy_fuel', 'Succeeded', localize "TASK_13_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
			case independent: {
				['t_indep_defend_fuel', 'Failed', localize "TASK_13_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
		};
	};
	
	Fn_Local_Task_DestroyAmmo_Complete = {
		switch (playerSide) do {
			case west: {
				['t_destroy_ammo', 'Succeeded', localize "TASK_12_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
			case independent: {
				['t_indep_defend_ammo', 'Failed', localize "TASK_12_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
		};
	};
};