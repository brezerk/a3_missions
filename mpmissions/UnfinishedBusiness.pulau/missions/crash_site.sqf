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
		params ["_markerPos", "_boom"];
		
		//do envonmental damage
		for "_i" from 1 to 5 do {
			_boom = createVehicle ["Sh_120mm_HE", _markerPos, [], 0, "FLY"];
			_boom setPos [((getPos _boom select 0) + (round(random 25) - 10)), ((getPos _boom select 1) + (round(random 25) - 10)), 250];
			_boom setVelocity [0,0,-50];
		};
		
		//spawn creater and wreck
		"Crater" createVehicle (_markerPos); 
		_obj = "Land_Wreck_Plane_Transport_01_F" createVehicle (_markerPos); 
		//put fire and smoke
		_fire = "test_EmptyObjectForFireBig" createVehicle (_markerPos); 
		_fire attachTo [_obj, [0, 0, 0]];
		
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
		_obj addItemCargoGlobal ["ACE_bloodIV", 20];
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
	
	
	//spawn wreck
	_markerPos = getMarkerPos (["wp_plain_crash", 11] call BrezBlock_fnc_Get_RND_Index);
	[_markerPos] call Fn_Task_Create_C130J_CrashSite;
	[_markerPos] call Fn_Task_Create_C130J_SpawnRandomCargo;	
	for "_i" from 1 to 5 do {
		_markerPos = getMarkerPos (["wp_plain_crash", 11] call BrezBlock_fnc_Get_RND_Index);
		[_markerPos] call Fn_Task_Create_C130J_SpawnRandomCargo;
	};
	
	//heli patrol
	[_markerPos, rebel_heli_01] call Fn_Patrols_CreateLoiter;
	
	sleep 60;
	//vehicle patrol
	[[
		synd_jeep_01,
		synd_jeep_02,
		synd_jeep_03,
		synd_jeep_04,
		civ_veh_01,
		civ_veh_02,
		civ_veh_03,
		civ_veh_04
	]] call Fn_Patrols_Create_Random_Waypoints;
	[_markerPos, rebel_jeep_04, rebel_grp_01] call Fn_Patrols_Create_Transport_Sentry;
	[_markerPos, rebel_jeep_03] call Fn_Patrols_Create_Sentry;
	call Fn_Task_Create_CSAT_Triggers;
		
};