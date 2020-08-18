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

	Fn_Spawn_East_Helicopter = {
		private _veh = objNull;
		//if (isNull east_resque_heli01) then {
			if (!alive east_resque_heli01) then {
				private _marker = "mrk_east_helicopter";
				private _pos = getMarkerPos _marker;
				private _dir = markerDir _marker;
				if (count (nearestObjects [_pos, ["Car", "Tank", "APC", "Boat", "Drone", "Plane", "Helicopter"], 12]) == 0) then {
					_veh = createVehicle [(selectRandom D_FRACTION_EAST_UNITS_HELI_RQ), [0, 0, 0], [], 0, "CAN_COLLIDE"];
					_veh enableSimulation false;
					_veh allowDamage false;
					_veh setPosATL [_pos # 0, _pos # 1, 0];
					_veh setDir (_dir);
					_veh allowDamage true;
					_veh enableSimulation true;
					east_resque_heli01 = _veh;
				};
			};
		//};
		_veh;
	};
	
};
