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
		_obj attachTo [_crater, [-1.5, -4, 3.5]];
		//put fire and smoke
		private _fire = "test_EmptyObjectForFireBig" createVehicle (_markerPos); 
		_fire attachTo [_crater, [0, -10.5, 0]];
		_fire = "test_EmptyObjectForFireBig" createVehicle (_markerPos); 
		_fire attachTo [_crater, [0, -6, 0]];
		
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
		
		private _pos = [_markerPos, 0, 35, 4, 0, 0, 0] call BIS_fnc_findSafePos;
		private _obj = "B_supplyCrate_F" createVehicle (_pos);
		
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
			
		_obj addWeaponCargoGlobal ["CUP_hgun_M9", 2];
		_obj addWeaponCargoGlobal ["Binocular", 3];
		_obj addWeaponCargoGlobal ["CUP_arifle_M4A1", 2];
		_obj addWeaponCargoGlobal ["CUP_arifle_M4A1_GL_carryhandle", 2];
		_obj addWeaponCargoGlobal ["CUP_arifle_M16A4_Base", 2];
		_obj addWeaponCargoGlobal ["CUP_srifle_M14", 2];
		_obj addWeaponCargoGlobal ["CUP_launch_M72A6", 2];	
		_obj addWeaponCargoGlobal ["CUP_launch_FIM92Stinger", 2];	
		_obj addWeaponCargoGlobal ["CUP_srifle_M14_DMR", 1];
		_obj addWeaponCargoGlobal ["CUP_lmg_m249_para", 1];
		_obj addWeaponCargoGlobal ["ACE_VMH3", 2];

		_obj addMagazineCargoGlobal ["CUP_15Rnd_9x19_M9", 10];
		_obj addMagazineCargoGlobal ["CUP_7Rnd_45ACP_1911", 10];
		_obj addMagazineCargoGlobal ["CUP_30Rnd_556x45_Stanag", 16];
		_obj addMagazineCargoGlobal ["CUP_20Rnd_762x51_DMR", 8];
		_obj addMagazineCargoGlobal ["CUP_1Rnd_HE_M203", 10];
		_obj addMagazineCargoGlobal ["CUP_M72A6_M", 4];
		_obj addMagazineCargoGlobal ["CUP_Stinger_M", 4];
		_obj addMagazineCargoGlobal ["CUP_100Rnd_TE4_Green_Tracer_556x45_M249", 4];

		_obj addItemCargoGlobal ["CUP_optic_LeupoldMk4", 2];
		_obj addItemCargoGlobal ["CUP_bipod_Harris_1A2_L", 2];
		_obj addItemCargoGlobal ["ACE_EntrenchingTool", 4];
		_obj addItemCargoGlobal ["ACE_EarPlugs", 10];
		_obj addItemCargoGlobal ["ItemCompass", 4];
		_obj addItemCargoGlobal ["ACE_fieldDressing", 20];
		_obj addItemCargoGlobal ["ACE_morphine", 10];
		_obj addItemCargoGlobal ["ACE_epinephrine", 6];
		_obj addItemCargoGlobal ["ACE_bloodIV", 20];
		_obj addItemCargoGlobal ["CUP_HandGrenade_M67", 10];
		_obj addItemCargoGlobal ["CUP_H_USMC_LWH_WDL", 10];
		_obj addItemCargoGlobal ["ACE_DefusalKit", 4];
		_obj addItemCargoGlobal ["ClaymoreDirectionalMine_Remote_Mag", 6];
		_obj addItemCargoGlobal ["DemoCharge_Remote_Mag", 4];
		
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
					_obj addItemCargoGlobal ["ItemRadio", 10];
				};
		};
		_obj;
	};
	
	
	_crashSitePos = getMarkerPos "wp_crash_site";
	
	[_crashSitePos] call Fn_Task_Create_C130J_CrashSite;
	[_crashSitePos] call Fn_Task_Create_C130J_SpawnRandomCargo;	
	//heli patrol
	[_crashSitePos] call Fn_Patrols_CreateLoiter;
	
	private _free_landing_markers = [];
	{
		if (_x find format["wp_paradrop_%1_", D_LOCATION] >= 0) then {
			if (_crashSitePos distance2D getMarkerPos _x <= 1800) then {
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
		_x setVariable ["ACE_isUnconscious", true, true];
		[D_DIFFICLTY] remoteExecCall ["Fn_Local_Jet_Player_DoParadrop", _x];
		[getPos _x, 300] execVM "addons\brezblock\utils\controller.sqf";
	} forEach assault_group;
		
	{deleteVehicle _x} foreach crew us_airplane_01; deleteVehicle us_airplane_01;
		
	//let them fall a bit
	sleep 2;
		
	//create tasks assigned to assault_group
	{
		_x setVariable ["ACE_isUnconscious", false, true];
		remoteExecCall ["Fn_Local_Jet_Player_Land", _x];
		[_x, true] remoteExecCall ["allowDamage"];
	} forEach assault_group;
		
	sleep 5;
		
	[] execVM "missions\regroup.sqf";
	[] execVM "missions\assoult_group_is_dead.sqf";
	[] execVM "missions\informator.sqf";
	
	{
		remoteExecCall ["Fn_Local_Create_RescueMission", _x];
	} forEach  (playableUnits + switchableUnits);
		
	//Send vehicles on patrol
	call Fn_Patrols_Create_Random_Waypoints;
	
	trgEvacPoint = createTrigger ["EmptyDetector", getPos us_liberty_01];
	trgEvacPoint setTriggerArea [1600, 1600, 0, false];
	trgEvacPoint setTriggerActivation ["WEST", "PRESENT", false];
	trgEvacPoint setTriggerStatements [
			"({alive _x && side _x == west} count (allPlayers -  entities 'HeadlessClient_F' ) == {alive _x && _x inArea thisTrigger && side _x == west} count (allPlayers - entities 'HeadlessClient_F' )) && (({alive _x && side _x == west} count allPlayers) > 0) && (count assault_group > 0)",
			"['t_us_rescue', 'SUCCEEDED'] call BIS_fnc_taskSetState; call Fn_Endgame_EvacPoint;",
			""
	];
	
	sleep 60;
	
	private _grp = createGroup [independent, true];
	
	private _vech0 = [_crashSitePos] call Fn_Patrols_Create_Sentry;
	private _vech1 = [_crashSitePos] call Fn_Patrols_Create_Transport_Sentry;
	
	[driver _vech0] joinSilent _grp;
	[driver _vech1] joinSilent _grp;
	
	private _wp = _grp addWaypoint [_crashSitePos, 0];
	_wp setWaypointType "TR UNLOAD";
	_wp setWaypointCombatMode "WHITE";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "NORMAL";
	
	call Fn_Task_Create_CSAT_Triggers;

	execVM "missions\ping.sqf";
};