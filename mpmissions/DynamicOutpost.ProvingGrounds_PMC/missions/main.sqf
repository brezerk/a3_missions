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
Spawn start objectives, triggers and mainline story
*/

if (isServer) then {
	if (!main_story_started) then {
		main_story_started = true;
		[] remoteExecCall ["Fn_Local_Task_DocSearch", [0,-2] select isDedicated];
		
		// +3 mins: spawn 3 spec ops waves
		//_until = diag_tickTime + 10 * 60;
		//waitUntil {sleep 1; diag_tickTime > _until;};
		
		// spawn spec ops
		["wp_spec_01", ["rus_spec", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		["wp_spec_04", ["rus_spec", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		
		// +5 mins: spawn 5 spec ops waves
		_until = diag_tickTime + 5 * 60;
		waitUntil {sleep 1; diag_tickTime > _until;};
		
		[["wp_spec", 8] call BrezBlock_fnc_Get_RND_Index, ["rus_spec", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		[["wp_spec", 8] call BrezBlock_fnc_Get_RND_Index, ["rus_spec", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;

		// Wave 1 (+5 min start light invasion)
		
		_until = diag_tickTime + 5 * 60;
		waitUntil {sleep 1; diag_tickTime > _until;};
		
		[] remoteExecCall ["Fn_Local_Task_DefendBlockpost", [0,-2] select isDedicated];
		
		trgLooseGame = createTrigger ["EmptyDetector", getmarkerpos "wp_defend_01"];
		trgLooseGame setTriggerArea [50, 50, 0, false];
		trgLooseGame setTriggerActivation ["EAST SEIZED", "PRESENT", false];
		trgLooseGame setTriggerTimeout [60, 90, 120, true];
		trgLooseGame setTriggerStatements ["this", "call Fn_Endgame_Loss;", ""];

		_until = diag_tickTime + 5 * 60;
		waitUntil {sleep 1; diag_tickTime > _until;};

		//call Fn_Get_Task_State;
		
		["wp_main", ["rus_p_light", 6] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		["wp_main", ["rus_p_light", 6] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		["wp_main", ["rus_mech_light", 7] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;

		["wp_nov_main", ["nov_mech_light", 2] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		[["wp_nov", 5] call BrezBlock_fnc_Get_RND_Index, ["nov_p_light", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		[["wp_nov", 5] call BrezBlock_fnc_Get_RND_Index, ["nov_p_light", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;

		//Wave 2 (5 Minutes) artilery
		_until = diag_tickTime + 10 * 60;
		waitUntil {sleep 1; diag_tickTime > _until;};
		
		["wp_mort_spot", 10, 6] execVM "addons\brezblock\systems\incoming.sqf";
		
		_until = diag_tickTime + 10;
		waitUntil {sleep 1; diag_tickTime > _until;};
		
		//Wave 3 (Artilery)
		call Fn_Task_Create_Spotter;
		
		_cts = 5;
		while {_cts = _cts - 1; sleep 30; _cts >= 0} do {
			if (alive p_rus_spotter_01) then { ["wp_mort_spot", 10, 12] execVM "addons\brezblock\systems\incoming.sqf"; };
		};
		
		//Wave 2 (5 Minutes) med
		_until = diag_tickTime + 5 * 60;
		waitUntil {sleep 1; diag_tickTime > _until;};
		
		["outpost_wave02"] remoteExec ["playSound"];
		["rhs_usa_land_rc_21"] remoteExec ["playSound"];
		
		//Wave 2 (5 Minutes) med
		_until = diag_tickTime + 5 * 60;
		waitUntil {sleep 1; diag_tickTime > _until;};
		
		// rus med at full scale
		[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_p_med", 3] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_p_med", 3] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;

		if (!task_completed_01) then {
			[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_mech_light", 7] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
			[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_mech_med", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
			[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_p_med", 3] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
			[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_p_light", 6] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		} else {
			[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_mech_med", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
			[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_p_med", 3] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
			[["wp", 10] call BrezBlock_fnc_Get_RND_Index, ["rus_p_light", 6] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		};

		// if inform docs found, skip heavy
		if (!task_completed_04) then {
			["wp_nov_main", ["nov_mech_med", 2] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
			[["wp_nov", 5] call BrezBlock_fnc_Get_RND_Index, ["nov_p_med", 3] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
			[["wp_nov", 5] call BrezBlock_fnc_Get_RND_Index, ["nov_p_light", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		} else {
			["wp_nov_main", ["nov_mech_light", 2] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
			[["wp_nov", 5] call BrezBlock_fnc_Get_RND_Index, ["nov_p_light", 4] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		};
			
		["wp_nov_main", ["nov_mech_heavy", 2] call BrezBlock_fnc_Get_RND_Index, "wp_defend_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		
		//Wait some time and create evac task
		_until = diag_tickTime + 15 * 60;
		waitUntil {sleep 1; diag_tickTime > _until;};
		
		//We need to clear the area before start evac tasts
		private _trg = createTrigger ["EmptyDetector", getmarkerpos "wp_defend_01"];
		_trg setTriggerArea [300, 300, 0, false];
		_trg setTriggerActivation ["GUER SEIZED", "PRESENT", false];
		_trg setTriggerTimeout [10, 20, 30, true];
		_trg setTriggerStatements ["this", "execVM 'missions\end.sqf';", ""];

		
	};
};

true;