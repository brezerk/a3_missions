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

D_DEBUG = true;

[] execVM "addons\code43\real_weather.sqf";

if (isServer) then {

	fn_toCashString = {
		params["_cash"];
		
		_numDigits = 1;
		while{(_cash / (10 ^ _numDigits)) > 1} do {
			_numDigits = _numDigits + 1;
		};
		_value = [];
		_parts = [];
		for "_i" from _numDigits-1 to 1 step -1 do {
			_digit = floor(_cash / (10 ^ _i));
			_cash = _cash - (_digit * (10 ^ _i));
			_parts pushback str(_digit);
		};
		reverse _parts;
		{

			//if((_forEachIndex % 3) == 0 && _forEachIndex != 0) then {
			//	_value pushBack ",";
			//};
			_value pushBack _x;
		} forEach _parts;
		reverse _value;

		_value joinString ""
		
	};

	KKNou_fnc_floatToString = {
		if (_this < 0) then {
			str ceil _this + (str (_this - ceil _this) select [2])
		} else {
			str floor _this + (str (_this - floor _this) select [1])
		};
	};

	KK_fnc_intToString = {
		_s = "";
		while {_this >= 10} do {
			_this = _this / 10;
			_s = format ["%1%2", round ((_this % floor _this) * 10), _s];
			_this = floor _this;
		};
		format ["%1%2", _this, _s];
	};

	connected_users = [];
	
	//onPlayerConnected {}; // 1.58 bug, must be called before below mission event will work
	//onPlayerDisconnected {}; // 1.58 bug, must be called before below mission event will work
	
	addMissionEventHandler ["PlayerConnected",
	{
		params ["_id", "_uid", "_name", "_jip", "_owner"];
		diag_log "Client connected";
		diag_log _this;

		if (_name != "__SERVER__") then {
			connected_users pushBackUnique [_name, _id, format ["_USER_DEFINED #%1/", (_id call fn_toCashString)]];
			publicVariable "connected_users";
		};

		systemChat "CONNECTED";
	}];
	
	addMissionEventHandler ["PlayerDisconnected",
	{
		params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

		{
			if (getPlayerUID _x == _uid) exitWith {
				assault_group = assault_group - [_x];
			};
		} forEach (playableUnits + switchableUnits);

		systemChat "DISCONNECTED";
	}];

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
	
	
	D_DIFFICLTY = nil;
	D_LOCATION = nil;
	D_START_TYPE = nil;
	// Defaines (should be an UI option at mission startup);
	// Fixme should be diff dependent
	D_FRACTION_INDEP = "CUP_I_NAPA"; //posible CUP_I_TK_GUE, IND_F, IND_F, IND_G_F
	D_FRACTION_EAST = "CUP_O_SLA"; //possible CUP_O_TK, CUP_O_ChDKZ, 
	// Global variables
	
	mission_requested = false;
	mission_plane_send = false;
	
	//publicVariable "D_DIFFICLTY";
	publicVariable "mission_plane_send";
	
	pings = [];
	
	assault_group = [];
	vehicle_confiscate_group = [];
	vehicle_refuel_group = [];
	vehicle_patrol_group = [];
	checkpoint_gate_group = [];
	
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
	
	Fn_Endgame_EvacPoint = {
		if (alive csat_comm_tower_01 || alive csat_aa_01) then {
			"EndAssaultGroupResqued_EASTWon_GUERWon" call Fn_Endgame;
		} else {
			"EndAssaultGroupResqued_EASTDefited_GUERWon" call Fn_Endgame;
		};
	};
	
	Fn_Endgame_LeaderKilled = {
		if (alive csat_comm_tower_01 || alive csat_aa_01) then {
			"EndAssaultGroupResqued_EASTWon_GUERDefited" call Fn_Endgame;
		} else {
			"EndAssaultGroupResqued_EASTDefited_GUERDefited" call Fn_Endgame;
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
		};
	};

	#include "missions\patrols.sqf";
	#include "missions\intro.sqf";
	#include "missions\aa.sqf";
	#include "missions\leader.sqf";
	#include "missions\liberate.sqf";
	#include "missions\civilian\cargo.sqf";
	
	waitUntil {real_weather_init};
	
	// skip random time
	skipTime ((random 5) + 6);
	
	// Create base marker
	private _mark = createMarker ["mrk_base_west_01", getPos us_liberty_01];
	_mark setMarkerType "b_naval";
	_mark setMarkerText 'USS "Democracy"';
	
	_mark = createMarker ["mrk_base_west_02", getPos us_liberty_01];
	_mark setMarkerSize [2000, 2000];
	_mark setMarkerBrush "BDiagonal";
	_mark setMarkerShape "ellipse";
	_mark setMarkerColor "ColorWEST";
	
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
	
	call Fn_Create_MissionIntro;
	
	private _markers = [];
	{
		if (_x find format["wp_jet_crash_%1", D_LOCATION] >= 0) then {
			_markers pushBack _x;
		};
	} forEach allMapMarkers;
	
	//Create crash site marker
	private _crashSitePos = getMarkerPos (selectRandom _markers);
	_mark = createMarker ["wp_crash_site", _crashSitePos];
	_mark setMarkerType "hd_destroy";
	_mark setMarkerAlpha 0;
	
	_markers = [];
	{
		if ((markerType _x) in ["o_mortar"]) then {
			if (_x find D_LOCATION >= 0) then {
				if ((_crashSitePos distance2D (getMarkerPos _x)) <= 3000) then {
				_markers append [_x];
				};
			};
		};
	} forEach allMapMarkers;
	private _radioSitePos = getMarkerPos (selectRandom _markers);
	_mark = createMarker [format ["wp_%1_commtower", D_LOCATION], _radioSitePos];
	_mark setMarkerType "hd_destroy";
	_mark setMarkerAlpha 0;
	
	_mark = createMarker ["wp_defend_commtower", _radioSitePos];
	_mark setMarkerAlpha 0;
	_mark setMarkerSize [25, 25];
	_mark setMarkerBrush "SolidBorder";
	_mark setMarkerShape "ellipse";
	_mark setMarkerColor "ColorEAST";
	[_mark] call BrezBlock_fnc_CreateDefend;
	
	_mark = createMarker ["wp_patrol_commtower", _radioSitePos];
	_mark setMarkerAlpha 0;
	_mark setMarkerSize [50, 50];
	_mark setMarkerBrush "DiagGrid";
	_mark setMarkerShape "ellipse";
	_mark setMarkerColor "ColorEAST";
	[_mark] call BrezBlock_fnc_CreatePatrol;
	
	private _ret = [_crashSitePos, 3000, 2] call BrezBlock_fnc_GetAllCitiesInRange;
	//Get all POI in the range of 3000m
	avaliable_locations = _ret select 0;
	avaliable_pois = _ret select 1;
	
	publicVariable "avaliable_pois";

	[_crashSitePos, 900] execVM "addons\brezblock\utils\controller.sqf";

	execVM "missions\create_locations.sqf";
	
	[getMarkerPos (format ["wp_%1_aa", D_LOCATION]), 600] execVM "addons\brezblock\utils\controller.sqf";
	[getMarkerPos (format ["wp_%1_airfield", D_LOCATION]), 600] execVM "addons\brezblock\utils\controller.sqf";
	[getMarkerPos (format ["respawn_east_%1", D_LOCATION]), 150] execVM "addons\brezblock\utils\controller.sqf";
	
	[Fn_Spawn_UAZ, (format ["wp_spawn_uaz_%1_01", D_LOCATION]), 20, 10] execVM 'addons\brezblock\triggers\respawn_transport.sqf';
	[Fn_Spawn_UAZ, (format ["wp_spawn_uaz_%1_02", D_LOCATION]), 20, 10] execVM 'addons\brezblock\triggers\respawn_transport.sqf';
	
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

// We need to end game if all players are no longer alive
//[] execVM "addons\brezblock\triggers\end_game.sqf";
