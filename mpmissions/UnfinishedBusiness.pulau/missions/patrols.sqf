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

	Fn_Task_Spawn_Civilean_Cars = {
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
			private _center = _x select 1;
			private _roads = _center nearRoads 150;
			
			private _good_roads = [];
			
			{
				private _pos = position _x;
				if ((count (nearestObjects [_pos, ["Car", "Truck"], 5]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 5, false, true]) == 0)) then {
					_good_roads append [_x];
				};
				if (count _good_roads >= 10) exitWith {};
			} forEach _roads;
			
			for "_i" from 0 to ((random 3) + 2) do {
				private _class = selectRandom _vehicles;
				private _road = selectRandom _good_roads;
				if (isNil "_road") exitWith {};
				_good_roads = _good_roads - [_road];
				private _pos = position _road;
				private _dir = getDir _road;
				private _connected = roadsConnectedto (_road);
				
				if (count _connected > 0) then {
					private _connected_pos = getPos (_connected select 0);
					_dir = [_pos, _connected_pos] call BIS_fnc_DirTo;	
				};
				
				_pos = [_pos, 3, _dir + 90] call BIS_Fnc_relPos;
				
				private _vehicle = createVehicle [_class, _pos];
				_vehicle setDir _dir;
			};
		} forEach _poi;
	};

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
			private _center = _x select 1;
			private _roads = _center nearRoads 150;
			
			private _good_roads = [];
			
			{
				private _pos = position _x;
				if ((count (nearestObjects [_pos, ["Car", "Truck"], 5]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 5, false, true]) == 0)) then {
					_good_roads append [_x];
				};
				if (count _good_roads >= 10) exitWith {};
			} forEach _roads;
			
			for "_i" from 0 to (random 3) do {
				private _class = selectRandom _vehicles;
				private _road = selectRandom _good_roads;
				_good_roads = _good_roads - [_road];
				if (isNil "_road") exitWith {};
				private _pos = position _road;
				private _connected = roadsConnectedto (_road);
				
				private _vehicle = createVehicle [_class, _pos];
				_vehicle limitSpeed 30; 
				
				if (count _connected > 0) then {
					private _connected_pos = getPos (_connected select 0);
					private _dir = [_pos, _connected_pos] call BIS_fnc_DirTo;
							
					_vehicle setDir _dir;
				};
				 
				_vehicle addAction [localize 'ACTION_03', "call Fn_Patrol_ConfiscateVehicle;", nil, 1, false, true, "", "alive _this", 5];
				 
				private _crew = createVehicleCrew (_vehicle);
				vehicle_patrol_group append [_vehicle];
				vehicle_refuel_group append [_vehicle];
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
			private _center = _x select 1;
			private _roads = _center nearRoads 150;
			
			private _good_roads = [];
			
			{
				private _pos = position _x;
				if ((count (nearestObjects [_pos, ["Car", "Truck"], 5]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 5, false, true]) == 0)) then {
					_good_roads append [_x];
				};
				if (count _good_roads >= 10) exitWith {};
			} forEach _roads;
			
			for "_i" from 0 to ((random 2) + 1) do {
				private _class = selectRandom _vehicles;
				private _road = selectRandom _good_roads;
				if (isNil "_road") exitWith {};
				_good_roads = _good_roads - [_road];
				private _pos = position _road;
				private _connected = roadsConnectedto (_road);
				
				private _vehicle = createVehicle [_class, _pos];
				_vehicle limitSpeed 35; 
				
				if (count _connected > 0) then {
					private _connected_pos = getPos (_connected select 0);
					private _dir = [_pos, _connected_pos] call BIS_fnc_DirTo;
							
					_vehicle setDir _dir;
				};
				 
				private _crew = createVehicleCrew (_vehicle);
				vehicle_patrol_group append [_vehicle];
				vehicle_refuel_group append [_vehicle];
			};
		} forEach _poi;
	};
		
	// Create random waypoints for enemy and civilian vehicles
	Fn_Patrols_Create_Random_Waypoints = {
		private _ret = [(getMarkerPos "wp_crash_site"), 4000, 6] call BrezBlock_fnc_GetAllCitiesInRange;
		private _lcs_array = _ret select 1;
	
		private _wp_array = [];
		{
			_wp_array append [_x select 1];
		} forEach _lcs_array;
		
		{
			_wp_avalible = _wp_array;
			//include airfield
			//_wp_avalible append [getMarkerPos (format ["wp_air_field_%s_01", D_LOCATION])];
			private _group = group driver _x;
			for "_i" from 0 to (round (count _wp_array / 2)) do {
				private _pos = selectRandom _wp_avalible;
				if (isNil "_pos") exitWith {};
				private _wp_avalible = _wp_avalible - [_pos];
				private _wp = _group addWaypoint [_pos, 0];
				_wp setWaypointCombatMode "YELLOW";
				_wp setWaypointBehaviour "SAFE";
				_wp setWaypointSpeed "LIMITED";
				_wp setWaypointCompletionRadius 20;
				_wp setWaypointFormation "NO CHANGE";
				_wp setWaypointType "MOVE";
			};
			
			private _pos = selectRandom _wp_array;
			private _wp = _group addWaypoint [_pos, 0];
			_wp setWaypointCombatMode "YELLOW";
			_wp setWaypointBehaviour "UNCHANGED";
			_wp setWaypointSpeed "UNCHANGED";
			_wp setWaypointCompletionRadius 20;
			_wp setWaypointFormation "NO CHANGE";
			_wp setWaypointType "CYCLE";
		} forEach vehicle_patrol_group;
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
				_wp setWaypointCompletionRadius 20;
				_wp setWaypointType "MOVE";
			};
			_marker = selectRandom _wp_array;
			_wp = _group addWaypoint [getMarkerPos _marker, 0];
			_wp setWaypointCombatMode "YELLOW";
			_wp setWaypointBehaviour "SAFE";
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointCompletionRadius 20;
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
	
	Fn_Patrol_ConfiscateVehicle = {
		params ["_target", "_caller", "_actionId", "_arguments"];
		private["_driver"];
		if (alive _target) then {
			_driver = driver _target;
			if (!isNull _driver) then {
				if ((!isPlayer _driver) && (alive _driver)) then {
					doGetOut _driver;
				};
			};
		};
	};
};
