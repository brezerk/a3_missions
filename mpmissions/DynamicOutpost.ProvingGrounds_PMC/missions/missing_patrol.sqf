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
	Fn_Local_Task_Create_MissingPatrol = {
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
		[
			player,
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
	};
	
	Fn_Local_Task_Create_MissingPatrol_DeliverInjured = {
		[
			player,
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
	};
	
	Fn_Local_Task_MissingPatrol_DocsFound = {
		[
			player,
			["t_doc_03", "t_doc_search"],
			[localize "TASK_12_DESC",
			localize "TASK_12_TITLE",
			localize "TASK_ORIG_01"],
			objNull,
			"SUCCEEDED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_doc_03', "documents"] call BIS_fnc_taskSetType;
		playSound "outpost_docs_found";
		playSound "rhs_usa_land_rc_28";
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
		{
			private _type = typeName _x;
			if (_type == "GROUP") then {
				{
					_x setVariable ["BB_CorpseTTL", -1];
					removeFromRemainsCollector [_x];
				} count units _x;
			};
		} forEach ([_marker, ["ua_t_patrol", 5] call BrezBlock_fnc_Get_RND_Index] call BrezBlock_fnc_Spawn_Objective);		
		[
			p_officer_03,
			"_this remoteExec ['Fn_Task_MissingPatrol_DocsFound', 2]",
			"holdactions\holdAction_search",
			"ACTION_01",
			"&& !task_completed_06",
			6,
			true
		] call BrezBlock_fnc_Attach_SearchIntel_Action;
		//[ua_injured_01, 0.3, "body", "bullet"] call ace_medical_fnc_addDamageToUnit;
		[ua_injured_01, 0.3, "head", "stub"] call ace_medical_fnc_addDamageToUnit;
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
		
		trgPatrolFound = createTrigger ["EmptyDetector", getMarkerPos _marker];
		trgPatrolFound setTriggerArea [10, 10, 0, false];
		trgPatrolFound setTriggerActivation ["ANYPLAYER", "PRESENT", false];
		trgPatrolFound setTriggerStatements [
			"this",
			"if (isServer) then { call Fn_Task_Create_MissingPatrol_DeliverInjured; deleteVehicle trgPatrolFound; };",
			""
		];
		{
			if (_x inArea trgPatrolFound) then {
				_x setVariable ["BB_CorpseTTL", -1];
				removeFromRemainsCollector [_x];
			};
		} count allDeadMen;
		[_marker, ["rus_spec", 5] call BrezBlock_fnc_Get_RND_Index] execVM 'addons\BrezBlock.framework\utils\spawn_opfor_forces_guard.sqf';
		[_marker] remoteExecCall ["Fn_Local_Task_Create_MissingPatrol", [0,-2] select isDedicated];
		
		private _trg = createTrigger ["EmptyDetector", getMarkerPos _marker];
		_trg setTriggerArea [250, 250, 0, false];
		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
		_trg setTriggerStatements [
			"this",
			"execVM 'missions\main.sqf';",
			""
		];
	}; // Fn_Task_Create_MissingPatrol


	/*
	Deliver injured to hospital (if any);
		Arguments: None
		Usage: call Fn_Task_Create_MissingPatrol_DeliverInjured
	*/
	Fn_Task_Create_MissingPatrol_DeliverInjured = {
		['t_patrol_found', 'Succeeded', localize 'TASK_06_TITLE'] remoteExecCall ['Fn_Local_SetPersonalTaskState', [0,-2] select isDedicated];
		[] remoteExecCall ["Fn_Local_Task_Create_MissingPatrol_DeliverInjured", [0,-2] select isDedicated];
		if (!alive ua_injured_01) then {
			['t_patrol_injured', 'Failed', localize 'TASK_14_TITLE'] remoteExecCall ['Fn_Local_SetPersonalTaskState', [0,-2] select isDedicated];
		} else {
			trgPatrolInjuredDelivered = createTrigger ["EmptyDetector", getMarkerPos "ua_hospital_01" ];
			trgPatrolInjuredDelivered setTriggerArea [5, 5, 0, false];
			trgPatrolInjuredDelivered setTriggerActivation ["VEHICLE", "PRESENT", false];
			trgPatrolInjuredDelivered triggerAttachVehicle [ua_injured_01];
			trgPatrolInjuredDelivered setTriggerStatements [
				"this",
				"['t_patrol_injured', 'Succeeded', localize 'TASK_14_TITLE'] remoteExecCall ['Fn_Local_SetPersonalTaskState', [0,-2] select isDedicated]; task_completed_01 = true; deleteVehicle trgPatrolInjuredDied;",
				""
			];
			trgPatrolInjuredDied = createTrigger ["EmptyDetector", getMarkerPos "ua_hospital_01" ];
			trgPatrolInjuredDied setTriggerArea [0, 0, 0, false];
			trgPatrolInjuredDied setTriggerActivation ["NONE", "PRESENT", false];
			trgPatrolInjuredDied setTriggerStatements [
				"!alive ua_injured_01",
				"['t_patrol_injured', 'Failed', localize 'TASK_14_TITLE'] remoteExecCall ['Fn_Local_SetPersonalTaskState', [0,-2] select isDedicated]; deleteVehicle trgPatrolInjuredDied;",
				""
			];
		};
	}; // Fn_Task_Create_MissingPatrol_DeliverInjured
	
	/*
	If Patrol docs were found;
	*/
	Fn_Task_MissingPatrol_DocsFound = {
		if (!task_completed_06) then {
			task_completed_06 = true;
			publicVariable "task_completed_06";
			[] remoteExecCall ["Fn_Local_Task_MissingPatrol_DocsFound", [0,-2] select isDedicated];
			if (task_completed_07 && task_completed_06 && task_completed_05 && task_completed_04) then {
				['t_doc_search', 'Succeeded', localize 'TASK_09_TITLE'] remoteExecCall ['Fn_Local_SetPersonalTaskState', [0,-2] select isDedicated];
			};
		};
	}; // Fn_Task_MissingPatrol_DocsFound
	
};
