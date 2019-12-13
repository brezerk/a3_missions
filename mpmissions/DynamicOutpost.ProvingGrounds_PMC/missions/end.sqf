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
End games missions
*/

if (isServer) then {
	call Fn_Task_Create_InjuredEvacuation;
		
	//Wait some time and create convoy task
	_until = diag_tickTime + 5 * 60;
	waitUntil {sleep 1; diag_tickTime > _until;};
		
	call Fn_Task_Create_Convoy;
		
	//Wave 4 (10 Minutes) heavy invasion final
	_until = diag_tickTime + 12 * 60;
	waitUntil {sleep 1; diag_tickTime > _until;};
		
	//Artilery HEAVY
	//if spotter docs found, do light bombard
	if (!task_completed_08) then {
		_cts = 5;
		while {_cts = _cts - 1; sleep 30; _cts >= 0} do {
			// if spotter alive -- do full scale bombard
			if (alive p_rus_spotter_01) then { 
				["wp_mort_spot", 15, 16] execVM "addons\brezblock\systems\incoming.sqf"; 
			} else {
				["wp_mort_spot", 10, 8] execVM "addons\brezblock\systems\incoming.sqf";
			};
		};
	} else {
		["wp_mort_spot", 10, 2] execVM "addons\brezblock\systems\incoming.sqf";
		["outpost_artellery_down"] remoteExec ["playSound"];
		["rhs_usa_land_rc_13"] remoteExec ["playSound"];
	};
		
	// wait some more
	_until = diag_tickTime + 2 * 60;
	waitUntil {sleep 1; diag_tickTime > _until;};
		
		
	call Fn_Task_Create_Retreat;

	// give 5 minutes to start movement
	_until = diag_tickTime + 5 * 60;
	waitUntil {sleep 1; diag_tickTime > _until;};

	// rus are doing full scale regardless
	[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_mech_med", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
	[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_mech_ligh", 7] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		
	sleep 2;
	// if not inform docs found -- dpr is dounf ful lsace attack;
	// if docs found turn into light
	if (!task_completed_04) then {
		["wp_nov_main", ["nov_mech_med", 2] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		[["wp_nov", 5] call BrezBlock_fnc_Get_RND_Index, ["nov_p_light", 2] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		[["wp_nov", 5] call BrezBlock_fnc_Get_RND_Index, ["nov_p_light", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
	} else {
		[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_mech_ligh", 7] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		[["wp_nov", 5] call BrezBlock_fnc_Get_RND_Index, ["nov_p_light", 2] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		[["wp_nov", 5] call BrezBlock_fnc_Get_RND_Index, ["nov_p_light", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
	};
		
	sleep 2;
	[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_p_med", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
	[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_p_light", 6] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
	[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_p_light", 6] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		
	// wait some more
	_until = diag_tickTime + 3 * 60;
	waitUntil {sleep 1; diag_tickTime > _until;};
		
	//reweal all mines to east forces
	(allMines select 0) mineDetectedBy east;
		
	[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_tank", 3] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		
	// wait some more
	_until = diag_tickTime + 5 * 60;
	waitUntil {sleep 1; diag_tickTime > _until;};
		
	//call heli regardless >:E
	//[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_heli", 3] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01", [[0,0,0],[0,30,0],[30,0,0]]] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		
	// wait some more
	_until = diag_tickTime + 10 * 60;
	waitUntil {sleep 1; diag_tickTime > _until;};
			
	trgPreWinGame = createTrigger ["EmptyDetector", getmarkerpos "wp_defend_01"];
	trgPreWinGame setTriggerArea [300, 300, 0, false];
	trgPreWinGame setTriggerActivation ["GUER SEIZED", "PRESENT", false];
	trgPreWinGame setTriggerTimeout [10, 20, 30, true];
	trgPreWinGame setTriggerStatements ["this", "call Fn_Endgame_PreWin;", ""];
		
	trgWinGame = createTrigger ["EmptyDetector", getmarkerpos "wp_defend_01"];
	trgWinGame setTriggerArea [300, 300, 0, false];
	trgWinGame setTriggerActivation ["GUER SEIZED", "PRESENT", false];
	trgWinGame setTriggerTimeout [60, 65, 70, true];
	trgWinGame setTriggerStatements ["this", "['t_defend_blockpost_steel_will', 'Succeeded', localize 'TASK_19_TITLE'] remoteExecCall ['Fn_Local_SetPersonalTaskState', [0,-2] select isDedicated]; call Fn_Endgame_Win;", ""];
};