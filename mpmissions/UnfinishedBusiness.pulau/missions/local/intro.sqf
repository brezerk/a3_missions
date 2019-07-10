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

	if (!mission_requested) then {
		us_leader_01 addAction [localize "ACTION_06", {execVM "ui\settingsDialog.sqf"}, nil, 1, false, false, "", "!mission_requested", 5];
	};

	if (alive us_airplane_01) then {
		if ((mission_requested) && (!mission_plane_send)) then {
			call Fn_Local_Create_MissionIntro;
		};
	};
	
	Fn_Local_WaitForPlanning = {
		cutText [localize "INFO_WAIT_01", "PLAIN"]
	};

	Fn_Local_MakeEnemies = {
		playSound "radio_chatter_02";
	};

	Fn_Local_Create_MissionIntro = {
		us_leader_01 removeAction 0;
		[
			player,
			"t_arrive_to_island",
			[
			format [localize "TASK_02_DESC", D_LOCATION, D_LOCATION],
			format [localize "TASK_02_TITLE", D_LOCATION],
			localize "TASK_ORIG_01"],
			getMarkerPos format["wp_air_field_%1_01", D_LOCATION],
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_arrive_to_island', "land"] call BIS_fnc_taskSetType;
	};
	
	Fn_Local_MissionIntro_Fail = {
		private _task = ['t_arrive_to_island', player] call BIS_fnc_taskReal;
		if (!isNull _task) then {
			["TaskFailed",["", (format [localize "TASK_02_TITLE", D_LOCATION])]] call BIS_fnc_showNotification;
			_task setTaskState "Failed";
		};
	};
};