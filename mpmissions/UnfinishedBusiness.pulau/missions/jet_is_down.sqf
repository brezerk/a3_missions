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
	
	private ['_free_landing_markers', '_markerPos', '_wp'];
		_free_landing_markers = [
			'wp_player_spawn_01',
			'wp_player_spawn_02',
			'wp_player_spawn_03',
			'wp_player_spawn_04',
			'wp_player_spawn_05',
			'wp_player_spawn_06',
			'wp_player_spawn_07',
			'wp_player_spawn_08',
			'wp_player_spawn_09',
			'wp_player_spawn_10',
			'wp_player_spawn_11',
			'wp_player_spawn_12',
			'wp_player_spawn_13',
			'wp_player_spawn_14',
			'wp_player_spawn_15',
			'wp_player_spawn_16',
			'wp_player_spawn_17',
			'wp_player_spawn_18',
			'wp_player_spawn_19',
			'wp_player_spawn_20'
		];
		{
			[0, "BLACK", 5, 1] remoteExec ["BIS_fnc_fadeEffect", _x];
			[_x] remoteExec ["doGetOut", _x];
			[_x] remoteExec ["moveOut", _x];
		} forEach assault_group;
		
		['t_arrive_to_island', 'FAILED'] call BIS_fnc_taskSetState;
		
		[] execVM "missions\crash_site.sqf";
		sleep 5;
		
		{
			[[], "gear\player.sqf"] remoteExec ["execVM", _x];
			
			_marker = selectRandom _free_landing_markers;
			_free_landing_markers = _free_landing_markers - [_marker];
			_markerPos = getMarkerPos _marker;
				
			//do some damage
			_dmgType = ["leg_l", "leg_r", "hand_r", "hand_l", "head"];
			[_x, 1, selectRandom _dmgType, "bullet"] remoteExec ["ace_medical_fnc_addDamageToUnit"];
				
			//parachute
			_x setPos [(_markerPos select 0), (_markerPos select 1), ((_markerPos select 2) + 160 + random 100)];
			[_x, true] remoteExec ["setUnconscious", _x];
			_x setVariable ["ACE_isUnconscious", true, true];
			[1, "BLACK", 5, 1] remoteExec ["BIS_fnc_fadeEffect", _x];
		} forEach assault_group;
		
		{deleteVehicle _x} foreach crew us_airplane_01; deleteVehicle us_airplane_01;
		
		//let them fall a bit
		sleep 10;
		
		//create tasks assigned to assault_group
		{
			[_x, false] remoteExec ["setUnconscious", _x];
			_x setVariable ["ACE_isUnconscious", false, true];
			[_x, true] remoteExec ["allowDamage"];
			[
				_x,
				"t_find_informator",
				[localize "TASK_05_DESC",
				localize "TASK_05_TITLE",
				localize "TASK_ORIG_01"],
				objNull,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_find_informator', "talk"] call BIS_fnc_taskSetType;
			[
				_x,
				"t_regroup",
				[localize "TASK_03_DESC",
				localize "TASK_03_TITLE",
				localize "TASK_ORIG_01"],
				objNull,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_regroup', "meet"] call BIS_fnc_taskSetType;
			[
				_x,
				"t_crash_site",
				[localize "TASK_04_DESC",
				localize "TASK_04_TITLE",
				localize "TASK_ORIG_01"],
				objNull,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_crash_site', "unknown"] call BIS_fnc_taskSetType;
		} forEach assault_group;
		
		//remoteExec ["Fn_Task_Create_Informator"];
		
		//sleep 5;
		
		//[] execVM "missions\regroup.sqf";
		//[] execVM "missions\assoult_group_is_dead.sqf";
		/*
		trgRegroupIsDone = createTrigger ["EmptyDetector", getMarkerPos 'wp_air_field_01'];
		trgRegroupIsDone setTriggerArea [0, 0, 0, false];
		trgRegroupIsDone setTriggerActivation ["NONE", "PRESENT", false];
		trgRegroupIsDone setTriggerStatements [
				"task_complete_intormator && task_complete_regroup",
				"call Fn_Task_Create_AA; call Fn_Task_Create_KillLeader;",
				""
		];*/
};