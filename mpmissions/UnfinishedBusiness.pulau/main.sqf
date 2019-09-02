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

real_weather_init = false;

D_LOCATIONS = ['Gurun', 'Monyet']; //, 'Monyet'];

D_DEBUG = false;

[] execVM "addons\code43\real_weather.sqf";

if (isServer) then {
	_westHQ = createCenter west;
	_eastHQ = createCenter east;
	_indepHQ = createCenter independent;
	_civilianHQ = createCenter civilian;
	
	//make east and independent friends
	EAST setFriend [independent, 1];
	independent setFriend [EAST, 1];
	
	//make independent and west enemies
	WEST setFriend [independent, 0];
	independent setFriend [WEST, 0];
	
	//Set east and west sides to friends.
	//b/c friendship is a magic!
	EAST setFriend [WEST, 1];
	WEST setFriend [EAST, 1];
	
	D_DIFFICLTY = nil;
	D_LOCATION = nil;
	D_START_TYPE = nil;
	
	// Defaines (should be an UI option at mission startup);
	// FIXME: should be diff dependent
	D_FRACTION_INDEP = "CUP_I_NAPA"; //posible CUP_I_TK_GUE, IND_F, IND_F, IND_G_F
	
	D_FRACTION_INDEP_UNITS_PATROL = [];
	D_FRACTION_INDEP_UNITS_GARRISON = [];
	D_FRACTION_INDEP_UNITS_CARS = [];
	D_FRACTION_INDEP_UNITS_LIGHT = [];
	D_FRACTION_INDEP_UNITS_HEAVY = [];
	D_FRACTION_INDEP_UNITS_TRANSPORT = [];
	
	D_FRACTION_EAST = "CUP_O_SLA"; //possible CUP_O_TK, CUP_O_ChDKZ, 
	
	D_FRACTION_EAST_UNITS_PATROL = [];
	D_FRACTION_EAST_UNITS_GARRISON = [];
	D_FRACTION_EAST_UNITS_CARS = [];
	D_FRACTION_EAST_UNITS_LIGHT = [];
	D_FRACTION_EAST_UNITS_HEAVY = [];
	D_FRACTION_EAST_UNITS_TRANSPORT = [];
	
	D_FRACTION_CIV = "CUP_C"; //possible CUP_O_TK, CUP_O_ChDKZ, 
	
	D_FRACTION_CIV_UNITS_MENS = [];
	D_FRACTION_CIV_UNITS_CARS = [];
	D_FRACTION_CIV_UNITS_BOATS = [];

	// Global variables	
	mission_requested = false;
	mission_plane_send = false;
	
	//Objects
	obj_east_comtower = objNull;
	obj_east_antiair = objNull;
	
	//Task states
	task_complete_commtower = false;
	task_complete_antiair = false;
	task_complete_regroup = false;

	//Global arrays
	pings = [];
	connected_users = [];
	assault_group = [];
	vehicle_refuel_group = [];
	vehicle_patrol_group = [];
	checkpoint_gate_group = [];
	shared_missions = [];
	
	//POIs
	avaliable_locations = [];
	avaliable_pois = [];
	
	addMissionEventHandler ["PlayerConnected",
	{
		// 1.58 bug, idstr is empty on linux host
		params ["_id", "_uid", "_name", "_jip", "_owner"];
		if (D_DEBUG) then {
			diag_log "Client connected";
			diag_log _this;
		};
		if (_name != "__SERVER__") then {
			connected_users pushBackUnique [_name, (_id call CBA_fnc_formatNumber), format ["_USER_DEFINED #%1/", (_id call CBA_fnc_formatNumber)]];
			publicVariable "connected_users";
			publicVariable "D_LOCATION";
			publicVariable "locationFloodedShip";
			publicVariable "mission_plane_send";
			publicVariable "mission_requested";
			remoteExecCall ["Fn_Local_SyncMission", _owner];
			systemChat "CONNECTED";
		};
	}];
	
	addMissionEventHandler ["PlayerDisconnected",
	{
		params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
		if (D_DEBUG) then {
			diag_log "Client disconnected";
			diag_log _this;
		};
		{
			if (getPlayerUID _x == _uid) exitWith {
				assault_group = assault_group - [_x];
			};
		} forEach (playableUnits + switchableUnits);

	}];

	Fn_Endgame = {
		params["_endingType"];
		if (isServer) then {
			_endingType call BIS_fnc_endMissionServer;
		};
	};

	Fn_Endgame_Loss = {
		if (isServer) then {
			//['t_defend_blockpost', 'FAILED'] call BIS_fnc_taskSetState;
			"EveryoneLost" call BIS_fnc_endMissionServer;
		};
	};

	Fn_Endgame_Win = {
		if (isServer) then {
			"EveryoneWon" call BIS_fnc_endMissionServer;
		};
	};
	
	Fn_Endgame_EvacPoint = {
		if (alive obj_east_comtower || alive obj_east_antiair) then {
			"EndAssaultGroupResqued_EASTWon_GUERWon" call Fn_Endgame;
		} else {
			"EndAssaultGroupResqued_EASTDefited_GUERWon" call Fn_Endgame;
		};
	};
	
	Fn_Endgame_LeaderKilled = {
		if (alive obj_east_comtower || alive obj_east_antiair) then {
			"EndAssaultGroupResqued_EASTWon_GUERDefited" call Fn_Endgame;
		} else {
			"EndAssaultGroupResqued_EASTDefited_GUERDefited" call Fn_Endgame;
		};
	};
	
	"PUB_fnc_missionPlanned" addPublicVariableEventHandler {
		(_this select 1) call EventHander_MissionPlanned;
	};
	
	/*
	Event Handler for loaded or unloaded box
	*/
	EventHander_MissionPlanned = {
		params ["_difficlty", "_location", "_start_type"];
		if (!mission_requested) then {
			D_DIFFICLTY = _difficlty;
			D_LOCATION = _location;
			D_START_TYPE = _start_type;
			mission_requested = true;
			publicVariable "D_LOCATION";
			publicVariable "mission_requested";
			//Remove unneeded markers
			{
				if (_x != D_LOCATION) then {
					private _filter = format ["wp_%1", _x];
					{
						if (_x find _filter >= 0) then {deleteMarker _x};
					} forEach allMapMarkers;
				};
			} forEach D_LOCATIONS;
		};
	};
	
	#include "config\stash.sqf";
	#include "config\fractions.sqf"; 

	#include "missions\patrols.sqf";
	#include "missions\intro.sqf";
	#include "missions\leader.sqf";
	#include "missions\liberate.sqf";
	#include "missions\civilian\cargo.sqf";
	#include "missions\civilian\transport.sqf";
	#include "missions\independent\objectives.sqf";
	#include "missions\east\commtower.sqf";
	#include "missions\east\aa.sqf";
	#include "missions\east\supply.sqf";
	#include "missions\east\transport.sqf";
	#include "missions\east\helicopter.sqf";
	#include "missions\west\planning.sqf";
	#include "missions\west\hiddenstash.sqf";
	#include "missions\west\safehouse.sqf";
	#include "missions\west\supply.sqf";
	#include "missions\west\intel.sqf";
	
	waitUntil {real_weather_init};
	
	// skip random time
	skipTime ((random 5) + 6);
	
	// Create base marker
	[getPos us_liberty_01] call Fn_West_MissionPlanning_CreateMarkers_Base;
	
	[us_base_suppy_01] call Fn_Task_West_Create_Supply;
	
	//Load fraction unit configurations
	D_FRACTION_INDEP_UNITS_PATROL = ([independent, D_FRACTION_INDEP, 'patrol'] call Fn_Config_GetFraction_Units);
	D_FRACTION_INDEP_UNITS_GARRISON = ([independent, D_FRACTION_INDEP, 'garrison'] call Fn_Config_GetFraction_Units);
	D_FRACTION_INDEP_UNITS_CARS = ([independent, D_FRACTION_INDEP, 'cars'] call Fn_Config_GetFraction_Units);
	D_FRACTION_INDEP_UNITS_LIGHT = ([independent, D_FRACTION_INDEP, 'light'] call Fn_Config_GetFraction_Units);
	D_FRACTION_INDEP_UNITS_HEAVY = ([independent, D_FRACTION_INDEP, 'heavy'] call Fn_Config_GetFraction_Units);
	D_FRACTION_INDEP_UNITS_TRANSPORT = ([independent, D_FRACTION_INDEP, 'transport'] call Fn_Config_GetFraction_Units);
	
	//Load fraction unit configurations
	D_FRACTION_EAST_UNITS_PATROL = ([east, D_FRACTION_EAST, 'patrol'] call Fn_Config_GetFraction_Units);
	D_FRACTION_EAST_UNITS_GARRISON = ([east, D_FRACTION_EAST, 'garrison'] call Fn_Config_GetFraction_Units);
	D_FRACTION_EAST_UNITS_CARS = ([east, D_FRACTION_EAST, 'cars'] call Fn_Config_GetFraction_Units);
	D_FRACTION_EAST_UNITS_LIGHT = ([east, D_FRACTION_EAST, 'light'] call Fn_Config_GetFraction_Units);
	D_FRACTION_EAST_UNITS_HEAVY = ([east, D_FRACTION_EAST, 'heavy'] call Fn_Config_GetFraction_Units);
	D_FRACTION_EAST_UNITS_TRANSPORT = ([east, D_FRACTION_EAST, 'transport'] call Fn_Config_GetFraction_Units);
	
	D_FRACTION_CIV_UNITS_MENS = ([civilian, D_FRACTION_CIV, 'mens'] call Fn_Config_GetFraction_Units);
	D_FRACTION_CIV_UNITS_CARS = ([civilian, D_FRACTION_CIV, 'cars'] call Fn_Config_GetFraction_Units);
	D_FRACTION_CIV_UNITS_BOATS = ([civilian, D_FRACTION_CIV, 'boats'] call Fn_Config_GetFraction_Units);
	
	waitUntil {
		sleep 3;
		{
			remoteExecCall["Fn_Local_WaitForPlanning", _x];
		} forEach (playableUnits + switchableUnits);
		mission_requested;
	};
	
	{
		remoteExecCall["Fn_Local_Planned", _x];
	} forEach (playableUnits + switchableUnits);
	
	[[us_liberty_01, "Land_Destroyer_01_hull_04_F"] call BIS_fnc_Destroyer01GetShipPart, 1, false] call BIS_fnc_Destroyer01AnimateHangarDoors;
	
	call Fn_West_MissionPlanning_CreateMarkers_EastBase;
	
	call Fn_Create_MissionIntro;
	
	execVM "missions\create_locations.sqf";
		
	addMissionEventHandler ["EntityKilled",
	{
		params ["_killed", "_killer", "_instigator"];
		
		private _group = group _killed;
		
		if (_group != grpNull) then {	
			private _killed_side = side _group;
			systemChat format ["%1", _killed_side];
			
			if ((_killed_side == east) || (_killed_side == independent)) then {
				private _ace_kill = _killed getVariable "ace_medical_lastDamageSource";
				if (!isNil "_ace_kill") then {
					if (isPlayer _ace_kill) then {
						if ((side _ace_kill) == civilian) then {
							_ace_kill setVariable ["is_civilian", false, true];
							[west] remoteExec ["Fn_Local_Switch_Side", _ace_kill];
						};
					};
				};
			};
			if (_killed_side == civilian) then {
				private _ace_kill = _killed getVariable "ace_medical_lastDamageSource";
				if (!isNil "_ace_kill") then {
					if (isPlayer _ace_kill) then {
						if ((side _ace_kill) == west) then {
							pings pushBackUnique (mapGridPosition _player);
							remoteExec ["Fn_Local_CarmaKillCiv", _ace_kill];
						};
					};
				};
			};
		} else {
			systemChat "Error: Can't group";
		};
	}];
};
