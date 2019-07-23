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
Local player script
*/

waitUntil { !isNull player }; // Wait for player to initialize

mission_requested = false;
mission_plane_send = false;
informator_told = false;

//tickets
[player, 3] call BIS_fnc_respawnTickets;

// hide markers
{if (_x find "wp_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;
{if (_x find "respawn_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;

//playSound "RadioAmbient2";

player setVariable ["weapon_fiered", false, false];
player setVariable ["is_civilian", false, true];

#include "briefing.sqf";
#include "missions\local\intro.sqf";
#include "missions\local\fast_travel.sqf";
#include "missions\local\jet_is_down.sqf";
#include "missions\local\informator.sqf";
#include "missions\local\aa.sqf";
#include "missions\local\leader.sqf";
#include "missions\local\csat.sqf";
#include "missions\local\west.sqf";
#include "missions\local\cargo.sqf";
#include "missions\local\crash_site.sqf";
#include "missions\local\rescue.sqf";
//#include "missions\local\police.sqf";
#include "missions\civilian\liberate.sqf";
#include "missions\local\regroup.sqf";

execVM "missions\local\patrols.sqf";

Fn_Local_SetPersonalTaskState = {
	params['_name', '_state'];
	private ['_task'];
	systemChat format ["CHeck %1 %2", _name, _state];
	_task = [_name, player] call BIS_fnc_taskReal;
	if (!isNull _task) then {
		systemChat "SET";
		_task setTaskState _state;
	} else {
		systemChat "NUL?";
	};
};

Fn_Local_FailTasks = {
	private ['_task'];
	{
		_task = [_x, player] call BIS_fnc_taskReal;
		if (!isNull _task) then {
			if (taskState _task != "Succeeded") then { _task setTaskState "Failed"; };
		};
	} forEach ['t_crash_site', 't_regroup', 't_find_informator'];
	{
		_task = [_x, player] call BIS_fnc_taskReal;
		if (!isNull _task) then {
			if (!(taskState _task in ["Succeeded", "Failed"])) then { _task setTaskState "Canceled"; };
		};
	} forEach [
		't_us_rescue',
		't_scat_defend_aa',
		't_scat_defend_comm_tower',
		't_scat_eliminate_surv',
		't_destroy_aa',
		't_destroy_comtower',
		't_kill_leader',
		't_civ_boat',
		//'t_civ_police',
		't_civ_weapon_stash',
		't_libirate_0',
		't_libirate_1',
		't_us_rescue_crash',
		't_us_rescue_city_0',
		't_us_rescue_city_1',
		't_east_crash',
		't_east_city_0',
		't_east_city_1'
	];
};

Fn_Local_CheckIfCivPlayerDetected = {
	private['_detected'];
	_detected = false;
	if (player getVariable ["is_civilian", false]) then {
		if (!(player getVariable ["weapon_fiered", false])) then {
			{
				if ((_x knowsAbout player) > 0) exitWith {
					_detected = true;
				};
			} forEach nearestObjects [player, ["SoldierEB", "SoldierGB", "SoldierWB"], 800];
		};
	};
	_detected;
};

Fn_Local_Switch_Side = {
	params['_side'];
	private _player = player; 
	[player] joinSilent createGroup [_side, true];
	selectNoPlayer; 
	selectPlayer _player;
};

player addEventHandler
[
	"Killed",
	{
		player setVariable ["is_assault_group", false, true];
		player setVariable ["is_civilian", false, true];
		player setVariable ["weapon_fiered", false, false];
		deleteVehicle trgCivPlayerDetected;
		deleteVehicle trgCivFloodedShip;
		//deleteVehicle trgCivPoliceStation;
		deleteVehicle trgCivStash01;
		deleteVehicle trgCivStash02;
		deleteVehicle trgCivPlayerDetected;
		deleteVehicle trgCivLiberate00;
		deleteVehicle trgCivLiberate01;
		deleteVehicle trgWestCrashSite;

		private _sides = [civilian, east, west];
		
		if (!(alive csat_comm_tower_01)) then {
			_sides = _sides - [east];
		};
		
		if (count (nearestObjects [us_liberty_01, ["Ship", "Helicopter"], 100]) <= 0) then {
			_sides = _sides - [west];
		};

		if (count _sides > 2) then {
			_sides = _sides - [playerSide];
		};
		
		//_sides = [west];
		private _side = selectRandom _sides;

		switch (_side) do
		{
			case east:
			{
				//systemChat "switched";
				[east] call Fn_Local_Switch_Side;
				player setVariable ["is_civilian", false, true];
			};
			case civilian:
			{
				//systemChat "switched";
				[civilian] call Fn_Local_Switch_Side;
				player setVariable ["is_civilian", true, true];
			};
			case west:
			{
				//systemChat "switched";
				[west] call Fn_Local_Switch_Side;
				player setVariable ["is_civilian", false, true];
			};
		};
	}
];

player addEventHandler
[
   "Respawn",
   {
		switch (playerSide) do
		{
			case east:
			{
				[] execVM "gear\csat.sqf";
				player setPos getMarkerPos "respawn_east";
				call Fn_Local_Create_SCAT_MissionIntro;
			};
			case civilian:
			{
				[] execVM "gear\civilian.sqf";
				private _civ_spawn_markers = [];
				{
					if (_x find "respawn_civilian_" >= 0) then {
						_civ_spawn_markers pushBack _x;
					};
				} forEach allMapMarkers;
				player setPos getMarkerPos selectRandom _civ_spawn_markers;
				call Fn_Local_Create_Task_Civilian_FloodedShip;
				call Fn_Local_Create_Task_Civilian_WaponStash;
				//call Fn_Local_Create_Task_Civilian_Police;
				call Fn_Local_Create_Task_Civilian_Liberate_MissionIntro;
			};
			case west:
			{
				private _pos = getMarkerPos "respawn_west";
				[] execVM "gear\west.sqf";
				player setPos [_pos select 0, _pos select 1, 8];
				call Fn_Local_Create_EAST_MissionIntro;
			};
		};
   }
];

player addEventHandler [
	"GetInMan", 
	{
		params ["_unit", "_role", "_vehicle", "_turret"];
		if (playerSide == civilian) then {
			private _v_side = side _vehicle;
			if ((_v_side == east) or (_v_side == independent)) then {
				player setVariable ["is_civilian", false, true];
				[west] call Fn_Local_Switch_Side;
				doGetOut player;
			};
		};
	}
];

player addEventHandler [
	"InventoryOpened",
	{
		params ["_unit", "_container"];
		if (playerSide == civilian) then {
			private _v_side = side _container;
			if ((_v_side == east) or (_v_side == independent)) then {
				player setVariable ["is_civilian", false, true];
				[west] call Fn_Local_Switch_Side;
			};
		};
	}
];

player addEventHandler
[
    "Take",
    {
		if (playerSide == civilian) then {
			if (primaryWeapon player != "" || secondaryWeapon player != "" || handgunWeapon player != "") then {
				[west] call Fn_Local_Switch_Side;
				trgCivPlayerDetected = createTrigger ["EmptyDetector", getPos player];
				trgCivPlayerDetected setTriggerArea [0, 0, 0, false];
				trgCivPlayerDetected setTriggerActivation ["NONE", "PRESENT", false];
				trgCivPlayerDetected setTriggerStatements [
					"call Fn_Local_CheckIfCivPlayerDetected;",
					"player setVariable ['weapon_fiered', true, false]; deleteVehicle trgCivPlayerDetected;",
					""
				];
			};
		};
    }
];

player addEventHandler
[
    "Put",
    {
		if (player getVariable ["is_civilian", false]) then {
			if (!(player getVariable ["weapon_fiered", false])) then {
				if (primaryWeapon player == "" && secondaryWeapon player == "" && handgunWeapon player == "") then {
					[civilian] call Fn_Local_Switch_Side;
					deleteVehicle trgCivPlayerDetected;
				};
			};
		};
    }
];

sleep 5;

[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_00', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;

[[west], [east,independent,civilian]] call ace_spectator_fnc_updateSides;




