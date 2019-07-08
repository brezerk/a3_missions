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
	Fn_Local_MakeEnemies = {
		playSound "radio_chatter_02";
	};

	Fn_Local_Create_MissionIntro = {
		params['_location'];
		[
			player,
			"t_arrive_to_island",
			[
			format [localize "TASK_02_DESC", _location, _location],
			format [localize "TASK_02_TITLE", _location],
			localize "TASK_ORIG_01"],
			getMarkerPos format["wp_air_field_%1_01", _location],
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_arrive_to_island', "land"] call BIS_fnc_taskSetType;
	};
	
	Fn_Local_MissionIntro_Fail = {
		_task = ['t_arrive_to_island', player] call BIS_fnc_taskReal;
		if (!isNull _task) then {
			_task setTaskState "Failed";
		};
	};
};