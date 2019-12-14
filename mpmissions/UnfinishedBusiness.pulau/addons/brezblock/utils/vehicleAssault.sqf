
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

params['_uuid', '_pos', '_range'];

private _class = "";
private _executed = false;

while { !_executed } do {
	sleep 10;
	{
		if ((_x getVariable ["assault_uuid", ""]) == _uuid) then {
			private _grp = (group (driver _x));
			{ 
				private _vehicle = (assignedVehicle _x);
				_vehicle limitSpeed 0;
				{
					if ((_vehicle getCargoIndex _x) >= 0) then {
						doGetOut _x;
						unassignVehicle _x;
					} else {
						doStop _x;
					};
				} forEach (crew _vehicle);
			} forEach units _grp;
			//cleanup
			while {(count (waypoints _grp)) > 0} do {
				deleteWaypoint ((waypoints _grp) select 0);
			};
			//give some time for infantry to advance
			sleep 90;
			
			//let it move
			{ 
				private _vehicle = (assignedVehicle _x);
				_vehicle limitSpeed 40;
			} forEach units _grp;
			units _grp doFollow leader _grp;
			private _wp = _grp addWaypoint [_pos, 0];
			_wp setWaypointType "SAD";
			_wp setWaypointCombatMode "RED";
			_wp setWaypointBehaviour "COMBAT";
			_wp setWaypointSpeed "NORMAL";
			_executed = true;
		};
	} forEach nearestObjects [_pos, ["Car","Tank","APC"], _range];
};
