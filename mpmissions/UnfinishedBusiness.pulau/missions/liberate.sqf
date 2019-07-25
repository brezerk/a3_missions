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

// Server side code
if (isServer) then {

	trgCivLiberate00 = objNull;
	trgCivLiberate01 = objNull;

	Fn_Create_Logic_CivilianLiberateCity = {
		
		trgCivLiberate00 = createTrigger ["EmptyDetector", getMarkerPos "wp_city_0"];
		trgCivLiberate00 setTriggerArea [100, 100, 0, false];
		trgCivLiberate00 setTriggerActivation ["WEST SEIZED", "PRESENT", false];
		trgCivLiberate00 setTriggerTimeout [5, 10, 20, true];
		trgCivLiberate00 setTriggerStatements ["this", "['wp_city_0'] call Fn_Create_CivilianRebelGroups;", ""];

		trgCivLiberate01 = createTrigger ["EmptyDetector", getMarkerPos "wp_city_1"];
		trgCivLiberate01 setTriggerArea [100, 100, 0, false];
		trgCivLiberate01 setTriggerActivation ["WEST SEIZED", "PRESENT", false];
		trgCivLiberate01 setTriggerTimeout [5, 10, 20, true];
		trgCivLiberate01 setTriggerStatements ["this", "['wp_city_1'] call Fn_Create_CivilianRebelGroups;", ""];

	};
	
	Fn_Create_CivilianRebelGroups = {
		params ["_marker"];
		private _center = getMarkerPos _marker;
		
		private _pos = [_center, 5, 100, 3, 0, 0, 0] call BIS_fnc_findSafePos;
		private _group = [_pos, WEST, 5] call BIS_fnc_spawnGroup;
		_group deleteGroupWhenEmpty true;
		
		{
			[_x] execVM "gear\civilian_rebel.sqf";
			[_x] remoteExecCall ["Fn_Local_Attach_Recruit_Action"];
		} forEach units _group;
		
		_group setBehaviour "SAFE";
		_group setCombatMode "YELLOW";
		
		[_group, _center, 150] call CBA_fnc_taskDefend;
		
		for "_i" from 0 to 2 do {
			_pos = [_center, 5, 100, 3, 0, 0, 0] call BIS_fnc_findSafePos;
			_group = [_pos, WEST, 3] call BIS_fnc_spawnGroup;
			_group deleteGroupWhenEmpty true;
			
			{
				[_x] execVM "gear\civilian_rebel.sqf";
				[_x] remoteExecCall ["Fn_Local_Attach_Recruit_Action"];
			} forEach units _group;
			
			_group setBehaviour "SAFE";
			_group setCombatMode "YELLOW";
			
			[_group, _center, 150, (round (150 / 15)), "MOVE", "SAFE", "YELLOW", "LIMITED", "STAG COLUMN", "", [5,15,30]] call CBA_fnc_taskPatrol;
		};

	};
	
};