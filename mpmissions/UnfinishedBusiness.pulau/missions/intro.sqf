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

	Fn_Create_MissionIntro = {
	
		private _class = selectRandom D_FRACTION_WEST_UNITS_TRANSPORT;
		private _crew_class = getText(configFile >> "CfgVehicles" >> _class >> "crew");
		
		us_airplane_01 = createVehicle [_class, (getPos land_00), [], 0, "CAN_COLLIDE"];
		us_airplane_01 attachTo [land_00, [0, 0, 0]];
		us_airplane_01 setDir (getDir land_00);
		
		private _grp = createGroup [west, true];
		
		private _unit = _grp createUnit [_crew_class, us_airplane_01, [], 0, "CARGO"];
		_unit moveInDriver us_airplane_01;
		_unit assignAsDriver us_airplane_01;
		_unit setBehaviour "Careless";

		//FIXME: Add init cargo: ammo, acex, base rifles
		
		us_heli_01 = createVehicle [(selectRandom D_FRACTION_WEST_UNITS_HELI), (getPos land_01), [], 0, "CAN_COLLIDE"];
		us_heli_01 attachTo [land_01, [0, 0, 0]];
		us_heli_01 setDir ([getPos (us_airplane_01), getPos(us_heli_01)] call BIS_fnc_dirTo);
		us_heli_01 setVehicleLock "LOCKED";
		
		us_boat_01 = createVehicle [(selectRandom D_FRACTION_WEST_UNITS_BOATS), [0, 0, 0], [], 0, "CAN_COLLIDE"];
		west_rack_01 setVehicleCargo us_boat_01;
		us_boat_01 setVehicleLock "LOCKED";
		
		us_boat_02 = createVehicle [(selectRandom D_FRACTION_WEST_UNITS_BOATS), [0, 0, 0], [], 0, "CAN_COLLIDE"];
		west_rack_02 setVehicleCargo us_boat_02;
		us_boat_02 setVehicleLock "LOCKED";
		
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
			"execVM 'missions\jet_is_down.sqf'; deleteVehicle thisTrigger;",
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
		
		_trg = createTrigger ["EmptyDetector", getMarkerPos "mrk_east_base_02"];
		_trg setTriggerArea [1000, 1000, 0, false];
		_trg setTriggerActivation ["WEST", "PRESENT", false];
		_trg setTriggerStatements [
			"this",
			"call Fn_MissionIntro_Blowup; deleteVehicle thisTrigger;",
			""
		];
			
		if (hasInterface) then {
			remoteExecCall ["Fn_Local_Create_MissionIntro"];
		} else {
			remoteExecCall ["Fn_Local_Create_MissionIntro", -2];
		}
	}; // Fn_Create_MissionIntro
	
	
	Fn_MissionIntro_MakeEnemies = {
		if (hasInterface) then {
			remoteExecCall ["Fn_Local_MakeEnemies"];
		} else {
			remoteExecCall ["Fn_Local_MakeEnemies", -2];
		};
		EAST setFriend [WEST, 0];
		WEST setFriend [EAST, 0];
	};
	
	Fn_MissionIntro_Blowup = {
		private _expl1 = "DemoCharge_Remote_Ammo_Scripted" createVehicle (position us_airplane_01);
		_expl1 attachTo [us_airplane_01, [0.0,0.0,-2.0]];
		_expl1 setDamage 1;
	};

	Fn_MissionIntro_Evaluate = {
		private _all_on_board = true;
		{
			if (objectParent _x != us_airplane_01) then {
				_all_on_board = false;
			};
		} forEach (playableUnits + switchableUnits);
		if ((count (playableUnits + switchableUnits)) == 0) then {
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
			};
		} forEach crew us_airplane_01;
		private _group = group driver us_airplane_01;
		private _wp = _group addWaypoint [getMarkerPos "mrk_flight_waypoint", 0];
		_wp setWaypointCombatMode "YELLOW";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointFormation "NO CHANGE";
		_wp setWaypointType "MOVE";
		us_airplane_01 flyInHeight 1500;
		(driver us_airplane_01) setBehaviour "Careless";
		(driver us_airplane_01) setCombatMode "Blue";
		execVM "missions\fast_travel.sqf";
	}; // Fn_MissionIntro_SendAirplane
	
};