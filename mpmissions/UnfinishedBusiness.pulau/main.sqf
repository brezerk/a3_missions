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
	
	s_west_group = createGroup west; publicVariable "s_west_group";
	s_east_group = createGroup east; publicVariable "s_east_group";
	s_indep_group = createGroup independent; publicVariable "s_indep_group";
	s_civ_group = createGroup civilian; publicVariable "s_civ_group";
	
	// Defaines (should be an UI option at mission startup);
	D_DIFFICLTY = 0; //0 easy, 1 medium, 2 hard
	D_FRACTION_INDEP = "CUP_I_NAPA"; //posible CUP_I_TK_GUE, IND_F, IND_F, IND_G_F
	
	D_LOCATION = "Gurun"; //selectRandom ["Gurun", "Monyet"];

	// Global variables
	
	pings = [];
	
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
	
	Fn_Spawn_UAZ = {
        params ["_spawnposition"];
        private ["_pos", "_vec"];
        _vec = objNull;
        if (isServer) then {
                _vec = selectRandom [
                        "CUP_O_UAZ_Unarmed_SLA",
                        "CUP_O_UAZ_Militia_SLA",
                        "CUP_O_UAZ_Open_SLA",
                        "CUP_O_UAZ_MG_SLA",
                        "CUP_O_UAZ_AGS30_SLA",
						"CUP_O_UAZ_SPG9_SLA",
						"CUP_O_UAZ_METIS_SLA"
                ];
                _pos = getMarkerPos _spawnposition findEmptyPosition [0, 15, _vec];
                _vec = createVehicle [_vec, _pos, [], 0];
                _vec setDir (markerDir _spawnposition);

        };
        _vec;
	};

	
	#include "missions\patrols.sqf";
	#include "missions\intro.sqf";
	#include "missions\aa.sqf";
	#include "missions\leader.sqf";
	#include "missions\civilian\cargo.sqf";
	
	waitUntil {real_weather_init};
	
	// skip random time
	skipTime ((random 5) + 6);
	
	sleep 2;
	
	call Fn_Create_MissionIntro;
	
	[Fn_Spawn_UAZ, 'wp_spawn_uaz_01', 20, 10] execVM 'addons\brezblock\triggers\respawn_transport.sqf';

};

// We need to end game if all players are no longer alive
//[] execVM "addons\brezblock\triggers\end_game.sqf";
