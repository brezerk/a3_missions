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

if (hasInterface) then {
	
};

if (isServer) then {

	if (!mission_plane_send) then {
		// Well. Some one destroyed the transport before every one got in 
		// Happy end (not)
		"EveryoneLost" call BIS_fnc_endMissionServer;
	} else {
		sleep 1;
		
		{
			remoteExecCall ["Fn_Local_Jet_GetOut", _x];
		} forEach assault_group;
			
		sleep 2;
		
		us_heli_01 setVehicleLock "UNLOCKED";
		us_boat_01 setVehicleLock "UNLOCKED";
		us_boat_02 setVehicleLock "UNLOCKED";
		
		[] execVM "UnfinishedBusiness.core\missions\crash_site.sqf";
	};
};