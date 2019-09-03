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
Spawn start objectives, triggers to report officer
*/

if (hasInterface) then {
	Fn_Local_Task_Create_ReportOfficer = {
		[
			player,
			"t_report_officer",
			[localize "TASK_03_DESC",
			localize "TASK_03_TITLE",
			localize "TASK_ORIG_01"],
			getPos ua_officer_01,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_report_officer', "talk"] call BIS_fnc_taskSetType;
		
		_trg = createTrigger ["EmptyDetector", getMarkerPos "wp_defend_01"];
		_trg setTriggerArea [100, 100, 0, false];
		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		_trg setTriggerStatements [
			"(vehicle player) in thisList",
			"[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_02', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;",
			""
		];
	};
	
	Fn_Local_Task_DocSearch = {
		[
			player,
			"t_doc_search",
			[localize "TASK_09_DESC",
			localize "TASK_09_TITLE",
			localize "TASK_ORIG_01"],
			objNull,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		["t_doc_search", "search"] call BIS_fnc_taskSetType;
	};
	
	Fn_Local_Task_DefendBlockpost = {
		playSound "outpost_wave01";
		playSound "rhs_usa_land_rc_25";
	
		[
			player,
			"t_defend_blockpost",
			[localize "TASK_10_DESC",
			localize "TASK_10_TITLE",
			localize "TASK_ORIG_01"],
			getMarkerPos "wp_defend_01",
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
	};
};

if (isServer) then {
	Fn_Task_Create_ReportOfficer = {
		// Report to officer
		[] remoteExecCall ["Fn_Local_Task_Create_ReportOfficer", [0,-2] select isDedicated];
		trgOfficerDead = createTrigger ["EmptyDetector", getPos ua_officer_01];
		trgOfficerDead setTriggerArea [0, 0, 0, false];
		trgOfficerDead setTriggerActivation ["NONE", "PRESENT", false];
		trgOfficerDead setTriggerStatements [
			"!alive ua_officer_01",
			"if (isServer) then { call Fn_Endgame_Loss; };",
			""
		];
		[
			ua_officer_01,
			{ _this remoteExec ["Fn_Task_ReportOfficer_Done", 2] },
			"simpleTasks\types\talk",
			"ACTION_02",
			"&& alive _target"
		] call BrezBlock_fnc_Attach_Hold_Action;
	};
	
	Fn_Task_ReportOfficer_Done = {
		deleteVehicle trgOfficerDead;
		execVM 'missions\main.sqf';
	};
	

	
};
