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
Spawn start objectives, triggers for game intro and players allocation
*/


//Player side triggers
// Client side code
if (hasInterface) then {
};

if (isServer) then {

	Fn_Spawn_Boat_At_Rack = {
		params['_rack'];
		private _veh = objNull;
		if (count (getVehicleCargo _rack) == 0) then {
			_veh = createVehicle [(selectRandom D_FRACTION_WEST_UNITS_BOATS), [0, 0, 0], [], 0, "CAN_COLLIDE"];
			_veh allowDamage false;
			_rack setVehicleCargo _veh;
			_veh allowDamage true;
			[_veh] execVM 'addons\BrezBlock.framework\triggers\despawn_transport.sqf';
		};
		_veh;
	};
	
	Fn_Spawn_Boat_At = {
		params['_marker'];
		private _veh = createVehicle [(selectRandom D_FRACTION_WEST_UNITS_BOATS), [0, 0, 0], [], 0, "CAN_COLLIDE"];
		_veh allowDamage false;
		_veh setPosASL (markerPos _marker);
		_veh setDir (markerDir _marker);
		_veh allowDamage true;
	};
	
	Fn_Spawn_Heli = {
		params['_pos', '_dir'];
		private _veh = objNull;
		if (count (nearestObjects [_pos, ["Car", "Tank", "APC", "Boat", "Drone", "Plane", "Helicopter"], 6]) == 0) then {
			_veh = createVehicle [(selectRandom D_FRACTION_WEST_UNITS_HELI), [0, 0, 0], [], 0, "CAN_COLLIDE"];
			_veh allowDamage false;
			_veh setPosASL (_pos);
			_veh setDir (_dir);
			[_veh] execVM 'addons\BrezBlock.framework\triggers\despawn_transport.sqf';
		};
		_veh;
	};

	Fn_Create_MissionIntro = {
		private _class = selectRandom D_FRACTION_WEST_UNITS_TRANSPORT;
		private _crew_class = getText(configFile >> "CfgVehicles" >> _class >> "crew");
		private _pad = [us_liberty_01, "Land_HelipadEmpty_F"] call BIS_fnc_Destroyer01GetShipPart;
		private _obj = createVehicle ["Land_MapBoard_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
		
		_obj setPosASL (us_liberty_01 modelToWorldWorld [0,43.5,8.95]);
		_obj setDir (getDir us_liberty_01);
		_obj setObjectTextureGlobal [0, getText(configFile >> "CfgWorlds" >> worldName >> "pictureMap")];
		//configfile >> "CfgWorlds" >> "pulau" >> "pictureMap"
		//configfile >> "CfgWorlds" >> "pulau" >> "pictureShot"
		
		_obj = createVehicle ["Land_Camping_Light_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
		_obj setPosASL (us_liberty_01 modelToWorldWorld [1.3,43.5,8.95]);
		_obj setDir (getDir us_liberty_01);
		
		_obj = createVehicle ["B_supplyCrate_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
		_obj setPosASL (us_liberty_01 modelToWorldWorld [3.5,43.5,8.95]);
		_obj setDir (getDir us_liberty_01 + 45);
		[_obj, "base", west, D_FRACTION_WEST] call BrezBlock_fnc_PopulateBaseSupply;
		
		_obj = createVehicle ["B_supplyCrate_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
		_obj setPosASL (us_liberty_01 modelToWorldWorld [-3.5,43.5,8.95]);
		_obj setDir (getDir us_liberty_01 - 45);
		[_obj, "base", west, D_FRACTION_WEST] call BrezBlock_fnc_PopulateBaseSupply;
		
		private _pos = getMarkerPos "mrk_west_specops";
		private _dir = markerDir "mrk_west_specops";
		private _obj_map = createVehicle ["Land_MapBoard_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
		_obj_map setPosASL [(_pos select 0), (_pos select 1), 3];
		_obj_map setDir (_dir);
		
		_obj = createVehicle ["Land_Camping_Light_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
		_obj setPosASL (_obj_map modelToWorldWorld [1.3,-1.5,3]);
		_obj setDir (getDir _obj_map);
		
		_obj = createVehicle ["B_supplyCrate_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
		_obj setPosASL (_obj_map modelToWorldWorld [3.5,-3.5,3]);
		_obj setDir (getDir _obj_map + 45);
		[_obj, "base", west, D_FRACTION_WEST] call BrezBlock_fnc_PopulateBaseSupply;
		
		_obj = createVehicle ["B_supplyCrate_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
		_obj setPosASL (_obj_map modelToWorldWorld [-3.5,-3.5,3]);
		_obj setDir (getDir _obj_map - 45);
		[_obj, "base", west, D_FRACTION_WEST] call BrezBlock_fnc_PopulateBaseSupply;
		
		//_obj = createVehicle ["Land_Camping_Light_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
		//_obj setPosASL (us_liberty_01 modelToWorldWorld [0,30,11]);
		//_obj setDir (getDir us_liberty_01);
		
		us_airplane_01 = createVehicle [_class, [0, 0, 0], [], 0, "CAN_COLLIDE"];
		us_airplane_01 allowDamage false;

		us_airplane_01 setPosASL (us_liberty_01 modelToWorldWorld [0,76.6011,8.95]);
		us_airplane_01 setDir (getDir us_liberty_01);
		us_airplane_01 animateDoor ['Door_1_source', 1];
		us_airplane_01 setVehicleAmmo 0;
		
		us_heli_01 = [(us_liberty_01 modelToWorldWorld [0,50.6011,8.95]), (getDir us_liberty_01)] call Fn_Spawn_Heli;
		
		/*createVehicle [(selectRandom D_FRACTION_WEST_UNITS_HELI), [0, 0, 0], [], 0, "CAN_COLLIDE"];
		//private _pos = getPos land_01;
		us_heli_01 allowDamage false;
		us_heli_01 setPosASL ();
		us_heli_01 setDir ();*/
		us_heli_01 setVehicleLock "LOCKED";
		
		us_boat01 = [west_rack_01] call Fn_Spawn_Boat_At_Rack;
		us_boat01 setVehicleLock "LOCKED";
		us_boat02 = [west_rack_02] call Fn_Spawn_Boat_At_Rack;
		us_boat02 setVehicleLock "LOCKED";
		
		//[Fn_Spawn_Boat_Rack01, [0, 0, 0], 180, 20, 15] execVM 'addons\BrezBlock.framework\triggers\respawn_transport.sqf';
		//[Fn_Spawn_Boat_Rack02, [0, 0, 0], 180, 20, 15] execVM 'addons\BrezBlock.framework\triggers\respawn_transport.sqf';
		
		["mrk_spec_boat01"] call Fn_Spawn_Boat_At;
		["mrk_spec_boat02"] call Fn_Spawn_Boat_At;
		
		private _trg = createTrigger ["EmptyDetector", getMarkerPos "respawn_west" ];
		_trg setTriggerArea [0, 0, 0, false];
		_trg setTriggerActivation ["NONE", "PRESENT", false];
		_trg setTriggerStatements [
			"call Fn_MissionIntro_Evaluate;",
			"call Fn_MissionIntro_SendAirplane; deleteVehicle thisTrigger;",
			""
		];
		
		_trg = createTrigger ["EmptyDetector", getMarkerPos "mrk_airfield" ];
		_trg setTriggerArea [0, 0, 0, false];
		_trg setTriggerActivation ["NONE", "PRESENT", false];
		_trg setTriggerStatements [
			"!canMove us_airplane_01 || !alive us_airplane_01",
			"execVM 'UnfinishedBusiness.core\missions\jet_is_down.sqf'; deleteVehicle thisTrigger;",
			""
		];
		_trg = createTrigger ["EmptyDetector", getMarkerPos "mrk_east_base_02"];
		_trg setTriggerArea [1500, 1500, 0, false];
		_trg setTriggerActivation ["WEST", "PRESENT", false];
		_trg setTriggerStatements [
			"this",
			"call Fn_MissionIntro_MakeEnemies; deleteVehicle thisTrigger;",
			""
		];
		
		if (D_START_TYPE == 0) then {
			_trg = createTrigger ["EmptyDetector", getMarkerPos "mrk_east_base_02"];
			_trg setTriggerArea [1100, 1100, 0, false];
			_trg setTriggerActivation ["WEST", "PRESENT", false];
			_trg setTriggerStatements [
				"this",
				"execVM 'UnfinishedBusiness.core\missions\intro_blowup.sqf'; deleteVehicle thisTrigger;",
				""
			];
		};
			
		remoteExecCall ["Fn_Local_Create_MissionIntro", [0,-2] select isDedicated];
		us_airplane_01 allowDamage true;
		us_heli_01 allowDamage true;
		
		private _grp = createVehicleCrew (us_airplane_01);
		{
			_x allowDamage false;
		} forEach (units _grp);
		_grp setBehaviour "Careless";
		
		
	}; // Fn_Create_MissionIntro
	
	
	Fn_MissionIntro_MakeEnemies = {
		remoteExecCall ["Fn_Local_MakeEnemies", [0,-2] select isDedicated];
		EAST setFriend [WEST, 0];
		WEST setFriend [EAST, 0];
		if (D_START_TYPE == 1) then {
			execVM 'UnfinishedBusiness.core\missions\intro_blowup.sqf';
		};
	};

	Fn_MissionIntro_Evaluate = {
		private _all_on_board = true;
		private _players = 0;
		
		{
			if ((_x distance2d us_airplane_01) <= 300) then{
				_players = _players + 1;
				if (objectParent _x != us_airplane_01) then {
					_all_on_board = false;
				};
			};
		} forEach (playableUnits + switchableUnits);
		
		if (_players == 0) then {
			_all_on_board = false;
		};
		
		_all_on_board;
	}; // Fn_MissionIntro_Evaluate
	
	Fn_MissionIntro_SendAirplane = {
		mission_plane_send = true;
		publicVariable "mission_plane_send";
		us_airplane_01 lock 2;
		{
			if (isPlayer _x) then {
				assault_group = assault_group + [_x];
				[_x, false] remoteExec ["allowDamage"];
				_x setVariable ["is_assault_group", true, true];
			} else {
				_x allowDamage true;
			};
		} forEach crew us_airplane_01;
		{
			if (side _x == west) then {
				if ((_x distance2d us_airplane_01) > 500) then {
					_x setVariable ["is_specops_group", true, true];
				};
			};
		} forEach (playableUnits + switchableUnits);
		us_airplane_01 animateDoor ['Door_1_source', 0];
		private _group = group driver us_airplane_01;
		private _wp = _group addWaypoint [getMarkerPos "mrk_airfield", 0];
		_wp setWaypointCombatMode "YELLOW";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "FULL";
		_wp setWaypointFormation "NO CHANGE";
		_wp setWaypointType "MOVE";
		us_airplane_01 flyInHeight 1500;
		(driver us_airplane_01) setBehaviour "Careless";
		(driver us_airplane_01) setCombatMode "Blue";
		private _time = date;
		mission_plane_send_time = format["%1:%2", _time select 3, _time select 4];
		mission_plane_pass_count = (count assault_group);
		publicVariable "mission_plane_send_time";
		publicVariable "mission_plane_pass_count";
		execVM "UnfinishedBusiness.core\missions\fast_travel.sqf";
	}; // Fn_MissionIntro_SendAirplane
	
};