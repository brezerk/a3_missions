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

	Fn_Local_Create_Task_Civilian_WaponStash = {
		[
				player,
				"t_civ_weapon_stash",
				[localize "TASK_CIV_02_DESC",
				localize "TASK_CIV_02_TITLE",
				localize "TASK_ORIG_01"],
				objNull,
				"CREATED",
				0,
				true
		] call BIS_fnc_taskCreate;
		['t_civ_weapon_stash', "search"] call BIS_fnc_taskSetType;
		
		trgCivStash00 = createTrigger ["EmptyDetector", getMarkerPos "civ_stash_00"];
		trgCivStash00 setTriggerArea [50, 50, 0, false];
		trgCivStash00 setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		trgCivStash00 setTriggerStatements [
			"(vehicle player) in thisList",
			"call Fn_Task_Civilian_WaponStash_Enter_Area;",
			"call Fn_Task_Civilian_Danger_Leave_Area;"
		];
		
		trgCivStash01 = createTrigger ["EmptyDetector", getMarkerPos "civ_stash_01"];
		trgCivStash01 setTriggerArea [50, 50, 0, false];
		trgCivStash01 setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		trgCivStash01 setTriggerStatements [
			"(vehicle player) in thisList",
			"call Fn_Task_Civilian_WaponStash_Enter_Area;",
			"call Fn_Task_Civilian_Danger_Leave_Area;"
		];
	
	};

	Fn_Local_Create_Task_Civilian_FloodedShip = {
		[
				player,
				"t_civ_boat",
				[localize "TASK_CIV_01_DESC",
				localize "TASK_CIV_01_TITLE",
				localize "TASK_ORIG_01"],
				getMarkerPos "civ_ship_01",
				"CREATED",
				0,
				true
		] call BIS_fnc_taskCreate;
		['t_civ_boat', "boat"] call BIS_fnc_taskSetType;
	
		trgCivFloodedShip = createTrigger ["EmptyDetector", getMarkerPos "civ_ship_01"];
		trgCivFloodedShip setTriggerArea [50, 50, 0, false];
		trgCivFloodedShip setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		trgCivFloodedShip setTriggerStatements [
			"(vehicle player) in thisList",
			"call Fn_Task_Civilian_FloodedShip_Enter_Area;",
			"call Fn_Task_Civilian_Danger_Leave_Area;"
		];
	};
	
	Fn_Task_Civilian_WaponStash_Enter_Area = {
		[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_10', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;
		if (player getVariable ["is_civilian", false]) then {
			_task = ['t_civ_weapon_stash', player] call BIS_fnc_taskReal;
			if (!isNull _task) then {
				["TaskSucceeded",["", localize "TASK_CIV_02_TITLE"]] call BIS_fnc_showNotification;
				_task setTaskState "Succeeded";
			};
		};
		call Fn_Task_Civilian_Danger_Enter_Area;
	};
	
	Fn_Task_Civilian_FloodedShip_Enter_Area = {
		[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_09', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;
		/*if (player getVariable ["is_civilian", false]) then {
			_task = ['t_civ_boat', player] call BIS_fnc_taskReal;
			if (!isNull _task) then {
				_task setTaskState "Succeeded";
			};
		};*/
		call Fn_Task_Civilian_Danger_Enter_Area;
	};
	
	
	Fn_Task_Civilian_Danger_Enter_Area = {
		if (player getVariable ["is_civilian", false]) then {
			//systemChat "You are on danger waters";
			[west] call Fn_Local_Switch_Side;
		};
	};
	
	Fn_Task_Civilian_Danger_Leave_Area = {
		if (player getVariable ["is_civilian", false]) then {
			if (primaryWeapon player == "" && secondaryWeapon player == "" && handgunWeapon player == "") then {
				//systemChat "Ok. Claim down.";
				[civilian] call Fn_Local_Switch_Side;
			};
		};
	};
	
};
