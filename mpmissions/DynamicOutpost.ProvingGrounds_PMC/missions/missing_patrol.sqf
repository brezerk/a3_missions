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
Missing patrol side-mission code
*/

// Client side code
if (hasInterface) then {
	private ["_trg"];
	_trg = createTrigger ["EmptyDetector", getMarkerPos "wp_patrol_task"];
	_trg setTriggerArea [100, 100, 0, false];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setTriggerStatements [
		"(vehicle player) in thisList",
		"[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_04', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;",
		""
	];
	
	// Intended to be executed on player side (but nit dedicated tho);
	Fn_Task_MissingPatrol_Info = {
		params['_marker'];
		private ["_trg"];
		_trg = createTrigger ["EmptyDetector", getMarkerPos _marker];
		_trg setTriggerArea [50, 50, 0, false];
		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		_trg setTriggerStatements [
			"(vehicle player) in thisList",
			"[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_06', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;",
			""
		];
	};
};



//Server code

if (isServer) then {
	injured_01 = objNull;
	/*
	Spawn random patrol
		Arguments: None
		Usage: call Fn_Task_Create_MissingPatrol
	*/
	Fn_Task_Create_MissingPatrol = {
		private ["_marker"];
		_marker = ["wp_patrol", 8] call BrezBlock_fnc_Get_RND_Index;
		[_marker, ["ua_t_patrol", 5] call BrezBlock_fnc_Get_RND_Index] call BrezBlock_fnc_Spawn_Objective;
		[
			p_officer_03,
			{ _this remoteExec ["Fn_Task_MissingPatrol_DocsFound", 2] }
		] call BrezBlock_fnc_Attach_Hold_Action;
		[ua_injured_01, 0.3, "body", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[ua_injured_01, 0.8, "head", "stub"] call ace_medical_fnc_addDamageToUnit;
		ua_injured_01 setVariable ["ACE_isUnconscious", true, true];
		ua_injured_01 setUnconscious true;
		[ua_uaz_02, ["hitEngine", 0.95, true]] remoteExec ["setHitPointDamage"];
		trgInjuredKeepUnconscious_01 = createTrigger ["EmptyDetector", getPos ua_heavy_01];
		trgInjuredKeepUnconscious_01 setTriggerArea [0, 0, 0, false];
		trgInjuredKeepUnconscious_01 setTriggerActivation ["NONE", "PRESENT", true];
		trgInjuredKeepUnconscious_01 setTriggerStatements [
			"!(ua_injured_01 getVariable 'ACE_isUnconscious')",
			"ua_injured_01 setVariable ['ACE_isUnconscious', true, true];",
			""
		];
		[
			independent,
			"t_patrol_found",
			[localize "TASK_06_DESC",
			localize "TASK_06_TITLE",
			localize "TASK_ORIG_02"],
			getMarkerPos "wp_patrol_task",
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_patrol_found', "unknown"] call BIS_fnc_taskSetType;
		trgPatrolFound = createTrigger ["EmptyDetector", getMarkerPos _marker];
		trgPatrolFound setTriggerArea [10, 10, 0, false];
		trgPatrolFound setTriggerActivation ["ANYPLAYER", "PRESENT", false];
		trgPatrolFound setTriggerStatements [
			"this",
			"if (isServer) then { call Fn_Task_Create_MissingPatrol_DeliverInjured; deleteVehicle trgPatrolFound; };",
			""
		];
		[_marker, ["rus_spec", 5] call BrezBlock_fnc_Get_RND_Index] execVM 'addons\brezblock\utils\spawn_opfor_forces_guard.sqf';
		[_marker] remoteExec ["Fn_Task_MissingPatrol_Info"];
	}; // Fn_Task_Create_MissingPatrol


	/*
	Deliver injured to hospital (if any);
		Arguments: None
		Usage: call Fn_Task_Create_MissingPatrol_DeliverInjured
	*/
	Fn_Task_Create_MissingPatrol_DeliverInjured = {
		['t_patrol_found', 'SUCCEEDED'] call BIS_fnc_taskSetState;
		[1000] call Fn_Modify_Rating;
		if (!alive ua_injured_01) then {
			[
				independent,
				["t_patrol_injured", "t_patrol_found"],
				[localize "TASK_14_DESC",
				localize "TASK_14_TITLE",
				localize "TASK_ORIG_02"],
				getMarkerPos "ua_hospital_01",
				"FAILED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_patrol_injured', "heal"] call BIS_fnc_taskSetType;
		} else {
			[
				independent,
				["t_patrol_injured", "t_patrol_found"],
				[localize "TASK_14_DESC",
				localize "TASK_14_TITLE",
				localize "TASK_ORIG_02"],
				getMarkerPos "ua_hospital_01",
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_patrol_injured', "heal"] call BIS_fnc_taskSetType;
			trgPatrolInjuredDelivered = createTrigger ["EmptyDetector", getMarkerPos "ua_hospital_01" ];
			trgPatrolInjuredDelivered setTriggerArea [5, 5, 0, false];
			trgPatrolInjuredDelivered setTriggerActivation ["VEHICLE", "PRESENT", false];
			trgPatrolInjuredDelivered triggerAttachVehicle [ua_injured_01];
			trgPatrolInjuredDelivered setTriggerStatements [
				"this",
				"['t_patrol_injured', 'SUCCEEDED'] call BIS_fnc_taskSetState; task_completed_01 = true; deleteVehicle trgPatrolInjuredDied; [1000] call Fn_Modify_Rating;",
				""
			];
			trgPatrolInjuredDied = createTrigger ["EmptyDetector", getMarkerPos "ua_hospital_01" ];
			trgPatrolInjuredDied setTriggerArea [0, 0, 0, false];
			trgPatrolInjuredDied setTriggerActivation ["NONE", "PRESENT", false];
			trgPatrolInjuredDied setTriggerStatements [
				"!alive ua_injured_01",
				"['t_patrol_injured', 'FAILED'] call BIS_fnc_taskSetState; deleteVehicle trgPatrolInjuredDied;",
				""
			];
		};
	}; // Fn_Task_Create_MissingPatrol_DeliverInjured
	
	/*
	If Patrol docs were found;
	*/
	Fn_Task_MissingPatrol_DocsFound = {
		task_completed_06 = true;
		[
			independent,
			["t_doc_03", "t_doc_search"],
			[localize "TASK_12_DESC",
			localize "TASK_12_TITLE",
			localize "TASK_ORIG_01"],
			objNull,
			"SUCCEEDED",
			0,
			true
		] call BIS_fnc_taskCreate;
		["outpost_docs_found"] remoteExec ["playSound"];
		["rhs_usa_land_rc_28"] remoteExec ["playSound"];
		[2000] call Fn_Modify_Rating;
		if (task_completed_07 && task_completed_06 && task_completed_05 && task_completed_04) then {
			["t_doc_search", "SUCCEEDED", true] spawn BIS_fnc_taskSetState;
		};
	}; // Fn_Task_MissingPatrol_DocsFound
	
};
