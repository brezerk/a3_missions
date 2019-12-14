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
			private _task = format["t_libirate_%1", _forEachIndex];
			[
				civilian,
				_task,
				[format[localize "TASK_09_DESC", _forEachIndex, _x select 0],
				format[localize "TASK_09_TITLE", _x select 0],
				localize "TASK_ORIG_03"],
				objNull,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			[_task, "kill"] call BIS_fnc_taskSetType;
		} forEach avaliable_pois;
	};
	
};