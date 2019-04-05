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
Spawn start objectives, triggers for injured evacuation
*/

if (isServer) then {
	//Mission Preinit
	evac_heli_01 = objNull;
	evac_heli_01_driver = objNull;
	evac_heli_01_crew = objNull;

	Fn_Task_InjuredEvacuation_Init = {
		//FIMXE: Dynamic array instead?
		ua_injured_02 setVariable ["ACE_isUnconscious", true, true];
		ua_injured_02 setUnconscious true;
		ua_injured_03 setVariable ["ACE_isUnconscious", true, true];
		ua_injured_03 setUnconscious true;
		ua_injured_04 setVariable ["ACE_isUnconscious", true, true];
		ua_injured_04 setUnconscious true;
			
		trgInjuredKeepUnconscious_02 = createTrigger ["EmptyDetector", getPos ua_heavy_01];
		trgInjuredKeepUnconscious_02 setTriggerArea [0, 0, 0, false];
		trgInjuredKeepUnconscious_02 setTriggerActivation ["NONE", "PRESENT", true];
		trgInjuredKeepUnconscious_02 setTriggerStatements [
			"!(ua_injured_02 getVariable 'ACE_isUnconscious')",
			"ua_injured_02 setVariable ['ACE_isUnconscious', true, true];",
			""
		];
		trgInjuredKeepUnconscious_03 = createTrigger ["EmptyDetector", getPos ua_heavy_01];
		trgInjuredKeepUnconscious_03 setTriggerArea [0, 0, 0, false];
		trgInjuredKeepUnconscious_03 setTriggerActivation ["NONE", "PRESENT", true];
		trgInjuredKeepUnconscious_03 setTriggerStatements [
			"!(ua_injured_03 getVariable 'ACE_isUnconscious')",
			"ua_injured_03 setVariable ['ACE_isUnconscious', true, true];",
			""
		];
		trgInjuredKeepUnconscious_04 = createTrigger ["EmptyDetector", getPos ua_heavy_01];
		trgInjuredKeepUnconscious_04 setTriggerArea [0, 0, 0, false];
		trgInjuredKeepUnconscious_04 setTriggerActivation ["NONE", "PRESENT", true];
		trgInjuredKeepUnconscious_04 setTriggerStatements [
			"!(ua_injured_04 getVariable 'ACE_isUnconscious')",
			"ua_injured_04 setVariable ['ACE_isUnconscious', true, true];",
			""
		];
	};

	Fn_Task_Create_InjuredEvacuation = {
		[
				independent,
				"t_outpost_injured",
				[localize "TASK_15_DESC",
				localize "TASK_15_TITLE",
				localize "TASK_ORIG_01"],
				getMarkerPos "ua_secret_01",
				"CREATED",
				0,
				true
		] call BIS_fnc_taskCreate;
		['t_outpost_injured', "heal"] call BIS_fnc_taskSetType;
		trgCallMedEvacHeli = createTrigger ["EmptyDetector", getMarkerPos "ua_secret_01"];
		trgCallMedEvacHeli setTriggerArea [50, 50, 0, false];
		trgCallMedEvacHeli setTriggerActivation ["ANYPLAYER", "PRESENT", false];
		trgCallMedEvacHeli setTriggerStatements [
			"this",
			"if (isServer) then { call Fn_Task_InjuredEvacuation_CallMedEvac; };",
			""
		];
		trgOutpostInjuredDied = createTrigger ["EmptyDetector", getMarkerPos "wp_test_02" ];
		trgOutpostInjuredDied setTriggerArea [0, 0, 0, false];
		trgOutpostInjuredDied setTriggerActivation ["NONE", "PRESENT", false];
		if (!(isNil "ua_injured_01")) then {
			trgOutpostInjuredDied setTriggerStatements [
				"!alive ua_injured_01 && !alive ua_injured_02 && !alive ua_injured_03 && !alive ua_injured_04",
				"deleteVehicle trgCallMedEvacHeli; deleteVehicle trgOutpostInjuredDied; deleteVehicle trgOutpostInjuredDelivered; deleteVehicle trgCallMedEvacHeliCleanup; deleteVehicle trgInjuredKeepUnconscious_01; deleteVehicle trgInjuredKeepUnconscious_02; deleteVehicle trgInjuredKeepUnconscious_03; deleteVehicle trgInjuredKeepUnconscious_04; ['t_outpost_injured', 'FAILED'] call BIS_fnc_taskSetState;",
				""
			];
		} else {
			trgOutpostInjuredDied setTriggerStatements [
				"!alive ua_injured_02 && !alive ua_injured_03 && !alive ua_injured_04",
				"deleteVehicle trgCallMedEvacHeli; deleteVehicle trgOutpostInjuredDied; deleteVehicle trgOutpostInjuredDelivered; deleteVehicle trgCallMedEvacHeliCleanup; deleteVehicle trgInjuredKeepUnconscious_01; deleteVehicle trgInjuredKeepUnconscious_02; deleteVehicle trgInjuredKeepUnconscious_03; deleteVehicle trgInjuredKeepUnconscious_04; ['t_outpost_injured', 'FAILED'] call BIS_fnc_taskSetState;",
				""
			];
		};
		[["wp_ambush_start", 5] call BrezBlock_fnc_Get_RND_Index, ["rus_spec", 4] call BrezBlock_fnc_Get_RND_Index] execVM 'addons\brezblock\utils\spawn_opfor_forces_guard.sqf';
		[["wp_ambush_start", 5] call BrezBlock_fnc_Get_RND_Index, ["rus_spec", 4] call BrezBlock_fnc_Get_RND_Index] execVM 'addons\brezblock\utils\spawn_opfor_forces_guard.sqf';
	}; // Fn_Task_Create_InjuredEvacuation

	Fn_Task_InjuredEvacuation_CallMedEvac = {
		private ["_spawnposition", "_units", "_vehicle", "_wp"];
		_spawnposition = "wp_test_04";
		evac_heli_01_crew = [getMarkerPos _spawnposition, independent, ["LOP_UKR_MI8MT_Cargo"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		_units = units evac_heli_01_crew;
		{
			_vehicle = assignedVehicle _x;
			if (!isNull _vehicle) exitWith {
				evac_heli_01 = _vehicle;
				evac_heli_01_driver = driver _vehicle;
				_vehicle setVehicleLock "LOCKEDPLAYER";
			};
		
		} forEach _units;
		
		trgHeliDead = createTrigger ["EmptyDetector", getMarkerPos "wp_test_02" ];
		trgHeliDead setTriggerArea [0, 0, 0, false];
		trgHeliDead setTriggerActivation ["NONE", "PRESENT", false];
		trgHeliDead setTriggerStatements [
			"!canMove evac_heli_01 || !alive evac_heli_01 || !alive evac_heli_01_driver",
			"deleteVehicle trgCallMedEvacHeli; deleteVehicle trgOutpostInjuredDied; deleteVehicle trgOutpostInjuredDelivered; deleteVehicle trgCallMedEvacHeliCleanup; deleteVehicle trgInjuredKeepUnconscious_01; deleteVehicle trgInjuredKeepUnconscious_02; deleteVehicle trgInjuredKeepUnconscious_03; deleteVehicle trgInjuredKeepUnconscious_04; ['t_outpost_injured', 'FAILED'] call BIS_fnc_taskSetState;",
			""
		];
		
		[getMarkerPos "wp_test_03", independent, ["Land_HelipadEmpty_F"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;
		_wp = evac_heli_01_crew addWaypoint [getMarkerPos "wp_test_03", 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "CARELESS";
		_wp setWaypointCombatMode "GREEN";
		_wp setWaypointSpeed "FULL";
		_wp setWaypointFormation "COLUMN";
		_wp setWaypointStatements ["true", "(vehicle this) land 'LAND'"];	
		
		trgOutpostInjuredDelivered = createTrigger ["EmptyDetector", getMarkerPos "wp_test_03" ];
		trgOutpostInjuredDelivered setTriggerArea [0, 0, 0, false];
		trgOutpostInjuredDelivered setTriggerActivation ["NONE", "PRESENT", false];
		trgOutpostInjuredDelivered setTriggerStatements [
			"call Fn_Task_InjuredEvacuation_Evaluate;",
			"call Fn_Task_InjuredEvacuation_RecallMedEvac;",
			""
		];
	}; // Fn_Task_InjuredEvacuation_CallMedEvac

	Fn_Task_InjuredEvacuation_Evaluate = {
		private ["_all_on_board"];
		_all_on_board = true;
		if (!(isNil "ua_injured_01") && triggerActivated trgPatrolInjuredDelivered) then {
			if (alive ua_injured_01) then {
				if (objectParent ua_injured_01 != evac_heli_01) then {
					_all_on_board = false;
				};
			};
		};
		if (alive ua_injured_02) then {
			if (objectParent ua_injured_02 != evac_heli_01) then {
				_all_on_board = false;
			};
		};
		if (alive ua_injured_03) then {
			if (objectParent ua_injured_03 != evac_heli_01) then {
				_all_on_board = false;
			};
		};
		if (alive ua_injured_04) then {
			if (objectParent ua_injured_04 != evac_heli_01) then {
				_all_on_board = false;
			};
		};
		_all_on_board;
	}; // Fn_Task_InjuredEvacuation_Evaluate

	Fn_Task_InjuredEvacuation_RecallMedEvac = {
		['t_outpost_injured', 'SUCCEEDED'] call BIS_fnc_taskSetState;
		[1000] call Fn_Modify_Rating;
		evac_heli_01_crew addWaypoint [getMarkerPos 'wp_test_04', 0];
		deleteVehicle trgOutpostInjuredDied;
		deleteVehicle trgHeliDead;
		deleteVehicle trgCallMedEvacHeli;
		deleteVehicle trgOutpostInjuredDelivered; 
		deleteVehicle trgInjuredKeepUnconscious_01;
		deleteVehicle trgInjuredKeepUnconscious_02;
		deleteVehicle trgInjuredKeepUnconscious_03;
		deleteVehicle trgInjuredKeepUnconscious_04;
		
		trgCallMedEvacHeliCleanup = createTrigger ["EmptyDetector", getMarkerPos "wp_test_04" ];
		trgCallMedEvacHeliCleanup setTriggerArea [150, 150, 0, false];
		trgCallMedEvacHeliCleanup setTriggerActivation ["VEHICLE", "PRESENT", false];
		trgCallMedEvacHeliCleanup triggerAttachVehicle [evac_heli_01];
		trgCallMedEvacHeliCleanup setTriggerStatements [
			"this",
			"deleteVehicle trgCallMedEvacHeliCleanup; {{deleteVehicle _x} foreach crew _x; deleteVehicle _x} foreach thislist;",
			""
		];
	}; // Fn_Task_InjuredEvacuation_RecallMedEvac
	
};
