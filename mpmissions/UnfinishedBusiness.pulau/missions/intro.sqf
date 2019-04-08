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
Spawn start objectives, triggers for game intro and players allocation
*/


//Player side triggers
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


if (isServer) then {

	Fn_Task_Create_ArriveToIsland = {
		trgJetIsDead = createTrigger ["EmptyDetector", getMarkerPos "wp_air_field_01" ];
		trgJetIsDead setTriggerArea [0, 0, 0, false];
		trgJetIsDead setTriggerActivation ["NONE", "PRESENT", false];
		trgJetIsDead setTriggerStatements [
			"!canMove us_airplane_01 || !alive us_airplane_01",
			"remoteExec ['Fn_Task_Create_ArriveToIsland_JetIsDown', 2]; deleteVehicle trgJetIsDead;",
			""
		];
		[
			west,
			"t_arrive_to_island",
			[localize "TASK_02_DESC",
			localize "TASK_02_TITLE",
			localize "TASK_ORIG_01"],
			getMarkerPos "wp_air_field_01",
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_arrive_to_island', "land"] call BIS_fnc_taskSetType;
		sleep 5;
		[
			west,
			"t_rebel_leader",
			[localize "TASK_01_DESC",
			localize "TASK_01_TITLE",
			localize "TASK_ORIG_01"],
			getMarkerPos "wp_air_field_02",
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_rebel_leader', "kill"] call BIS_fnc_taskSetType;
	};
	
	
	/*
	Spawn cargo crate randomly. Remove all predefined items and populate with a desired ones;
		Arguments: [spawn marker]
		Usage: [{SpawnMarker}]] call Fn_Task_Create_ArriveToIsland_SpawnRandomCargo;
		Return: create object
	*/
	Fn_Task_Create_ArriveToIsland_SpawnRandomCargo = {
		params ["_markerPos"];
		private ["_obj"];
		
		_obj = "B_supplyCrate_F" createVehicle ([((_markerPos select 0) + (round(random 25) - 10)), ((_markerPos select 1) + (round(random 25) - 10)), (_markerPos select 2)]);
		
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
			
		_obj addWeaponCargoGlobal ["rhsusf_weap_m1911a1", 3];
		_obj addWeaponCargoGlobal ["Binocular", 3];
		_obj addWeaponCargoGlobal ["rhs_weap_m4a1_carryhandle", 2];
		_obj addMagazineCargoGlobal ["rhsusf_mag_7x45acp_MHP", 5];
		_obj addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855_Stanag", 8];
		_obj addItemCargoGlobal ["ACE_EarPlugs", 5];
		_obj addItemCargoGlobal ["ItemCompass", 4];
		_obj addItemCargoGlobal ["ACE_fieldDressing", 20];
		_obj addItemCargoGlobal ["ACE_morphine", 10];
		_obj addItemCargoGlobal ["ACE_epinephrine", 6];
		_obj addBackpackCargoGlobal ["B_Kitbag_tan", 5];
			
		if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
				_obj addItemCargoGlobal ["ACRE_PRC148", 2];
				_obj addItemCargoGlobal ["ACRE_SEM52SL", 6];
			} else {
				if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
					_obj addItemCargoGlobal ["tf_anprc148jem", 2];
					_obj addItemCargoGlobal ["tf_anprc152", 6];
				} else {
					comment "Fallback to native arma3 radio";
					_obj addItemCargoGlobal ["ItemRadio", 6];
				};
		};
		_obj;
	};
	
	Fn_Task_Create_ArriveToIsland_JetIsDown = {
		_free_landing_markers = [
			'wp_player_spawn_01',
			'wp_player_spawn_02',
			'wp_player_spawn_03',
			'wp_player_spawn_04',
			'wp_player_spawn_05',
			'wp_player_spawn_06',
			'wp_player_spawn_07',
			'wp_player_spawn_08',
			'wp_player_spawn_09',
			'wp_player_spawn_10',
			'wp_player_spawn_11',
			'wp_player_spawn_12',
			'wp_player_spawn_13',
			'wp_player_spawn_14',
			'wp_player_spawn_15',
			'wp_player_spawn_16',
			'wp_player_spawn_17',
			'wp_player_spawn_18',
			'wp_player_spawn_19',
			'wp_player_spawn_20'
		];
		//sleep 5;
		[0, "BLACK", 8, 1] remoteExec ["BIS_fnc_fadeEffect", 0];
		sleep 3;
		{
			doGetOut _x;
			moveOut _x;
		} forEach playableUnits;
		
		//spawn wreck
		_markerPos = getMarkerPos (["wp_plain_crash", 11] call BrezBlock_fnc_Get_RND_Index);
		
		['t_arrive_to_island', 'FAILED'] call BIS_fnc_taskSetState;
		['t_rebel_leader', 'FAILED'] call BIS_fnc_taskSetState;

		for "_i" from 1 to 3 do {
			_boom = createVehicle ["Sh_120mm_HE", _markerPos, [], 0, "FLY"];
			_boom setPos [(_markerPos select 0), (_markerPos select 0), 200];
			_boom setVelocity [0,0,-50];
		};
		
		sleep 5;

		"Crater" createVehicle (_markerPos); 
		_obj = "Land_Wreck_Plane_Transport_01_F" createVehicle (_markerPos); 
		_fire = "test_EmptyObjectForFireBig" createVehicle (_markerPos); 
		_fire attachTo [_obj, [0, 0, 0]];
		[_markerPos] call Fn_Task_Create_ArriveToIsland_SpawnRandomCargo;
		
		for "_i" from 1 to 5 do {
			_markerPos = getMarkerPos (["wp_plain_crash", 11] call BrezBlock_fnc_Get_RND_Index);
			[_markerPos] call Fn_Task_Create_ArriveToIsland_SpawnRandomCargo;
		};

		{
			removeAllWeapons _x;
			removeAllItems _x;
			removeAllAssignedItems _x;
			removeBackpack _x;
			removeHeadgear _x;
			removeGoggles _x;
			
			_x addItemToUniform "ACE_EarPlugs";
			_x addItemToUniform "ACE_CableTie";
			for "_i" from 1 to 5 do {_x addItemToUniform "ACE_morphine";};
			for "_i" from 1 to 15 do {_x addItemToUniform "ACE_fieldDressing";};
			_x addGoggles "rhs_googles_clear";
			_x addWeapon "rhsusf_weap_m1911a1";
			_x addItemToVest "rhsusf_mag_7x45acp_MHP";
			for "_i" from 1 to 3 do {_x addItemToVest "rhs_mag_30Rnd_556x45_M855_Stanag";};
			for "_i" from 1 to 2 do {_x addItemToVest "Chemlight_green";};
			for "_i" from 1 to 2 do {_x addItemToVest "Chemlight_red";};
			_x setSpeaker "NoVoice";
			//ACEX
			_x addItemToVest "ACE_Canteen";
			_x linkItem "ItemWatch";
			_x linkItem "ItemMap";
			
			_x allowDamage true;
			
			_marker = selectRandom _free_landing_markers;
			_free_landing_markers = _free_landing_markers - [_marker];
			_markerPos = getMarkerPos _marker;
			
			
			
			//do some damage
			_dmgType = ["leg_l", "leg_r", "hand_r", "hand_l", "body", "head"];
			[_x, 2, selectRandom _dmgType, "bullet"] call ace_medical_fnc_addDamageToUnit;
			
			//parachute
			_x setPos [(_markerPos select 0), (_markerPos select 1), ((_markerPos select 2) + 140)];
			_x addBackpack "B_Parachute";
			_x action ["openParachute", _x];
			
			_x setVariable ["ACE_isUnconscious", true, true];
			_x setUnconscious true;
			
		} forEach playableUnits;
		[1, "BLACK", 10, 1] remoteExec ["BIS_fnc_fadeEffect", 0];
		
		{deleteVehicle _x} foreach crew us_airplane_01; deleteVehicle us_airplane_01;
		
		sleep 20;
		{
			_x setVariable ["ACE_isUnconscious", false, false];
			_x setUnconscious false;
		} forEach playableUnits;
		
		{
			[
				_x,
				"t_find_informator",
				[localize "TASK_04_DESC",
				localize "TASK_04_TITLE",
				localize "TASK_ORIG_01"],
				objNull,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_find_informator', "talk"] call BIS_fnc_taskSetType;
			[
				_x,
				"t_crash_site",
				[localize "TASK_05_DESC",
				localize "TASK_05_TITLE",
				localize "TASK_ORIG_01"],
				objNull,
				"CREATED",
				0,
				true
			] call BIS_fnc_taskCreate;
			['t_crash_site', "unknown"] call BIS_fnc_taskSetType;
		} forEach playableUnits;
		
		sleep 5;
		
		[
			west,
			"t_regroup",
			[localize "TASK_03_DESC",
			localize "TASK_03_TITLE",
			localize "TASK_ORIG_01"],
			objNull,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_regroup', "meet"] call BIS_fnc_taskSetType;
		
		
		//"test_EmptyObjectForFireBig" createVehicle (_markerPos); 
		/*_fire attachTo [this, [0, 0, 0]];
		_units = units _us_airplane_02;
		{
			_vehicle = assignedVehicle _x;
			if (!isNull _vehicle) exitWith {
				_vehicle setDamage 1;
			};
		} forEach _units;*/

	};

};