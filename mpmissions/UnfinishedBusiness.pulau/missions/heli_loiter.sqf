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

params['_vehicle'];
private _grp = group _vehicle;

//initial dealy (let heli fly around primary object for a while)
sleep 300;

if (isServer) then {

	while {alive _vehicle} do {
		sleep (60 + (random 300));
		if (count pings_heli > 0) then {
			private _ping = selectRandom pings_heli;
			if (!isNil "_ping") then {
				//cleanup
				while {(count (waypoints _grp)) > 0} do {
					deleteWaypoint ((waypoints _grp) select 0);
				};
				//send to ping
				private _wp = _grp addWaypoint [_ping, 0];
				_wp setWaypointType "loiter";
				_wp setWaypointSpeed "NORMAL";
				_wp setWaypointCombatMode "RED";
				_wp setWaypointLoiterType "Circle_L";
				_wp setWaypointLoiterRadius 300;
			};
			//flush
			pings_heli = [];
		};
	};
};