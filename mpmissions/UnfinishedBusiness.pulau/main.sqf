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

if (isServer) then {
	_westHQ = createCenter west;
	_eastHQ = createCenter east;
	_indepHQ = createCenter independent;
	_civilianHQ = createCenter civilian;
	
	//Set east and west sides to friends.
	//b/c friendship is a magic!
	EAST setFriend [WEST, 1];
	WEST setFriend [EAST, 1];
	
	// Defaines (should be an UI option at mission startup);
	D_DIFFICLTY = 0; //0 easy, 1 medium, 2 hard
	D_FRACTION_INDEP = "CUP_I_NAPA"; //posible CUP_I_TK_GUE, IND_F, IND_F, IND_G_F

	// Global variables
	assault_group = [];
	vehicle_confiscate_group = [];
	vehicle_refuel_group = [];
	vehicle_patrol_group = [];

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
	
	#include "missions\patrols.sqf";
	
	/*
	#include "missions\intro.sqf";
	
	#include "missions\aa.sqf";
	#include "missions\leader.sqf";
	#include "missions\civilian\cargo.sqf";
	
	sleep 2;
	
	call Fn_Create_MissionIntro;*/
	
	//Get all POI in the range of 3000m
	private _lcs = [];
	private _poi = [];
	private _blacklist = [
		'Pulau Monyet',
		'Monyet Airfield',
		'Pulau Gurun',
		'Gurun Airfield'
	];
	{
		if (alive _x) exitWith {
			{	
				if (!(text _x in _blacklist)) then {
					_lcs pushBack [text _x, locationPosition _x];
				};
			} forEach nearestLocations [getPos _x, ["NameVillage", "NameCity", "NameCityCapital"], 3500];	
		};
	} forEach allPlayers; //FIXME: assault_group only
	
	//Select no more than 4 to create tasks
	private _avalible_lcs = _lcs;
	if (count _lcs <= 4) then {
		_poi = _lcs;
	} else {
		for "_i" from 0 to 3 do {
			private _lc = selectRandom _avalible_lcs;
			_avalible_lcs = _avalible_lcs - [_lc];
			_poi pushBackUnique _lc;
		};
	};
	
	//Create markers
	{ 
		private _mark = createMarker [format ["wp_city_%1", _forEachIndex], _x select 1];
		_mark setMarkerType "hd_destroy";
		//_mark setMarkerAlpha 0;
	} forEach _poi;
	
	//Create civ vehicle patrols
	private _vehicles = [
		'C_Van_01_box_F',
		'C_Van_01_transport_F',
		'C_SUV_01_F',
		'C_Offroad_01_F',
		'C_Truck_02_fuel_F',
		'C_Truck_02_box_F',
		'C_Truck_02_transport_F',
		'C_Truck_02_covered_F',
		'CUP_C_Skoda_White_CIV',
		'CUP_C_Skoda_Blue_CIV',
		'CUP_C_Dutsan_Tubeframe',
		'CUP_C_Dutsan_Covered',
		'CUP_C_Tractor_CIV',
		'CUP_C_Volha_Blue_TKCIV',
		'CUP_C_V3S_Open_TKC',
		'CUP_C_V3S_Covered_TKC'
	];
	
	{ 
		for "_i" from 0 to (random 2) do {
			private _class = selectRandom _vehicles;
			private _pos = [_x select 1, 0, 90, 15, 0, 0, 0] call BIS_fnc_findSafePos;
			private _crew = [_pos, civilian, [_class]] call BIS_fnc_spawnGroup;
			_units = units _crew;
			{
				_vehicle = assignedVehicle _x;
				if (!isNull _vehicle) exitWith {
					vehicle_patrol_group append [_vehicle];
					vehicle_refuel_group append [_vehicle];
					vehicle_confiscate_group append [_vehicle];
				};
				[_class] remoteExec ["systemChat"];
			} forEach _units;
		};
	} forEach _poi;
	
	switch (D_FRACTION_INDEP) do
	{
		case 'IND_F': {
			_vehicles = [
				'CUP_I_LR_MG_AAF',
				'CUP_I_LR_SF_GMG_AAF',
				'CUP_I_LR_SF_HMG_AAF'
			];
		};
		case 'IND_G_F': {
			_vehicles = [
				'I_G_Offroad_01_AT_F',
				'I_G_Offroad_01_F',
				'I_G_Offroad_01_armed_F'
			];
		};
		case 'CUP_I_NAPA': {
			_vehicles = [
				'CUP_I_Datsun_PK',
				'CUP_I_Datsun_PK_Random',
				'CUP_I_Datsun_PK'
			];
		};
		case 'CUP_I_RACS': {
			_vehicles = [
				'CUP_I_LR_MG_RACS'
			];
		};
		case 'CUP_I_TK_GUE': {
			_vehicles = [
				'CUP_I_Datsun_PK_TK',
				'CUP_I_Datsun_PK_TK_Random',
				'CUP_I_Datsun_PK'
			];
		};
	};
	{ 
		for "_i" from 0 to (random 2) do {
			private _class = selectRandom _vehicles;
			private _pos = [_x select 1, 0, 90, 15, 0, 0, 0] call BIS_fnc_findSafePos;
			private _crew = [_pos, independent, [_class]] call BIS_fnc_spawnGroup;
			_units = units _crew;
			{
				_vehicle = assignedVehicle _x;
				if (!isNull _vehicle) exitWith {
					vehicle_patrol_group append [_vehicle];
					vehicle_refuel_group append [_vehicle];
					vehicle_confiscate_group append [_vehicle];
				};
				[_class] remoteExec ["systemChat"];
			} forEach _units;
		};
	} forEach _poi;
	
	//Send vehicles on patrol
	[vehicle_patrol_group, _lcs] call Fn_Patrols_Create_Random_Waypoints;
};

// We need to end game if all players are no longer alive
//[] execVM "addons\brezblock\triggers\end_game.sqf";
