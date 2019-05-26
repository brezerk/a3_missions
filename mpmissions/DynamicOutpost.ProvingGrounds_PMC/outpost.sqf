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

task_completed_01 = false; // patrol
task_completed_02 = false; // heli
task_completed_03 = false; // inform
task_completed_04 = false; // inform docs
task_completed_05 = false; // heli docs
task_completed_06 = false; // patrol docs
task_completed_07 = false; // spotter
task_completed_08 = false; // spotter docs

_eastHQ = createCenter east;
_uaHQ = createCenter independent;

[] execVM "missions\injured_evacuation.sqf";
[] execVM "missions\units_map.sqf";
[] execVM "missions\crash_site.sqf";
[] execVM "missions\missing_patrol.sqf";
[] execVM "missions\informator.sqf";
[] execVM "missions\spotter.sqf";
[] execVM "missions\convoy.sqf";
[] execVM "missions\bmp2_repair.sqf";
[] execVM "missions\retreat.sqf";
[] execVM "missions\report_officer.sqf";
[] execVM "missions\ammo_delivery.sqf";

Fn_Modify_Rating = {
	params ["_value"];
	{
		_x addRating _value;
	} forEach allPlayers;
};

_startInvade = false;
_waveCount = 0;

/*
Function starts countdown algorithm which calls specified function with rest counts number as argument
	Arguments: [counts number, delay between counts, count handler function]
	Usage: [10, 1, {DoSomethingWithThisArgumentContainingRemainCounts}] call Fn_CountDownTimerStart
*/
Fn_CountDownTimerStart = {
	_this spawn {
		_this params ["_cts", "_ctd", "_fnc"];
		
		while {_cts = _cts - 1; sleep _ctd; _cts >= 0} do {
			_cts call _fnc
		};
	};
};

/*
Create start objectives and triggers:
	* Report to Officer;
	* Deliver Ural;
	* Damage Ural;
	* Damage Heavy
*/
Fn_Create_Objectives_Start = {
	if (isServer) then {
		call Fn_Task_InjuredEvacuation_Init;
		//ua_heavy_01 addEventHandler ["handleDamage","[str(_this)] remoteExec ['systemChat'];"]; 
		call Fn_Task_Create_RepairHeavy;
		// Load Ural
		call Fn_Task_Create_AmmoDelivery_Load;
		// Warzone enter
		trgWarzoneEnter = createTrigger ["EmptyDetector", getMarkerPos "wp_defend_01"];
		trgWarzoneEnter setTriggerArea [280, 280, 0, false];
		trgWarzoneEnter setTriggerActivation ["EAST", "PRESENT", true];
		trgWarzoneEnter setTriggerStatements [
			"this",
			"",
			""
		];
		["wp_defend_01", trgWarzoneEnter] execVM "addons\brezblock\triggers\warzone_close.sqf";
		// Gate trigger (only if keeper is alive)
		trgOpenGate = createTrigger ["EmptyDetector", getPos ua_gate01];
		trgOpenGate setTriggerArea [15, 15, 0, false];
		trgOpenGate setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		trgOpenGate setTriggerStatements [
			"this && alive ua_gate_keeper_01 && ua_gate_keeper_01 distance ua_gate01 < 10",
			"ua_gate01 animate ['Door_1_rot', 1];",
			"ua_gate01 animate ['Door_1_rot', 0];"
		];
		// Spawn transport
		[Fn_Spawn_UAZ, 'wp_spawn_uaz_01', 20, 360] execVM 'addons\brezblock\triggers\respawn_transport.sqf';
	};
};

/*
Get tasks state
*/
Fn_Get_Task_State = {
	/* DEBUG ONLY
	 * task_completed_01 = false; // patrol
	 * task_completed_02 = false; // heli
	 * task_completed_03 = false; // inform
	 * task_completed_04 = false; // inform docs
	 * task_completed_05 = false; // heli docs
	 * task_completed_06 = false; // patrol docs
	 * task_completed_07 = false; // spotter
	 * task_completed_08 = false; // spotter docs
	 */
	if (isServer) then {
		//[format ["TASK STATE: %1 %2 %3 %4 %5 %6 %7 %8", task_completed_01, task_completed_02, task_completed_03, task_completed_04, task_completed_05, task_completed_06, task_completed_07, task_completed_08]] remoteExec ["systemChat"];
	};
};

Fn_Endgame_Loss = {
	if (isServer) then {
		['t_defend_blockpost', 'FAILED'] call BIS_fnc_taskSetState;
		"EveryoneLost" call BIS_fnc_endMissionServer;
	};
};

Fn_Endgame_Win = {
	if (isServer) then {
		"EveryoneWon" call BIS_fnc_endMissionServer;
	};
};

Fn_Endgame_PreWin = {
	if (isServer) then {
		[[ localize "INFO_LOC_01", localize "INFO_SUBLOC_01", format [localize "INFO_DATE_01", daytime call BIS_fnc_timeToString], mapGridPosition player ], BIS_fnc_infoText] remoteExec ["spawn", -2];
		['LeadTrack06_F_Tank'] remoteExec ['playMusic'];
	};
};

Fn_Spawn_UAZ = {
	params ["_spawnposition"];
	private ["_pos", "_vec"];
	_vec = objNull;
	if (isServer) then {
		_vec = selectRandom [
			"LOP_UKR_UAZ",
			"LOP_UKR_UAZ_Open",
			"LOP_UKR_UAZ_AGS",
			"LOP_UKR_UAZ_DshKM",
			"LOP_UA_UAZ_SPG"
		];
		_pos = getMarkerPos _spawnposition findEmptyPosition [0, 15, _vec];
		_vec = createVehicle [_vec, _pos, [], 0];
		_vec setDir (markerDir _spawnposition);
		
	};
	_vec;
};

//run on dedicated server only
if (isServer) then {
	/*
	Run this scenario only on server
	*/
	
	//set flag textures
	{ _x  setFlagTexture "addons\apl\data\flag_ukraine.paa"; } forEach [ua_flag_01, ua_flag_02, ua_flag_03, ua_flag_04];
	
	//reveal mines to the UA forces
	(allMines select 0) mineDetectedBy independent;
	
	//spawn random uaz
	["wp_spawn_uaz_01"] call Fn_Spawn_UAZ;
	
	//wait a bit
	sleep 5;
	call Fn_Create_Objectives_Start;

	//Move all units into the one Groop (Required for ACE);
	_grp = createGroup independent;
	{
		[_x] joinSilent _grp;
	} forEach playableUnits;
	
	sleep 5;
	
	// We need to end game if all players are no longer alive
	[] execVM "addons\brezblock\triggers\end_game.sqf";
};
