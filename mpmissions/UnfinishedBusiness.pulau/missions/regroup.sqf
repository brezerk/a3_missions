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
	
};

if (isServer) then {

	task_complete_regroup = false;



	trgRegroupPoint = createTrigger ["EmptyDetector", getMarkerPos 'wp_air_field_01'];
	trgRegroupPoint setTriggerArea [30, 30, 0, false];
	trgRegroupPoint setTriggerActivation ["NONE", "PRESENT", false];
	trgRegroupPoint setTriggerStatements [
			"({alive _x} count (allPlayers -  entities 'HeadlessClient_F' ) == {alive _x && _x inArea thisTrigger} count (allPlayers - entities 'HeadlessClient_F' ))  && ({alive _x} count allPlayers) > 0",
			"['t_regroup', 'SUCCEEDED'] call BIS_fnc_taskSetState; task_complete_regroup = true;",
			""
	];
	
	while {!task_complete_regroup} do {
		sleep 10;
		{
			if (alive _x) exitWith { trgRegroupPoint setPos (getPos _x); };
		} forEach (allPlayers - entities 'HeadlessClient_F');
	};
	
	deleteVehicle trgRegroupPoint;
	
	trgRegroupPoint = createTrigger ["EmptyDetector", getMarkerPos 'wp_air_field_01'];
	trgRegroupPoint setTriggerArea [0, 0, 0, false];
	trgRegroupPoint setTriggerActivation ["NONE", "PRESENT", false];
	trgRegroupPoint setTriggerStatements [
			"task_complete_intormator",
			"call Fn_Task_Create_AA; call Fn_Task_Create_KillLeader;",
			""
	];
};