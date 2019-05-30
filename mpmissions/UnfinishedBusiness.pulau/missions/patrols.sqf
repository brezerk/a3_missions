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


if (isServer) then { 
		
	// Create random waypoints for enemy and civilian vehicles
	Fn_Patrols_Create_Random_Waypoints = {
		params ["_vehicles"];
		private ["_wp", "_marker", "_wp_array", "_group"];
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
		} forEach _vehicles;
	};
	
	Fn_Patrols_Create_Random_SeaWaypoints = {
		params ["_vehicles"];
		private ["_wp", "_marker", "_wp_array", "_group"];
		{
			_group = group driver _x;
			_wp_array = [
				'wp_cargo_01',
				'wp_cargo_02',
				'wp_cargo_03',
				'wp_cargo_04',
				'wp_cargo_05',
				'wp_cargo_06',
				'wp_cargo_07',
				'wp_cargo_08',
				'wp_cargo_09',
				'wp_cargo_10'
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
		} forEach _vehicles;
	};
	
	Fn_Patrols_CreateLoiter = {
		params ['_markerPos', '_vehicle'];
		private ['_wp'];
		_wp = group _vehicle addWaypoint [_markerPos, 0];
		_wp setWaypointType "loiter";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointLoiterType "Circle_L";
		_wp setWaypointLoiterRadius 500;
		_vehicle flyInHeight 100;
	};
	
	Fn_Patrols_Create_Transport_Sentry = {
		params ['_markerPos', '_vehicle', '_group'];
		private ['_wp'];
		{
			_x assignAsCargo _vehicle;
			_x moveInCargo _vehicle;
		} forEach units _group;
			
		_wp = group _vehicle addWaypoint [_markerPos, 0];
		_wp setWaypointType "TR UNLOAD";
		_wp setWaypointCombatMode "WHITE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
		
		_wp = _group addWaypoint [_markerPos, 0];
		_wp setWaypointType "SENTRY";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointBehaviour "STEALTH";
	};
	
	Fn_Patrols_Create_Sentry = {
		params ['_markerPos', '_vehicle'];
		private ['_wp'];
		_wp = group _vehicle addWaypoint [_markerPos, 0];
		_wp setWaypointType "SENTRY";
		_wp setWaypointCombatMode "WHITE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
	};
};