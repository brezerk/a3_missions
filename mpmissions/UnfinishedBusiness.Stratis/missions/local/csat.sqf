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
	Fn_Local_Create_SCAT_MissionIntro = {
		if (canFire csat_aa_01) then {
			[
				east,
				"t_scat_defend_aa",
				[localize "TASK_AOC_01_DESC",
				localize "TASK_AOC_01_TITLE",
				localize "TASK_ORIG_01"],
				getPos csat_aa_01,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_scat_defend_aa', "defend"] call BIS_fnc_taskSetType;
		};
		if (alive csat_comm_tower_01) then {
			[
				east,
				"t_scat_defend_comm_tower",
				[localize "TASK_AOC_02_DESC",
				localize "TASK_AOC_02_TITLE",
				localize "TASK_ORIG_02"],
				getPos csat_comm_tower_01,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_scat_defend_comm_tower', "defend"] call BIS_fnc_taskSetType;
		};
		[
			east,
			"t_scat_eliminate_surv",
			[localize "TASK_AOC_03_DESC",
			localize "TASK_AOC_03_TITLE",
			localize "TASK_ORIG_03"],
			objNull,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_scat_eliminate_surv', "kill"] call BIS_fnc_taskSetType;
	};
	
	sleep 5;
};