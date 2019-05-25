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
		private ['_trg'];
		trg = createTrigger ["EmptyDetector", getMarkerPos "USS Liberty" ];
		trg setTriggerArea [0, 0, 0, false];
		trg setTriggerActivation ["NONE", "PRESENT", false];
		trg setTriggerStatements [
			"call Fn_MissionIntro_Evaluate;",
			"call Fn_MissionIntro_SendHelicopter; deleteVehicle trg;",
			""
		];
		[
			west,
			"t_arrive_to_island",
			[localize "TASK_02_DESC",
			localize "TASK_02_TITLE",
			localize "TASK_ORIG_01"],
			getMarkerPos "wp_air_field_01",
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_arrive_to_island', "land"] call BIS_fnc_taskSetType;
	}; // Fn_Task_InjuredEvacuation_CallMedEvac

	Fn_MissionIntro_Evaluate = {
		private ["_all_on_board"];
		
		_all_on_board = true;
		{
			if (objectParent _x != us_airplane_01) then {
				_all_on_board = false;
				systemChat "No on board...!";
			};
		} forEach (playableUnits + switchableUnits);
		_all_on_board;
	}; // Fn_Task_InjuredEvacuation_Evaluate
	
	Fn_MissionIntro_SendHelicopter = {
		systemChat "OK. All abourd!";
		private ['_wp', '_group', '_markerPos'];
		us_airplane_01 lock 2;
		{
			if (isPlayer _x) then {
				assault_group = assault_group + [_x];
			};
		} forEach crew us_airplane_01;
		_group = group driver us_airplane_01;
		{
			_wp = _group addWaypoint [getMarkerPos _x, 0];
			_wp setWaypointCombatMode "YELLOW";
			_wp setWaypointBehaviour "SAFE";
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointFormation "NO CHANGE";
			_wp setWaypointType "MOVE";
		} forEach ['wp_air_field_01'];
		us_airplane_01 flyInHeight 1000;
		(driver us_airplane_01) setBehaviour "Careless";
		(driver us_airplane_01) setCombatMode "Blue";
		execVM "missions\fast_travel.sqf";
	}; // Fn_MissionIntro_SendHelicopter
};