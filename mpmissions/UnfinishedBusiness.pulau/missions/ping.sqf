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
	If assault group is dead -- end game;
	Usage: execVM ["missions/assault_group_is_dead.sqf"];
	Return: true
*/

if (isServer) then {
	while {count assault_group != 0} do {
		sleep D_PING_TIMEOUT;
		if (count pings > 0) then {
			{
				private _pos = _x;
				private _grid_pos = mapGridPosition _pos;
				[[independent, "HQ"], format ["Enemy %1 spotted. Grid: %2", _forEachIndex, _grid_pos]] remoteExec ["sideChat"];
				[[east, "HQ"], format ["Enemy %1 spotted. Grid: %2", _forEachIndex, _grid_pos]] remoteExec ["sideChat"];
				{
					if (side _x in [independent, east]) then {
						private _g_pos = getPos (leader _x);
						if (_x getVariable ["is_patrol_group", false]) then {
							if ((_g_pos distance2D _pos) <= 500) then {
								//inject SAD
								switch (waypointType [_x, 0]) do {
									case 'SAD': {
										deleteWaypoint [_x, 0];
										private _wp = _x addWaypoint [_pos, 0, 0];
										_wp setWaypointType "SAD";
										_wp setWaypointCombatMode "RED";
										_wp setWaypointBehaviour "AWARE";
										_wp setWaypointSpeed "NORMAL";
									};
									default {
										private _wp = _x addWaypoint [_pos, 0, 0];
										_wp setWaypointType "SAD";
										_wp setWaypointCombatMode "RED";
										_wp setWaypointBehaviour "AWARE";
										_wp setWaypointSpeed "NORMAL";
									};
								};
							};
						};
					};
				} forEach allGroups;
			} forEach pings;
			pings = [];
		};
	};
};