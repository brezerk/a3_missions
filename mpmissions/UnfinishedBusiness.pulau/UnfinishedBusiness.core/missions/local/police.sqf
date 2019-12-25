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

	Fn_Local_Create_Task_Civilian_Police = {
		private ["_trg"];
		[
				player,
				"t_civ_police",
				[localize "TASK_CIV_02_DESC",
				localize "TASK_CIV_02_TITLE",
				localize "TASK_ORIG_01"],
				getMarkerPos 'wp_police',
				"CREATED",
				0,
				true
		] call BIS_fnc_taskCreate;
		['t_civ_police', 'danger'] call BIS_fnc_taskSetType;
		
		trgCivPoliceStation = createTrigger ["EmptyDetector", getMarkerPos 'wp_police'];
		trgCivPoliceStation setTriggerArea [12, 12, 0, false];
		trgCivPoliceStation setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		trgCivPoliceStation setTriggerStatements [
			"(vehicle player) in thisList",
			"call Fn_Task_Civilian_Police_Enter_Area;",
			"call Fn_Task_Civilian_Police_Leave_Area;"
		];
	};
	
	Fn_Task_Civilian_Police_Enter_Area = {
		private['_task'];
		if (player getVariable ["is_civilian", false]) then {
			_task = ['t_civ_police', player] call BIS_fnc_taskReal;
			if (!isNull _task) then {
				_task setTaskState "Succeeded";
			};
			//systemChat "You are on danger waters";
			[player] joinSilent (createGroup [west, true]);
		};
	};
	
	Fn_Task_Civilian_Police_Leave_Area = {
		if (player getVariable ["is_civilian", false]) then {
			if (primaryWeapon player == "" && secondaryWeapon player == "" && handgunWeapon player == "") then {
				//systemChat "Ok. Claim down.";
				[player] joinSilent (createGroup [civilian, true]);
			};
		};
	};

};

