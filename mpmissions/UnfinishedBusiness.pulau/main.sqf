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

_westHQ = createCenter west;
_indepHQ = createCenter independent;

[] execVM "missions\crash_site.sqf";
[] execVM "missions\informator.sqf";
[] execVM "missions\aa.sqf";
[] execVM "missions\intro.sqf";

if (isServer) then {

	// Create random waypoints for enemy and civilian vehicles
	Fn_Task_CreatePatrols = {
		private ["_cars", "_wp", "_marker", "_wp_array", "_group"];
		_cars = [
			synd_jeep_01,
			synd_jeep_02,
			synd_jeep_03,
			synd_jeep_04,
			civ_veh_01,
			civ_veh_02,
			civ_veh_03,
			civ_veh_04
		];
		{
			_group = group driver _x;
			_wp_array = [
				'wp_monse',
				'wp_lalomo',
				'wp_minanga',
				'wp_apal',
				'wp_village_01',
				'wp_village_02',
				'wp_village_03',
				'wp_village_04',
				'wp_village_05',
				'wp_village_06',
				'wp_village_07',
				'wp_village_08'
			];
			for "_i" from 0 to (random 4 + 6) do {
				_marker = selectRandom _wp_array;
				_wp_array = _wp_array - [_marker];
				_wp = _group addWaypoint [getMarkerPos _marker, 0];
				_wp setWaypointCombatMode "YELLOW";
				_wp setWaypointBehaviour "SAFE";
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointFormation "NO CHANGE";
				_wp setWaypointType "MOVE";
			};
			_marker = selectRandom _wp_array;
			_wp_array = _wp_array - [_marker];
			_wp = _group addWaypoint [getMarkerPos _marker, 0];
			_wp setWaypointCombatMode "YELLOW";
			_wp setWaypointBehaviour "SAFE";
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointFormation "NO CHANGE";
			_wp setWaypointType "CYCLE";
		} forEach _cars;
	};

	Fn_Endgame_Loss = {
		if (isServer) then {
			['t_defend_blockpost', 'FAILED'] call BIS_fnc_taskSetState;
			"EveryoneLost" call BIS_fnc_endMissionServer;
		};
	};

	Fn_Endgame_Win = {
		if (isServer) then {
			"EveryoneWon" call BIS_fnc_endMissionServer;
		};
	};

	sleep 5;
	
	call Fn_Task_CreatePatrols;
	call Fn_Task_Create_ArriveToIsland;
};

// We need to end game if all players are no longer alive
[] execVM "addons\brezblock\triggers\end_game.sqf";
