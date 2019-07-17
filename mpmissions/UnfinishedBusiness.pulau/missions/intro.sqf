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
	(driver us_airplane_01) setBehaviour "Careless";
	us_airplane_01 attachTo [land_00, [0, 0, 0] ];

	Fn_Create_MissionIntro = {
		private ['_trg'];
		_trg = createTrigger ["EmptyDetector", getMarkerPos "USS Liberty" ];
		_trg setTriggerArea [0, 0, 0, false];
		_trg setTriggerActivation ["NONE", "PRESENT", false];
		_trg setTriggerStatements [
			"call Fn_MissionIntro_Evaluate;",
			"call Fn_MissionIntro_SendAirplane;",
			""
		];
		_trg = createTrigger ["EmptyDetector", getMarkerPos format["wp_%1_airfield_01", D_LOCATION] ];
		_trg setTriggerArea [0, 0, 0, false];
		_trg setTriggerActivation ["NONE", "PRESENT", false];
		_trg setTriggerStatements [
			"!canMove us_airplane_01 || !alive us_airplane_01",
			"execVM 'missions\jet_is_down.sqf';",
			""
		];
		_trg = createTrigger ["EmptyDetector", getPos csat_aa_01];
		_trg setTriggerArea [1500, 1500, 0, false];
		_trg setTriggerActivation ["WEST", "PRESENT", false];
		_trg setTriggerStatements [
			"this",
			"call Fn_MissionIntro_MakeEnemies;",
			""
		];
		_trg = createTrigger ["EmptyDetector", getPos csat_aa_01];
		_trg setTriggerArea [900, 900, 0, false];
		_trg setTriggerActivation ["WEST", "PRESENT", false];
		_trg setTriggerStatements [
			"this",
			"us_airplane_01 setVehicleAmmo 0;",
			""
		];
			
		if (hasInterface) then {
			remoteExecCall ["Fn_Local_Create_MissionIntro"];
		} else {
			remoteExecCall ["Fn_Local_Create_MissionIntro", -2];
		}
	}; // Fn_Create_MissionIntro
	
	
	Fn_MissionIntro_MakeEnemies = {
		//FIXME: Add radio chatter
		if (hasInterface) then {
			remoteExecCall ["Fn_Local_MakeEnemies"];
		} else {
			remoteExecCall ["Fn_Local_MakeEnemies", -2];
		};
		EAST setFriend [WEST, 0];
		WEST setFriend [EAST, 0];
	};

	Fn_MissionIntro_Evaluate = {
		private ["_all_on_board"];
		_all_on_board = true;
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
		private ['_wp', '_group', '_markerPos'];
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
		_group = group driver us_airplane_01;
		_wp = _group addWaypoint [getMarkerPos format["wp_waypoint_%1_01", D_LOCATION], 0];
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