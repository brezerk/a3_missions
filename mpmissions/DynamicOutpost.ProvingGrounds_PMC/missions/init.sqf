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
Initialize mainline, but do to start main thead yet.
*/

if (isServer) then {
	['t_report_officer', 'Succeeded', localize 'TASK_03_TITLE'] remoteExecCall ['Fn_Local_SetPersonalTaskState', [0,-2] select isDedicated];
	"respawn_guerrila" setMarkerPos (getPos field_hospital);
	
	{
		private _marker = createMarker [format ["respawn_guerrila_0%1", _forEachIndex], getPos _x];
		_marker setMarkerType "hd_destroy";
		_marker setMarkerAlpha 0;
	} forEach [ua_barracK_01, ua_barracK_02, ua_barracK_03, ua_barracK_04, ua_barracK_05];
	
	sleep 5;
	call Fn_Task_Create_MissingPatrol;
	sleep 5;
	call Fn_Task_Create_HelicopterCrashSite;
	sleep 5;
	call Fn_Task_Create_Informator;
};