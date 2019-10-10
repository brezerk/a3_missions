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
		params['_roads'];
		//Create civ vehicle patrols
		
		for "_i" from 0 to ((random 3) + 1) do {
			private _class = selectRandom D_FRACTION_CIV_UNITS_CARS;
			private _road = selectRandom _roads;
			if (isNil "_road") exitWith {};
			_roads = _roads - [_road];
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
		
		_roads;
	};

	Fn_Patrols_CreateCivilean_Traffic = {
		params['_roads'];
		
		for "_i" from 0 to (random 2) do {
			private _class = selectRandom D_FRACTION_CIV_UNITS_CARS;
			private _road = selectRandom _roads;
			if (isNil "_road") exitWith {};
			_roads = _roads - [_road];
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
			[
				(driver _vehicle),
				{ [_target] call Fn_Local_Informator_Complete; },
				"simpleTasks\types\talk",
				"ACTION_02",
				"&& alive _target",
				6,
				false
			] call BrezBlock_fnc_Attach_Hold_Action;
			vehicle_patrol_group append [_vehicle];
			vehicle_refuel_group append [_vehicle];
		};
		
		_roads;
	};
	
	Fn_Patrols_CreateMilitary_Traffic = {
		params['_roads'];
	
		for "_i" from 0 to (random 2) do {
			private _class = selectRandom D_FRACTION_INDEP_UNITS_CARS;
			private _road = selectRandom _roads;
			if (isNil "_road") exitWith {};
			_roads = _roads - [_road];
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
		
		_roads;
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
		private _class = (selectRandom ([independent, D_FRACTION_INDEP, "heli"] call Fn_Config_GetFraction_Units));
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
		[_vehicle] execVM "missions\heli_loiter.sqf";
	};
	
	/* 
		Send assoult group
	
		params: 
		_targetPos - target position
		_force_level - desired force level. valid levels are: 0, 1, 2, 3
	*/
	Fn_Patrols_Create_AssaultGroup = {
		params['_targetPos', '_force_level'];
		
		private _force_comp = [];
		
		switch (_force_level) do {
			case 1: { _force_comp = [D_FRACTION_INDEP_UNITS_CARS, D_FRACTION_INDEP_UNITS_TRANSPORT]; };
			case 2: { _force_comp = [D_FRACTION_INDEP_UNITS_CARS, D_FRACTION_INDEP_UNITS_TRANSPORT, D_FRACTION_INDEP_UNITS_LIGHT]; };
			case 3: { _force_comp = [D_FRACTION_INDEP_UNITS_LIGHT, D_FRACTION_INDEP_UNITS_HEAVY, D_FRACTION_INDEP_UNITS_TRANSPORT, D_FRACTION_INDEP_UNITS_CARS]; };
			default { _force_comp = [D_FRACTION_INDEP_UNITS_CARS, D_FRACTION_INDEP_UNITS_CARS]; };
		};
		
		systemChat format ["Create: %1", _force_comp];

		private _roads = [];
		
		scopeName "main";
		{
			if ((_targetPos distance2D (getPos _x)) >= 600) then {
				
				private _clear = true;
				private _pos = getPosASL _x;
				//check if road far away from all players
				{
					if ((_pos distance2D (getPosASL _x)) < 500) then {
						_clear = false;
					};
				} forEach (playableUnits + switchableUnits);
				if (_clear) then {
					// Check if there is any vehicle nearby
					if (count (nearestObjects [_pos, ["Car", "Truck", "Tank"], 50]) == 0) then {
						// Try to find next road to spawn all comp vehicles
						{
							_next_road = ((roadsConnectedto (_next_road)) select 0);
							if (!isNil "_next_road") then {
								private _next_road_pos = getPosASL _next_road;
								if (count (nearestObjects [_next_road_pos, ["Car", "Truck"], 50]) == 0) then {
									_roads pushBack _next_road;
								};
								if ((count _roads) >= (count _force_comp)) then {
									breakTo "main";
								};
							} else {
								_roads = [];
								breakTo "next_road";
							};
						} forEach _force_comp;
					};
				};
			};
		} forEach reinforcement_roads;
		
		if ((count _roads) < (count _force_comp)) exitWith {systemChat "No roads, bail!";};
		
		private _lead_group = grpNull;
		private _uuid = "";
		
		{
			private _road = (_roads select _forEachIndex);
			private _class = selectRandom _x;
			private _vehicle = [_road, _class] call Fn_Patrols_Create_VehicleOnTheRoad;
			if (isNull _vehicle) exitWith {systemChat "Spawn error, bil";};
			if (_forEachIndex == 0) then {
				_lead_group = group (driver _vehicle);
				_uuid = (_lead_group call BIS_fnc_netId);
			} else {
				(crew _vehicle) joinSilent _lead_group;
			};
			_vehicle setVariable ['assault_uuid', _uuid, false];
			private _infantry = [];
			for "_i" from 1 to (getNumber (configfile >> "CfgVehicles" >> _class >> "transportSoldier")) do {
				_infantry pushBack (selectRandom D_FRACTION_INDEP_UNITS_PATROL);
			};
				
			if ((count _infantry) > 0) then {
				private _group = [(getPos _road), independent, _infantry,[],[],[],[],[],180] call BIS_fnc_spawnGroup;		
				{
					_x assignAsCargo _vehicle;
					_x moveInCargo _vehicle;
				} forEach units _group;
				private _wp = _group addWaypoint [_targetPos, 0];
				_wp setWaypointType "MOVE";
				_wp setWaypointCombatMode "YELLOW";
				_wp setWaypointBehaviour "AWARE";
				_wp setWaypointCompletionRadius 350; 
				_wp setWaypointSpeed "FULL";
			
				_wp = _group addWaypoint [_targetPos, 0];
				_wp setWaypointType "SAD";
				_wp setWaypointCombatMode "RED";
				_wp setWaypointCompletionRadius 100;
				_wp setWaypointBehaviour "COMBAT";
				_wp setWaypointSpeed "FULL";
			};
		} forEach _force_comp;
		
		_lead_group setFormation "COLUMN";
		
		private _wp = _lead_group addWaypoint [_targetPos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCombatMode "WHITE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointCompletionRadius 350; 
		_wp setWaypointSpeed "NORMAL";
		
		_lead_group addWaypoint [_targetPos, 0];
		_wp setWaypointType "SAD";
		_wp setWaypointCombatMode "RED";
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointSpeed "NORMAL";
		
		[_uuid, _targetPos, 250] execVM "addons\brezblock\utils\vehicleAssault.sqf";
		
	};
	
	Fn_Patrols_Create_VehicleOnTheRoad = {
		params['_road', '_class'];
		if (isNil "_road") exitWith {};
		private _pos = position _road;
		private _connected = roadsConnectedto (_road);
			
		private _crew = creategroup independent;
		private _vehicle = ([_pos, 140, _class, _crew] call BIS_fnc_spawnVehicle) select 0;

		if (isNull _vehicle) exitWith {systemChat format ["Spawining %1... GOt class back: %2", _class, _vehicle]; _vehicle};
		
		_vehicle limitSpeed 40;
				
		if (count _connected > 0) then {
			private _connected_pos = getPos (_connected select 0);
			private _dir = [_pos, _connected_pos] call BIS_fnc_DirTo;
							
			_vehicle setDir _dir;
		};
		
		_vehicle;
	};
	
};
