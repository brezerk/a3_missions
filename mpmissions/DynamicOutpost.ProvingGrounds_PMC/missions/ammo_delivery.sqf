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
Spawn start objectives, triggers for ammo delivery
*/

if (hasInterface) then {
	Fn_Local_Create_AmmoDelivery_Load = {
		[
			player,
			"t_ural_load",
			[localize "TASK_01_DESC",
			localize "TASK_01_TITLE",
			localize "TASK_ORIG_01"],
			getPos ua_ural_ammo_01,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_ural_load', "container"] call BIS_fnc_taskSetType;
	};

	Fn_Local_Task_Create_AmmoDelivery = {
		[
			player,
			"t_ural_delivery",
			[localize "TASK_02_DESC",
			localize "TASK_02_TITLE",
			localize "TASK_ORIG_01"],
			getMarkerPos "wp_ural_deliver_01",
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_ural_delivery', "truck"] call BIS_fnc_taskSetType;
	};
	
	Fn_Local_Create_AmmoDelivery_Unload = {
		[
			player,
			"t_ural_unload",
			[localize "TASK_04_DESC",
			localize "TASK_04_TITLE",
			localize "TASK_ORIG_01"],
			getPos ua_ural_ammo_01,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_ural_unload', "container"] call BIS_fnc_taskSetType;
	};
};

if (isServer) then {

	task_loaded_ua_supply_box_01 = false;
	task_loaded_ua_supply_box_02 = false;
	task_loaded_ua_supply_box_03 = false;
	task_loaded_ua_supply_box_04 = false;
	task_loaded_ua_supply_box_05 = false;
	
	"PUB_fnc_cargoLoaded" addPublicVariableEventHandler {(_this select 1) call EventHander_Delivery_BoxLoadUnload};
	
	/*
	Event Handler for loaded or unloaded box
	*/
	EventHander_Delivery_BoxLoadUnload = {
		private ["_vehicle", "_item", "_value"];
		_vehicle = _this select 0;
		_item = _this select 1;
		_value = _this select 2;
		if (_vehicle == ua_ural_ammo_01) then {
			if (typeName _item == "OBJECT") then {
				//FIXME: maybe we need dynamic eval
				if (_item == ua_supply_box_01) then { task_loaded_ua_supply_box_01 = _value; };
				if (_item == ua_supply_box_02) then { task_loaded_ua_supply_box_02 = _value; };
				if (_item == ua_supply_box_03) then { task_loaded_ua_supply_box_03 = _value; };
				if (_item == ua_supply_box_04) then { task_loaded_ua_supply_box_04 = _value; };
				if (_item == ua_supply_box_05) then { task_loaded_ua_supply_box_05 = _value; };
			};
		};
	};

	Fn_Task_Create_AmmoDelivery_Unload = {
		// Unload Ural
		['t_ural_delivery', 'SUCCEEDED'] call BIS_fnc_taskSetState;
		[1000] call Fn_Modify_Rating;
		deleteVehicle trgUralDestroyed;
		deleteVehicle trgUralDeliver;
		[] remoteExecCall ["Fn_Local_Create_AmmoDelivery_Unload", [0,-2] select isDedicated];
		trgUralUnload = createTrigger ["EmptyDetector", getPos ua_ural_ammo_01];
		trgUralUnload setTriggerArea [0, 0, 0, false];
		trgUralUnload setTriggerActivation ["NONE", "PRESENT", false];
		trgUralUnload setTriggerStatements [
			"!task_loaded_ua_supply_box_01 && !task_loaded_ua_supply_box_02 && !task_loaded_ua_supply_box_03 && !task_loaded_ua_supply_box_04 && !task_loaded_ua_supply_box_05",
			"['t_ural_unload', 'SUCCEEDED'] call BIS_fnc_taskSetState; deleteVehicle trgUralUnload; [1000] call Fn_Modify_Rating;",
			""
		];
	};


	Fn_Task_Create_AmmoDelivery = {
		[] remoteExecCall ["Fn_Local_Create_AmmoDelivery", [0,-2] select isDedicated];
		['t_ural_load', 'SUCCEEDED'] call BIS_fnc_taskSetState;

		// Deliver Ural
		trgUralDeliver = createTrigger ["EmptyDetector", getMarkerPos "wp_defend_01"];
		trgUralDeliver setTriggerArea [50, 50, 0, false];
		trgUralDeliver setTriggerActivation ["VEHICLE", "PRESENT", false];
		trgUralDeliver triggerAttachVehicle [ua_ural_ammo_01];
		trgUralDeliver setTriggerStatements [
			"this",
			"call Fn_Task_Create_AmmoDelivery_Unload;",
			""
		];
		[["wp_ambush_start", 5] call BrezBlock_fnc_Get_RND_Index, ["rus_spec", 4] call BrezBlock_fnc_Get_RND_Index] execVM 'addons\brezblock\utils\spawn_opfor_forces_guard.sqf';
		// report to officer
		call Fn_Task_Create_ReportOfficer;
	};

	Fn_Task_Create_AmmoDelivery_Load = {
		[] remoteExecCall ["Fn_Local_Create_AmmoDelivery_Load", [0,-2] select isDedicated];
		trgUralLoad = createTrigger ["EmptyDetector", getPos ua_ural_ammo_01];
		trgUralLoad setTriggerArea [0, 0, 0, false];
		trgUralLoad setTriggerActivation ["NONE", "PRESENT", false];
		trgUralLoad setTriggerStatements [
			//"task_loaded_ua_supply_box_01",
			"task_loaded_ua_supply_box_01 && task_loaded_ua_supply_box_02 && task_loaded_ua_supply_box_03 && task_loaded_ua_supply_box_04 && task_loaded_ua_supply_box_05",
			"call Fn_Task_Create_AmmoDelivery;",
			""
		];
		trgUralDestroyed = createTrigger ["EmptyDetector", getPos ua_ural_ammo_01];
		trgUralDestroyed setTriggerArea [0, 0, 0, false];
		trgUralDestroyed setTriggerActivation ["NONE", "PRESENT", false];
		trgUralDestroyed setTriggerStatements [
			"!alive ua_ural_ammo_01",
			"if (!triggerActivated trgUralLoad) then { ['t_ural_load', 'FAILED'] call BIS_fnc_taskSetState; call Fn_Endgame_Loss; } else { ['t_ural_delivery', 'FAILED'] call BIS_fnc_taskSetState; call Fn_Endgame_Loss; };",
			""
		];
		// Damage URAL
		//ua_ural_ammo_01 addEventHandler ["handleDamage","[str(_this)] remoteExec ['systemChat'];"]; 
		/*
		trgUralDoDamage = createTrigger ["EmptyDetector", getMarkerPos "wp_defend_01"];
		trgUralDoDamage setTriggerArea [(250 + (random 300)), (250 + (random 300)), 0, false];
		trgUralDoDamage setTriggerActivation ["VEHICLE", "PRESENT", false];
		trgUralDoDamage triggerAttachVehicle [ua_ural_ammo_01];
		trgUralDoDamage setTriggerStatements [
			"this",
			"call Fn_Objective_Ural_Damage_Wheel;",
			""
		];*/
		// URAL Cargo extend
		[ua_ural_ammo_01, 10] remoteExec ["ace_cargo_fnc_setSpace"];
	};
	
	/*
	Apply damage on ural wheel and play sound
	*/
	/*
	Fn_Objective_Ural_Damage_Wheel = {
		//to get a desried part
		//ua_ural_ammo_01 addEventHandler ["handleDamage","[str(_this)] remoteExec ['systemChat'];"];
		private ["_randomElement"];
		_randomElement =  selectRandom ["HitLFWheel",
			"HitRFWheel",
			"HitLMWheel",
			"HitLMWheel",
			"HitRF2Wheel",
			"HitLF2Wheel"
			];
		[ua_ural_ammo_01, [_randomElement, 1, true]] remoteExec ["setHitPointDamage"];
		["SmallExplosion"] remoteExec ["playSound"];
		//deleteVehicle trgUralDoDamage;
	};
	*/
};