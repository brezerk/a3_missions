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
	Fn_Local_Create_RegroupMission = {
		if (playerSide == west) then {
			[
				player,
				"t_regroup",
				[localize "TASK_03_DESC",
				localize "TASK_03_TITLE",
				localize "TASK_ORIG_01"],
				objNull,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_regroup', "meet"] call BIS_fnc_taskSetType;
		};
	};
	
	Fn_Local_RegroupMission_Complete = {
		_task = ['t_regroup', player] call BIS_fnc_taskReal;
		if (!isNull _task) then {
			["TaskSucceeded",["", localize "TASK_03_TITLE"]] call BIS_fnc_showNotification;
			_task setTaskState "Succeeded";
		};
	};
};
