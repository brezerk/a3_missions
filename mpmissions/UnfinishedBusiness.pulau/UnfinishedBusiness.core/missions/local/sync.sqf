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
Sync client state
*/
 
//Check mainline mission state
if (mission_requested) then {
	//Check if airplane was already send
	call Fn_Local_Create_MissionIntro;
	/*
	if (mission_plane_send) then {
		private _us_airplane_01_alive = false;
		if (!isNil "us_airplane_01") then {
			_us_airplane_01_alive = alive us_airplane_01;
		};
		//Ok. Airplane was send. 
		if (_us_airplane_01_alive) then {
			//Ok it is still alive -- so You must wait for orders.
			//FIXME: Add wait for orders maybe?
		} else {
			//Airplan is down, We need to assign resque mission
			call Fn_Local_Create_RescueMission;
			//FIXME: we need some flag set by controller.sqf
			//to confirm server is done with spawning units :(
			sleep 60;
			call Fn_Local_Civilian_AttachConfiscate_Action;
			call Fn_Local_Civilian_AttachInformator_Action;
			call Fn_Local_Create_MissionAA;
			call Fn_Local_West_Create_Mission_CollectIntel;
		};
	} else {
		//Mission requested, but plane was not send yet. Create regular task;
		
	};*/
};
