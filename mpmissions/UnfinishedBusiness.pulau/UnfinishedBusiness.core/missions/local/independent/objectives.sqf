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
			private _title = "TASK_12_TITLE";
			if ((roleDescription player find "SpecOps") >= 0) then { _title = "TASK_12_SPEC_TITLE"; };
			[
				player,
				"t_west_destroy_ammo",
				[format [localize "TASK_12_DESC", D_LOCATION],
				localize _title,
				localize "TASK_ORIG_01"],
				_pos,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_west_destroy_ammo', "destroy"] call BIS_fnc_taskSetType;
		};
	};
	Fn_Local_Create_Mission_DestroyFuel = {
		params['_pos'];
		if (playerSide == west) then {
			private _title = "TASK_13_TITLE";
			if ((roleDescription player find "SpecOps") >= 0) then { _title = "TASK_13_SPEC_TITLE"; };
			[
				player,
				"t_west_destroy_fuel",
				[format [localize "TASK_13_DESC", D_LOCATION],
				localize _title,
				localize "TASK_ORIG_01"],
				_pos,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_west_destroy_fuel', "destroy"] call BIS_fnc_taskSetType;
		};
	};
	Fn_Local_Create_Mission_DestroyWindMill = {
		params['_pos'];
		if (playerSide == west) then {
			private _title = "TASK_14_TITLE";
			if ((roleDescription player find "SpecOps") >= 0) then { _title = "TASK_14_SPEC_TITLE"; };
			[
				player,
				"t_west_destroy_windmill",
				[format [localize "TASK_14_DESC", D_LOCATION],
				localize _title,
				localize "TASK_ORIG_01"],
				_pos,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_west_destroy_windmill', "destroy"] call BIS_fnc_taskSetType;
		};
	};
	Fn_Local_Create_Mission_KillDoctor = {
		params['_pos'];
		if (playerSide == west) then {
			private _title = "TASK_15_TITLE";
			if ((roleDescription player find "SpecOps") >= 0) then { _title = "TASK_15_SPEC_TITLE"; };
			[
				player,
				"t_west_kill_doctor",
				[format [localize "TASK_15_DESC", D_LOCATION],
				localize _title,
				localize "TASK_ORIG_01"],
				_pos,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_west_kill_doctor', "kill"] call BIS_fnc_taskSetType;
		};
	};
	
	Fn_SpecOps_Extract = {
		if ((player getVariable ["is_specops_group", false])) then {
			[
				player,
				"t_west_extract",
				[
					format [localize "TASK_17_DESC", D_LOCATION],
					format [localize "TASK_17_TITLE"],
					localize "TASK_ORIG_01"],
				getPos us_liberty_01,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_west_extract', "run"] call BIS_fnc_taskSetType;
		};
	};
	
	Fn_Local_Task_KillDoctor_Complete = {
		switch (playerSide) do {
			case west: {
				private _title = "TASK_15_TITLE";
				if ((roleDescription player find "SpecOps") >= 0) then { _title = "TASK_15_SPEC_TITLE"; call Fn_SpecOps_Extract; };
				['t_west_kill_doctor', 'Succeeded', localize _title] call Fn_Local_SetPersonalTaskState;
			};
			case independent: {
				['t_indep_defend_doctor', 'Failed', localize "TASK_15_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
		};
	};
	
	Fn_Local_Task_DestroyWindMill_Complete = {
		switch (playerSide) do {
			case west: {
				private _title = "TASK_14_TITLE";
				if ((roleDescription player find "SpecOps") >= 0) then { _title = "TASK_14_SPEC_TITLE"; call Fn_SpecOps_Extract; };
				['t_west_destroy_windmill', 'Succeeded', localize _title] call Fn_Local_SetPersonalTaskState;
			};
			case independent: {
				['t_indep_defend_windmill', 'Failed', localize "TASK_14_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
		};
	};
	
	Fn_Local_Task_DestroyFuel_Complete = {
		switch (playerSide) do {
			case west: {
				private _title = "TASK_13_TITLE";
				if ((roleDescription player find "SpecOps") >= 0) then { _title = "TASK_13_SPEC_TITLE"; call Fn_SpecOps_Extract; };
				['t_west_destroy_fuel', 'Succeeded', localize _title] call Fn_Local_SetPersonalTaskState;
			};
			case independent: {
				['t_indep_defend_fuel', 'Failed', localize "TASK_13_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
		};
	};
	
	Fn_Local_Task_DestroyAmmo_Complete = {
		switch (playerSide) do {
			case west: {
				private _title = "TASK_12_TITLE";
				if ((roleDescription player find "SpecOps") >= 0) then { _title = "TASK_12_SPEC_TITLE"; call Fn_SpecOps_Extract; };
				['t_west_destroy_ammo', 'Succeeded', localize _title] call Fn_Local_SetPersonalTaskState;
			};
			case independent: {
				['t_indep_defend_ammo', 'Failed', localize "TASK_12_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
		};
	};
};