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

	
	Fn_Local_Create_Mission_Destroy_Commtower = {
		if ((side player) != west) exitWith {};

		if (player getVariable ["is_civilian", false]) exitWith {};
		[
			player,
			"t_west_destroy_comtower",
			[localize "TASK_07_DESC",
			localize "TASK_07_TITLE",
			localize "TASK_ORIG_01"],
			getMarkerPos "mrk_east_commtower",
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_west_destroy_comtower', "destroy"] call BIS_fnc_taskSetType;
	};
	
	Fn_Local_Task_Destroy_Commtower_Complete = {
		switch (side player) do {
			case west: {
				if (player getVariable ["is_civilian", false]) exitWith {};
				['t_west_destroy_comtower', 'Succeeded', localize "TASK_07_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
			case east: {
				['t_east_defend_commtower', 'Failed', localize "TASK_AOC_02_TITLE"] call Fn_Local_SetPersonalTaskState;
			};
		};
	};
};
