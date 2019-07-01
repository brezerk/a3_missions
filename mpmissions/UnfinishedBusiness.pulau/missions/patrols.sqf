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

	Fn_Patrols_CreateCivilean_Traffic = {
		params['_poi'];
		//Create civ vehicle patrols
		private _vehicles = [
			'C_Van_01_box_F',
			'C_Van_01_transport_F',
			'C_SUV_01_F',
			'C_Offroad_01_F',
			'C_Truck_02_fuel_F',
			'C_Truck_02_box_F',
			'C_Truck_02_transport_F',
			'C_Truck_02_covered_F',
			'CUP_C_Skoda_White_CIV',
			'CUP_C_Skoda_Blue_CIV',
			'CUP_C_Dutsan_Tubeframe',
			'CUP_C_Dutsan_Covered',
			'CUP_C_Tractor_CIV',
			'CUP_C_Volha_Blue_TKCIV',
			'CUP_C_V3S_Open_TKC',
			'CUP_C_V3S_Covered_TKC'
		];
		
		{ 
			for "_i" from 0 to (random 2) do {
				sleep 1;
				private _class = selectRandom _vehicles;
				private _pos = [_x select 1, 0, 90, 15, 0, 0, 0] call BIS_fnc_findSafePos;
				private _crew = [_pos, civilian, [_class]] call BIS_fnc_spawnGroup;
				if (isNull _crew) then {
					[format ["ERROR: %1", _class]] remoteExec ["systemChat"];
				} else {
					private _units = units _crew;
					{
						private _vehicle = assignedVehicle _x;
						if (!isNull _vehicle) exitWith {
							vehicle_patrol_group append [_vehicle];
							vehicle_refuel_group append [_vehicle];
							vehicle_confiscate_group append [_vehicle];
						};
					} forEach _units;
				};
			};
		} forEach _poi;
	};
	
	Fn_Patrols_CreateMilitary_Traffic = {
		params['_poi'];
		private _vehicles = [];
		switch (D_FRACTION_INDEP) do
		{
			case 'IND_F': {
				_vehicles = [
					'CUP_I_LR_MG_AAF',
					'CUP_I_LR_SF_GMG_AAF',
					'CUP_I_LR_SF_HMG_AAF'
				];
			};
			case 'IND_G_F': {
				_vehicles = [
					'I_G_Offroad_01_AT_F',
					'I_G_Offroad_01_F',
					'I_G_Offroad_01_armed_F'
				];
			};
			case 'CUP_I_NAPA': {
				_vehicles = [
					'CUP_I_Datsun_PK',
					'CUP_I_Datsun_PK_Random',
					'CUP_I_Datsun_PK'
				];
			};
			case 'CUP_I_RACS': {
				_vehicles = [
					'CUP_I_LR_MG_RACS'
				];
			};
			case 'CUP_I_TK_GUE': {
				_vehicles = [
					'CUP_I_Datsun_PK_TK',
					'CUP_I_Datsun_PK_TK_Random',
					'CUP_I_Datsun_PK'
				];
			};
		};
		{ 
			for "_i" from 0 to (random 2) do {
				private _class = selectRandom _vehicles;
				private _pos = [_x select 1, 0, 90, 15, 0, 0, 0] call BIS_fnc_findSafePos;
				//[format ["W: %1 %2", _pos, _class]] remoteExec ["systemChat"];
				private _crew = [_pos, independent, [_class]] call BIS_fnc_spawnGroup;
				_units = units _crew;
				{
					_vehicle = assignedVehicle _x;
					if (!isNull _vehicle) exitWith {
						vehicle_patrol_group append [_vehicle];
						vehicle_refuel_group append [_vehicle];
						vehicle_confiscate_group append [_vehicle];
					};
					[format ["ERROR: %1", _class]] remoteExec ["systemChat"];
				} forEach _units;
			};
		} forEach _poi;
	};
		
	// Create random waypoints for enemy and civilian vehicles
	Fn_Patrols_Create_Random_Waypoints = {
		params ["_vehicles", "_lcs_array"];
		private ["_wp", "_pos"];
		private _wp_array = [];
		{
			_wp_array append [_x select 1];
		} forEach _lcs_array;
		
		{
			_wp_avalible = _wp_array;
			//include airfield
			_wp_avalible append [getMarkerPos format ["wp_air_field_%s_01", D_LOCATION]];
			private _group = group driver _x;
			for "_i" from 0 to (round (count _wp_array / 2)) do {
				_pos = selectRandom _wp_avalible;
				if (isNil "_pos") exitWith {};
				_wp_avalible = _wp_avalible - [_pos];
				_wp = _group addWaypoint [_pos, 0];
				_wp setWaypointCombatMode "YELLOW";
				_wp setWaypointBehaviour "SAFE";
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointFormation "NO CHANGE";
				_wp setWaypointType "MOVE";
			};
			
			_pos = selectRandom _wp_array;
			_wp = _group addWaypoint [_pos, 0];
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
			for "_i" from 0 to (random 4 + 4) do {
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
