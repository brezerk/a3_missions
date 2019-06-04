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
	
	//POIs
	avaliable_locations = [];
	avaliable_pois = [];

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
	
	["Including..."] remoteExec ["systemChat"];
	
	#include "missions\patrols.sqf";
	#include "missions\poi.sqf";
	#include "missions\informator.sqf";
	
	["Ok. Patrols included..."] remoteExec ["systemChat"];
	
	/*
	#include "missions\intro.sqf";
	
	#include "missions\aa.sqf";
	#include "missions\leader.sqf";
	#include "missions\civilian\cargo.sqf";
	
	sleep 2;
	
	call Fn_Create_MissionIntro;*/
	
	
	private _ret = [(playableUnits + switchableUnits)] call Fn_POI_GetAllCitiesInPlayerRange;
	//Get all POI in the range of 3000m
	avaliable_locations = _ret select 0;
	avaliable_pois = _ret select 1;
	
	//Create markers
	{ 
		private _mark = createMarker [format ["wp_city_%1", _forEachIndex], _x select 1];
		_mark setMarkerType "hd_destroy";
		_mark setMarkerAlpha 0;
	} forEach avaliable_pois;
	
	//Spawn vehicles
	[avaliable_pois] call Fn_Patrols_CreateCivilean_Traffic;
	[avaliable_pois] call Fn_Patrols_CreateMilitary_Traffic;

	//Send vehicles on patrol
	[vehicle_patrol_group, avaliable_locations] call Fn_Patrols_Create_Random_Waypoints;
	
	call Fn_Task_Create_Informator;
};

// We need to end game if all players are no longer alive
//[] execVM "addons\brezblock\triggers\end_game.sqf";
