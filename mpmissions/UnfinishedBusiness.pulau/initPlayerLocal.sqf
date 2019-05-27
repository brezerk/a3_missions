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

[] execVM "briefing.sqf";
[] execVM "missions\local\intro.sqf";
[] execVM "missions\local\fast_travel.sqf";
[] execVM "missions\local\jet_is_down.sqf";
[] execVM "missions\local\informator.sqf";
[] execVM "missions\local\aa.sqf";
[] execVM "missions\local\leader.sqf";
[] execVM "missions\local\csat.sqf";

Fn_Local_ConfiscateVehicle = {
	params["_vehicle"];
	private["_driver"];
	if (alive _vehicle) then {
		_driver = driver _vehicle;
		if (!isNull _driver) then {
			if ((!isPlayer _driver) && (alive _driver)) then {
				doGetOut driver _vehicle;
			};
		};
	};
};

Fn_Local_AddAction_ConfiscateVehicles = {
	params ["_vehicles"];
	{
		if (alive _x) then {
			_x addAction [localize 'ACTION_03', "call Fn_Local_ConfiscateVehicle;", this, 1, false, true, "", "alive _this", 5];
		}
	} forEach _vehicles;
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
			if (taskState _task != "Succeeded") then { _task setTaskState "Canceled"; };
		};
	} forEach ['t_scat_defend_aa', 't_scat_defend_comm_tower', 't_scat_eliminate_surv'];
};


player addEventHandler
[
	"Killed",
	{
		switch (playerSide) do
		{
			case west:
			{
				systemChat "switched";
				_group = createGroup east;
				[player] joinSilent _group;
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
		};
   }
];

//tickets
[player, 3] call BIS_fnc_respawnTickets;

// hide markers
{if (_x find "wp_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;
{if (_x find "respawn_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;

sleep 5;

[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_00', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;

[[west], [east,independent,civilian]] call ace_spectator_fnc_updateSides;

[[civ_veh_01, civ_veh_02, civ_veh_03, civ_veh_04]] call Fn_Local_AddAction_ConfiscateVehicles;