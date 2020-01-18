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
		//call Fn_Task_Create_ReportOfficer;
		// Warzone enter
		trgWarzoneEnter = createTrigger ["EmptyDetector", getMarkerPos "wp_defend_01"];
		trgWarzoneEnter setTriggerArea [280, 280, 0, false];
		trgWarzoneEnter setTriggerActivation ["EAST", "PRESENT", true];
		trgWarzoneEnter setTriggerStatements [
			"this",
			"",
			""
		];
		["wp_defend_01", trgWarzoneEnter] execVM "addons\BrezBlock.framework\triggers\warzone_close.sqf";
		// Gate trigger (only if keeper is alive)
		trgOpenGate01 = createTrigger ["EmptyDetector", getPos ua_gate01];
		trgOpenGate01 setTriggerArea [15, 15, 0, false];
		trgOpenGate01 setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		trgOpenGate01 setTriggerStatements [
			"this && alive ua_gate_keeper_01 && ua_gate_keeper_01 distance ua_gate01 < 10",
			"ua_gate01 animate ['Door_1_rot', 1];",
			"ua_gate01 animate ['Door_1_rot', 0];"
		];
		trgOpenGate02 = createTrigger ["EmptyDetector", getPos ua_gate02];
		trgOpenGate02 setTriggerArea [15, 15, 0, false];
		trgOpenGate02 setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		trgOpenGate02 setTriggerStatements [
			"this && alive ua_gate_keeper_02 && ua_gate_keeper_02 distance ua_gate02 < 10",
			"ua_gate02 animate ['Door_1_rot', 1];",
			"ua_gate02 animate ['Door_1_rot', 0];"
		];
		trgOpenGate03 = createTrigger ["EmptyDetector", getPos ua_gate03];
		trgOpenGate03 setTriggerArea [15, 15, 0, false];
		trgOpenGate03 setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		trgOpenGate03 setTriggerStatements [
			"this && alive ua_gate_keeper_03 && ua_gate_keeper_03 distance ua_gate03 < 10",
			"ua_gate03 animate ['Door_1_rot', 1];",
			"ua_gate03 animate ['Door_1_rot', 0];"
		];
		trgOpenGate04 = createTrigger ["EmptyDetector", getPos ua_gate04];
		trgOpenGate04 setTriggerArea [15, 15, 0, false];
		trgOpenGate04 setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		trgOpenGate04 setTriggerStatements [
			"this && alive ua_gate_keeper_04 && ua_gate_keeper_04 distance ua_gate04 < 10",
			"ua_gate04 animate ['Door_1_rot', 1];",
			"ua_gate04 animate ['Door_1_rot', 0];"
		];
		// populate radio
		if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
			ua_supply_box_04 addItemCargoGlobal ["ACRE_SEM52SL", 20];
			ua_supply_box_04 addItemCargoGlobal ["ACRE_PRC148", 4];
		} else {
			if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
				ua_supply_box_04 addItemCargoGlobal ["tf_anprc152", 20];
				ua_supply_box_04 addItemCargoGlobal ["tf_anprc148jem", 4];
			} else {
				ua_supply_box_04 addItemCargoGlobal ["ItemRadio", 20];
			};
		};
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
		['t_defend_blockpost', 'Failed', localize 'TASK_10_TITLE'] remoteExecCall ['Fn_Local_SetPersonalTaskState', [0,-2] select isDedicated];
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
	params ["_spawnposition", "_spawndir"];
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
		_pos = _spawnposition findEmptyPosition [0, 15, _vec];
		_vec = createVehicle [_vec, _pos, [], 0];
		_vec setDir _spawndir;
		
	};
	_vec;
};

//run on dedicated server only
if (isServer) then {
	/*
	Run this scenario only on server
	*/
	
	//set flag textures
	{ _x  setFlagTexture "addons\apl\data\uaflag.paa"; } forEach [ua_flag_01, ua_flag_02, ua_flag_03, ua_flag_04, ua_flag_05];
	
	upa_flag_01 setFlagTexture "addons\apl\data\upaflag.paa";
	
	//reveal mines to the UA forces
	(allMines select 0) mineDetectedBy independent;
	
	//spawn random uaz
	[getMarkerPos("wp_spawn_uaz_01"), markerDir("wp_spawn_uaz_01")] call Fn_Spawn_UAZ;
	
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
	[] execVM "addons\BrezBlock.framework\triggers\end_game.sqf";
	[] execVM "addons\BrezBlock.framework\utils\garbage_collector.sqf";
};

