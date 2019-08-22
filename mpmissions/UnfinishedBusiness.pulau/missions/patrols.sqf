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
		
		{ 
			private _center = _x select 1;
			private _roads = _center nearRoads 100;
			
			private _good_roads = [];
			
			{
				private _pos = position _x;
				if ((count (nearestObjects [_pos, ["Car", "Truck"], 10]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 5, false, true]) == 0)) then {
					private _bbox = boundingboxReal _x;
					private _a = _bbox select 0;
					private _b = _bbox select 1;
					private _size = _a distance _b;
					if (_size >= 25) then {
						_good_roads append [_x];
					};
				};
				if (count _good_roads >= 10) exitWith {};
			} forEach _roads;
			
			for "_i" from 0 to ((random 3) + 1) do {
				private _class = selectRandom D_FRACTION_CIV_UNITS_CARS;
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
		
		{ 
			private _center = _x select 1;
			private _roads = _center nearRoads 100;
			
			private _good_roads = [];
			
			{
				private _pos = position _x;
				if ((count (nearestObjects [_pos, ["Car", "Truck"], 5]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 5, false, true]) == 0)) then {
					private _bbox = boundingboxReal _x;
					private _a = _bbox select 0;
					private _b = _bbox select 1;
					private _size = _a distance _b;
					if (_size >= 25) then {
						_good_roads append [_x];
					};
				};
				if (count _good_roads >= 10) exitWith {};
			} forEach _roads;
			
			for "_i" from 0 to (random 2) do {
				private _class = selectRandom D_FRACTION_CIV_UNITS_CARS;
				private _road = selectRandom _good_roads;
				if (isNil "_road") exitWith {};
				_good_roads = _good_roads - [_road];
				private _pos = position _road;
				private _connected = roadsConnectedto (_road);
				
				private _vehicle = createVehicle [_class, _pos];
				_vehicle limitSpeed 30; 
				
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
	
	Fn_Patrols_CreateMilitary_Traffic = {
		params['_poi'];
		{ 
			private _center = _x select 1;
			private _roads = _center nearRoads 150;
			
			private _good_roads = [];
			
			{
				private _pos = position _x;
				if ((count (nearestObjects [_pos, ["Car", "Truck"], 5]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 5, false, true]) == 0)) then {
					private _bbox = boundingboxReal _x;
					private _a = _bbox select 0;
					private _b = _bbox select 1;
					private _size = _a distance _b;
					if (_size >= 25) then {
						_good_roads append [_x];
					};
				};
				if (count _good_roads >= 10) exitWith {};
			} forEach _roads;
			
			for "_i" from 0 to (random 2) do {
				private _class = selectRandom D_FRACTION_INDEP_UNITS_CARS;
				private _road = selectRandom _good_roads;
				if (isNil "_road") exitWith {};
				_good_roads = _good_roads - [_road];
				private _pos = position _road;
				private _connected = roadsConnectedto (_road);
				
				private _vehicle = createVehicle [_class, _pos];
				_vehicle limitSpeed 40;
				
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
		private _ret = [(getMarkerPos "mrk_west_crashsite"), 4000, 6] call BrezBlock_fnc_GetAllCitiesInRange;
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
	
	Fn_Patrols_CreateLoiter = {
		params ['_markerPos'];
		
		private _class = objNull;
		
		switch (D_DIFFICLTY) do {
			case 0: {
				_class = "CUP_I_UH60L_RACS"; //"CUP_I_UH1H_TK_GUE"
			};
			case 1: {
				_class = "CUP_I_UH60L_RACS"; //CUP_I_UH1H_armed_TK_GUE
			};
			case 2: {
				_class = "CUP_I_UH60L_RACS"; //CUP_I_UH1H_gunship_TK_GUE
			};
		};
		
		private _vehicle = createVehicle [_class, getMarkerPos "mrk_patrol_heli"];
		private _crew = createVehicleCrew (_vehicle);
		vehicle_refuel_group append [_vehicle];
		private _wp = group _vehicle addWaypoint [_markerPos, 0];
		_wp setWaypointType "loiter";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointLoiterType "Circle_L";
		_wp setWaypointLoiterRadius 500;
		_vehicle flyInHeight 130;
		{
			_x setSkill 0.7; 
		} forEach units _crew;
	};
	
	Fn_Patrols_Create_Transport_Sentry = {
		params ['_markerPos'];
		
		private _task_force = [];
		
		for "_i" from 1 to 10 do {
			_task_force pushBack (selectRandom D_FRACTION_INDEP_UNITS_PATROL);
		};
		
		//FIXME: spawn on nearest POI instead
		private _center = getMarkerPos "mrk_spawn_point";
		private _pos = [];
		private _good = false;
		private _class = selectRandom D_FRACTION_INDEP_UNITS_TRANSPORT;
		
		while {!_good} do {
			_pos = [_center, 5, 50, 5, 0, 0, 0] call BIS_fnc_findSafePos;
			if ((count (nearestObjects [_pos, ["Car", "Truck"], 5]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 5, false, true]) == 0)) then {
				_good = true;
			};
		};
		
		private _vehicle = createVehicle [_class, _pos];
		_vehicle limitSpeed 40;
		private _crew = createVehicleCrew (_vehicle);
		
		private _group = [_pos, independent, _task_force,[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		
		{
			_x assignAsCargo _vehicle;
			_x moveInCargo _vehicle;
		} forEach units _group;
		
		private _wp = group _vehicle addWaypoint [_markerPos, 0];
		_wp setWaypointType "TR UNLOAD";
		_wp setWaypointCombatMode "WHITE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
		
		_wp = _group addWaypoint [_markerPos, 0];
		_wp setWaypointType "SENTRY";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointBehaviour "STEALTH";
		
		_vehicle;
	};
	
	Fn_Patrols_Create_Sentry = {
		params ['_markerPos'];
		
		private _class = selectRandom D_FRACTION_INDEP_UNITS_CARS;
		//FIXME: spawn on nearest POI instead
		private _center = getMarkerPos "mrk_spawn_point";
		private _pos = [];
		private _good = false;
		
		while {!_good} do {
			_pos = [_center, 5, 50, 5, 0, 0, 0] call BIS_fnc_findSafePos;
			if ((count (nearestObjects [_pos, ["Car", "Truck"], 5]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 5, false, true]) == 0)) then {
				_good = true;
			};
		};
		
		private _vehicle = createVehicle [_class, _pos];
		_vehicle limitSpeed 40;
		private _crew = createVehicleCrew (_vehicle);
		
		private _wp = group _vehicle addWaypoint [_markerPos, 0];
		_wp setWaypointType "SENTRY";
		_wp setWaypointCombatMode "WHITE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
		
		_vehicle;
	};
	
};
