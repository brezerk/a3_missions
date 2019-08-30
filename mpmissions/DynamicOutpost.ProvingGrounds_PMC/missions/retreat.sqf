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
Spawn start objectives, triggers for retreat
*/

// Client side code
if (hasInterface) then {	
	Fn_Local_Task_Create_Retreat = {
		playSound "outpost_wave03";
		playSound "rhs_usa_land_rc_21";
		['t_defend_blockpost', 'SUCCEEDED'] call BIS_fnc_taskSetState;
		[
			player,
			"t_evacuation_point",
			[localize "TASK_18_DESC",
			localize "TASK_18_TITLE",
			localize "TASK_ORIG_01"],
			getMarkerPos 'ua_secret_01',
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_evacuation_point', "run"] call BIS_fnc_taskSetType;
		[
			player,
			"t_defend_blockpost_steel_will",
			[localize "TASK_19_DESC",
			localize "TASK_19_TITLE",
			localize "TASK_ORIG_02"],
			getMarkerPos 'wp_defend_01',
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_defend_blockpost_steel_will', "defend"] call BIS_fnc_taskSetType;
	};
};

if (isServer) then {
	Fn_Task_Create_Retreat = {
		deleteVehicle trgLooseGame;
		[] remoteExecCall ["Fn_Local_Task_Create_Retreat", [0,-2] select isDedicated];
		trgEvacPoint = createTrigger ["EmptyDetector", getMarkerPos 'ua_secret_01'];
		trgEvacPoint setTriggerArea [30, 30, 0, false];
		trgEvacPoint setTriggerActivation ["NONE", "PRESENT", false];
		trgEvacPoint setTriggerStatements [
			"({alive _x} count (allPlayers -  entities 'HeadlessClient_F' ) == {alive _x && _x inArea thisTrigger} count (allPlayers - entities 'HeadlessClient_F' ))  && ({alive _x} count allPlayers) > 0",
			"['t_evacuation_point', 'SUCCEEDED'] call BIS_fnc_taskSetState; ['t_defend_blockpost_steel_will', 'FAILED'] call BIS_fnc_taskSetState; call Fn_Endgame_Win;",
			""
		];
		trgEvacPoint = createTrigger ["EmptyDetector", getMarkerPos 'ua_secret_01'];
		trgEvacPoint setTriggerArea [1150, 1150, 0, false];
		trgEvacPoint setTriggerActivation ["ANYPLAYER", "PRESENT", false];
		trgEvacPoint setTriggerStatements [
			"this",
			"call Fn_Spawn_T_Evac_Point;",
			""
		];
		// Warzone enter
		trgEvacPointEnter = createTrigger ["EmptyDetector", getMarkerPos "ua_secret_01"];
		trgEvacPointEnter setTriggerArea [30, 30, 0, false];
		trgEvacPointEnter setTriggerActivation ["EAST", "PRESENT", true];
		trgEvacPointEnter setTriggerStatements [
			"this",
			"{ _grp = group _x; _grp setBehaviour 'COMBAT'; _grp setSpeedMode 'FULL'; [_grp, getMarkerPos 'ua_secret_01', 25, 3, 0.5, 100] call CBA_fnc_taskDefend; } forEach thisList;",
			""
		];
	};

	Fn_Spawn_T_Evac_Point = {
		[["wp_evac_ambush", 6] call BrezBlock_fnc_Get_RND_Index, ["rus_spec", 4] call BrezBlock_fnc_Get_RND_Index, "ua_secret_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		[["wp_evac_ambush", 6] call BrezBlock_fnc_Get_RND_Index, ["rus_spec", 4] call BrezBlock_fnc_Get_RND_Index, "ua_secret_01"] call BrezBlock_fnc_Spawn_OPFOR_Forces;
		['wp_ambush_start_01', ["rus_spec", 4] call BrezBlock_fnc_Get_RND_Index] execVM 'addons\brezblock\utils\spawn_opfor_forces_guard.sqf';	
	};
};
