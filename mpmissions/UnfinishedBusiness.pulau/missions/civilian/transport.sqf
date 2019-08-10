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
if (hasInterface) then {};

if (isServer) then {
	Fn_Spawn_Civ_Air_Transport = {
		private _marker = format ["mrk_cesna", D_LOCATION];
		private _obj = createVehicle ["C_Plane_Civil_01_F", (getMarkerPos _marker), [], 0, "CAN_COLLIDE"];
		_obj setDir (markerDir _marker);	
		_marker = format ["mrk_heli", D_LOCATION];
		_obj = createVehicle ["C_Heli_Light_01_civil_F", (getMarkerPos (format ["", D_LOCATION])), [], 0, "CAN_COLLIDE"];
		_obj setDir (markerDir _marker);
	};
};