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
Crash site side-mission code
*/

// Intended to be executed on player side
Fn_Task_C130J_CrashSite_Info = {
	if (!isDedicated) then {
		params['_markerPos'];
		private ["_trg"];
				
		_trg = createTrigger ["EmptyDetector", _markerPos];
		_trg setTriggerArea [50, 50, 0, false];
		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		_trg setTriggerStatements [
			"(vehicle player) in thisList",
			"[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_01', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;",
			""
		];
		
		_trg = createTrigger ["EmptyDetector", _markerPos];
		_trg setTriggerArea [18, 18, 0, false];
		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
		_trg setTriggerStatements [
			"this",
			"['t_crash_site', 'SUCCEEDED'] call BIS_fnc_taskSetState;",
			""
		];
	};
};

// Server-only code
if (isServer) then {
	/*
	Spawn random heli crash site
		Arguments: None
		Usage: call Fn_Task_Create_HelicopterCrashSite
	*/
	Fn_Task_Create_C130J_CrashSite = {
		params ["_markerPos"];
		
		//do envonmental damage
		for "_i" from 1 to 5 do {
			private _boom = createVehicle ["Sh_120mm_HE", _markerPos, [], 0, "FLY"];
			_boom setPos [((getPos _boom select 0) + (round(random 25) - 10)), ((getPos _boom select 1) + (round(random 25) - 10)), 250];
			_boom setVelocity [0,0,-50];
		};
		
		//spawn creater and wreck
		private _crater = "CraterLong" createVehicle (_markerPos); 
		private _obj = "Land_UWreck_MV22_F" createVehicle (_markerPos); 
		_obj attachTo [_crater, [-1.5, 0, 3.5]];
		//put fire and smoke
		private _fire = "test_EmptyObjectForFireBig" createVehicle (_markerPos); 
		_fire attachTo [_crater, [0, 0, 0]];
		_fire = "test_EmptyObjectForFireBig" createVehicle (_markerPos); 
		_fire attachTo [_crater, [0, 3, 0]];
		
		/* does not seems to be working now?
		_fire = "ModuleEffectsSmoke_F" createVehicle (_markerPos); 
		_fire setVariable ["ParticleDensity",40 ,true];
		_fire setVariable ["ParticleSize", 15,true];
		_fire setVariable ["EffectSize", 5, true];
		_fire setVariable ["ParticleLifeTime", 180, true];
		*/
		
		[_markerPos] remoteExec ["Fn_Task_C130J_CrashSite_Info"];
	};
	
	
	/*
	Spawn cargo crate randomly. Remove all predefined items and populate with a desired ones;
		Arguments: [spawn marker]
		Usage: [{SpawnMarker}]] call Fn_Task_Create_ArriveToIsland_SpawnRandomCargo;
		Return: create object
	*/
	Fn_Task_Create_C130J_SpawnRandomCargo = {
		params ["_markerPos"];
		private ["_obj"];
		
		_obj = "B_supplyCrate_F" createVehicle ([((_markerPos select 0) + (round(random 25) - 10)), ((_markerPos select 1) + (round(random 25) - 10)), (_markerPos select 2)]);
		
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
			
		_obj addWeaponCargoGlobal ["CUP_hgun_M9", 2];
		_obj addWeaponCargoGlobal ["Binocular", 3];
		_obj addWeaponCargoGlobal ["CUP_arifle_M4A1", 2];
		_obj addWeaponCargoGlobal ["CUP_arifle_M16A4_Base", 2];
		_obj addWeaponCargoGlobal ["CUP_srifle_M14", 2];
		_obj addMagazineCargoGlobal ["CUP_15Rnd_9x19_M9", 10];
		_obj addMagazineCargoGlobal ["CUP_7Rnd_45ACP_1911", 10];
		_obj addMagazineCargoGlobal ["CUP_30Rnd_556x45_Stanag", 10];
		_obj addMagazineCargoGlobal ["CUP_20Rnd_762x51_DMR", 5];
		_obj addItemCargoGlobal ["ACE_EarPlugs", 5];
		_obj addItemCargoGlobal ["ItemCompass", 4];
		_obj addItemCargoGlobal ["ACE_fieldDressing", 20];
		_obj addItemCargoGlobal ["ACE_morphine", 10];
		_obj addItemCargoGlobal ["ACE_epinephrine", 6];
		_obj addItemCargoGlobal ["ACE_bloodIV", 20];
		_obj addBackpackCargoGlobal ["B_Kitbag_tan", 5];
			
		if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
				_obj addItemCargoGlobal ["ACRE_PRC148", 2];
				_obj addItemCargoGlobal ["ACRE_PRC343", 6];
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
	
	private _markers = [];
	{
		if (_x find "wp_plain_crash_" >= 0) then {
			_markers pushBack _x;
		};
	} forEach allMapMarkers;
	
	//spawn wreck
	_markerPos = getMarkerPos (selectRandom _markers);
	[_markerPos] call Fn_Task_Create_C130J_CrashSite;
	[_markerPos] call Fn_Task_Create_C130J_SpawnRandomCargo;	
	//heli patrol
	[_markerPos, rebel_heli_01] call Fn_Patrols_CreateLoiter;
	
	//Additional random cargos
	//for "_i" from 1 to 5 do {
	//	[selectRandom _markers] call Fn_Task_Create_C130J_SpawnRandomCargo;
	//};
	
	private _free_landing_markers = [];
	{
		if (_x find "wp_player_spawn_" >= 0) then {
			if (_markerPos distance2D getMarkerPos _x <= 2000) then {
				_free_landing_markers pushBack _x;
			};
		};
	} forEach allMapMarkers;

	{
		private _marker = selectRandom _free_landing_markers;
		_free_landing_markers = _free_landing_markers - [_marker];
		private _markerPos = getMarkerPos _marker;
		//parachute
		_x setPos [(_markerPos select 0), (_markerPos select 1), ((_markerPos select 2) + 180 + random 100)];
		remoteExecCall ["Fn_Local_Jet_Player_DoParadrop", _x];
		_x setVariable ["ACE_isUnconscious", true, true];
	} forEach assault_group;
		
	{deleteVehicle _x} foreach crew us_airplane_01; deleteVehicle us_airplane_01;
		
	//let them fall a bit
	sleep 1;
		
	private _ret = [_markerPos, 2500] call BrezBlock_fnc_GetAllCitiesInRange;
	//Get all POI in the range of 3000m
	avaliable_locations = _ret select 0;
	avaliable_pois = _ret select 1;
	[_markerPos, 3000] execVM "addons\brezblock\utils\controller.sqf";

	//Create markers
	{ 
		private _mark = createMarker [format ["wp_city_%1", _forEachIndex], _x select 1];
		_mark setMarkerType "hd_destroy";
		_mark setMarkerAlpha 0;
	} forEach avaliable_pois; 
		
	//Spawn vehicles
	[avaliable_pois] call Fn_Patrols_CreateCivilean_Traffic;
	[avaliable_pois] call Fn_Patrols_CreateMilitary_Traffic;
		
	//create tasks assigned to assault_group
	{
		_x setVariable ["ACE_isUnconscious", false, true];
		remoteExecCall ["Fn_Local_Jet_Player_Land", _x];
		[_x, true] remoteExecCall ["allowDamage"];
	} forEach assault_group;
		
	//Send vehicles on patrol
	[vehicle_patrol_group, avaliable_locations] call Fn_Patrols_Create_Random_Waypoints;
		
	sleep 5;
		
	[] execVM "missions\regroup.sqf";
	[] execVM "missions\assoult_group_is_dead.sqf";
	[] execVM "missions\informator.sqf";
		
	trgRegroupIsDone = createTrigger ["EmptyDetector", getMarkerPos 'wp_air_field_01'];
	trgRegroupIsDone setTriggerArea [0, 0, 0, false];
	trgRegroupIsDone setTriggerActivation ["NONE", "PRESENT", false];
	trgRegroupIsDone setTriggerStatements [
			"task_complete_intormator && task_complete_regroup",
			"call Fn_Task_Create_AA; call Fn_Task_Create_KillLeader; deleteVehicle trgRegroupIsDone;",
			""
	];
	
	sleep 60;
	[_markerPos, rebel_jeep_04, rebel_grp_01] call Fn_Patrols_Create_Transport_Sentry;
	[_markerPos, rebel_jeep_03] call Fn_Patrols_Create_Sentry;
	call Fn_Task_Create_CSAT_Triggers;
	
};