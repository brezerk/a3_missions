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

	Fn_Create_Logic_CivilianLiberateCity = {
		private _trg = createTrigger ["EmptyDetector", getMarkerPos "mrk_city_0"];
		_trg setTriggerArea [100, 100, 0, false];
		_trg setTriggerActivation ["WEST SEIZED", "PRESENT", false];
		_trg setTriggerTimeout [5, 10, 20, true];
		_trg setTriggerStatements ["this", "['mrk_city_0'] call Fn_Create_CivilianRebelGroups; deleteVehicle thisTrigger;", ""];

		_trg = createTrigger ["EmptyDetector", getMarkerPos "mrk_city_1"];
		_trg setTriggerArea [100, 100, 0, false];
		_trg setTriggerActivation ["WEST SEIZED", "PRESENT", false];
		_trg setTriggerTimeout [5, 10, 20, true];
		_trg setTriggerStatements ["this", "['mrk_city_1'] call Fn_Create_CivilianRebelGroups; deleteVehicle thisTrigger;", ""];
	};
	
	Fn_Create_CivilianRebelGroups = {
		params ["_marker"];
		private _center = getMarkerPos _marker;
		
		private _pos = [_center, 5, 100, 3, 0, 0, 0] call BIS_fnc_findSafePos;
		private _group = [_pos, WEST, 5] call BIS_fnc_spawnGroup;
		_group deleteGroupWhenEmpty true;
		
		{
			[_x] execVM "UnfinishedBusiness.core\gear\civilian_rebel.sqf";
			[_x] remoteExecCall ["Fn_Local_Attach_Recruit_Action"];
		} forEach units _group;
		
		_group setBehaviour "SAFE";
		_group setCombatMode "YELLOW";
		
		if (isClass(configFile >> "CfgPatches" >> "cba_main")) then {
			[_group, _center, 150] call CBA_fnc_taskDefend;
		} else {
			[_group, _center] call bis_fnc_taskDefend;
		};
		
		for "_i" from 0 to 2 do {
			_pos = [_center, 5, 100, 3, 0, 0, 0] call BIS_fnc_findSafePos;
			_group = [_pos, WEST, 3] call BIS_fnc_spawnGroup;
			_group deleteGroupWhenEmpty true;
			
			{
				[_x] execVM "UnfinishedBusiness.core\gear\civilian_rebel.sqf";
				[_x] remoteExecCall ["Fn_Local_Attach_Recruit_Action"];
			} forEach units _group;
			
			_group setBehaviour "SAFE";
			_group setCombatMode "YELLOW";
			
			if (isClass(configFile >> "CfgPatches" >> "cba_main")) then {
				[_group, _center, 150, (round (150 / 15)), "MOVE", "SAFE", "YELLOW", "LIMITED", "STAG COLUMN", "", [5,15,30]] call CBA_fnc_taskPatrol;
			} else {
				_null = [_group, _center, 150] call BIS_fnc_taskPatrol;
			};
			
		};

		//call enemy to clear the city group
		//fixme: potentially we would like to continue assoult if it was not successful :)
		[_center, (random 2)] call Fn_Patrols_Create_AssaultGroup;
	};
	
};