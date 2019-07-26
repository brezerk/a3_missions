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
		private _marker = format ["wp_%1_aa", D_LOCATION];
		if (canFire csat_aa_01) then {
			[
				player,
				"t_scat_defend_aa",
				[format [localize "TASK_AOC_01_DESC", D_LOCATION],
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
				player,
				"t_scat_defend_comm_tower",
				[format [localize "TASK_AOC_02_DESC", D_LOCATION],
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
			player,
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
		[
			player,
			"t_east_crash",
			[format [localize "TASK_10_DESC", D_LOCATION, D_LOCATION],
			format [localize "TASK_10_TITLE"],
			localize "TASK_ORIG_01"],
			getMarkerPos "wp_crash_site",
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_east_crash', "search"] call BIS_fnc_taskSetType;
		{
			private _task = format["t_east_city_%1", _forEachIndex];
			[
				player,
				_task,
				[format[localize "TASK_11_DESC", _forEachIndex, _x select 0],
				format[localize "TASK_11_TITLE", _x select 0],
				localize "TASK_ORIG_01"],
				getMarkerPos (format ["wp_city_%1", _forEachIndex]),
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			[_task, "talk"] call BIS_fnc_taskSetType;			
		} forEach avaliable_pois;
				
		trgWestCrashSite = createTrigger ["EmptyDetector", (getMarkerPos "crash_site")];
		trgWestCrashSite setTriggerArea [50, 50, 0, false];
		trgWestCrashSite setTriggerActivation ["ANYPLAYER", "PRESENT", false];
		trgWestCrashSite setTriggerStatements [
			"(vehicle player) in thisList",
			"call Fn_Local_CrashSite_Complete;",
			""
		];
		
		{
			if (!(_x in playableunits) && !(_x in switchableunits)) then {
				removeAllActions _x;
				[_x] call Fn_Local_Attach_Recruit_Action;
			};
		} forEach (nearestObjects [getMarkerPos "respawn_east", ["SoldierWB"], 150]);
	};
};