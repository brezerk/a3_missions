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
	Fn_Local_Create_Task_Civilian_Liberate_MissionIntro = {
		{
			private _task = format["t_civ_libirate_%1", _forEachIndex];
			[
				player,
				_task,
				[format[localize "TASK_CIV_03_DESC", _forEachIndex, _x select 0],
				format[localize "TASK_CIV_03_TITLE", _x select 0],
				localize "TASK_ORIG_03"],
				getMarkerPos (format ["mrk_city_%1", _forEachIndex]),
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			[_task, "kill"] call BIS_fnc_taskSetType;
						
		} forEach avaliable_pois;
		
		
		trgCivLiberate00 = createTrigger ["EmptyDetector", getMarkerPos "mrk_city_0"];
		trgCivLiberate00 setTriggerArea [100, 100, 0, false];
		trgCivLiberate00 setTriggerActivation ["WEST SEIZED", "PRESENT", false];
		trgCivLiberate00 setTriggerTimeout [5, 10, 20, true];
		trgCivLiberate00 setTriggerStatements ["this", "call Fn_Task_Civilian_Liberate_LiberateCity0;", ""];

		trgCivLiberate01 = createTrigger ["EmptyDetector", getMarkerPos "mrk_city_1"];
		trgCivLiberate01 setTriggerArea [100, 100, 0, false];
		trgCivLiberate01 setTriggerActivation ["WEST SEIZED", "PRESENT", false];
		trgCivLiberate01 setTriggerTimeout [5, 10, 20, true];
		trgCivLiberate01 setTriggerStatements ["this", "call Fn_Task_Civilian_Liberate_LiberateCity1;", ""];

	};
	
	Fn_Task_Civilian_Liberate_LiberateCity0 = {
		if (player getVariable ["is_civilian", false]) then {
			_task = ['t_civ_libirate_0', player] call BIS_fnc_taskReal;
			if (!isNull _task) then {
				["TaskSucceeded",["", localize "TASK_CIV_03_DONE"]] call BIS_fnc_showNotification;
				_task setTaskState "Succeeded";
			};
		};
	};
	
	Fn_Task_Civilian_Liberate_LiberateCity1 = {
		if (player getVariable ["is_civilian", false]) then {
			_task = ['t_civ_libirate_1', player] call BIS_fnc_taskReal;
			if (!isNull _task) then {
				["TaskSucceeded",["", localize "TASK_CIV_03_DONE"]] call BIS_fnc_showNotification;
				_task setTaskState "Succeeded";
			};
		};
	};
	
};