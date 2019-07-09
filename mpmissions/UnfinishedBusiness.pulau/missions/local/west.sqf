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
	Fn_Local_Create_EAST_MissionIntro = {
		if (!alive us_airplane_01) then {
			[
				player,
				"t_us_rescue",
				[
				format [localize "TASK_09_DESC", D_LOCATION, D_LOCATION],
				format [localize "TASK_09_TITLE"],
				localize "TASK_ORIG_01"],
				getPos us_liberty_01,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_us_rescue', "run"] call BIS_fnc_taskSetType;
		};
	};
};