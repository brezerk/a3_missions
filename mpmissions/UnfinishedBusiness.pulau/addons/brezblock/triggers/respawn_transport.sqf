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
Paradrop
	Arguments: [CallBack, Spawn Position, Timeout (/6), Initial Spawn Delay]
	Usage: [{CallBack},{SpawnPosition},{Timeout},{InitialSpawnDelay}] execVM ["addons/brezblock/triggers/respawn_transport.sqf"];
	Return: true
*/

//Respawn vehicle on desired marker using provided function on vechicle death or timeout

if (isServer) then {
	params ["_callBackSpawn", "_spawnposition", ["_timeout", 10], ["_initialSpawnDelay", 0]];
	private ["_vehicle", "_counter", "_triggerArea"];

	sleep _initialSpawnDelay;
	
	_vehicle = [_spawnposition] call _callBackSpawn;
	_counter = 0;

	// trigger area
	_triggerArea = createTrigger ["EmptyDetector", getMarkerPos _spawnposition];
	_triggerArea setTriggerArea [100, 100, 0, false];
	_triggerArea setTriggerActivation ["NONE", "PRESENT", true];
	_triggerArea setTriggerStatements [
		"this",
		"",
		""
	];
	
	waitUntil {
		sleep 10;
		if (!alive _vehicle) then {
			_counter = _counter + 1;
		};
		if (!([_triggerArea, _vehicle] call BIS_fnc_inTrigger)) then {
			if (count (crew _vehicle) == 0) then {
				{
					//player found withing 500m
					if (isPlayer _x) exitWith {};
					_counter = _counter + 1;
				} forEach nearestObjects [_vehicle, ["SoldierEB", "SoldierGB", "SoldierWB"], 500];
			} else {
				_counter = 0;
			};
		};
		if (_counter >= _timeout) then {
			if (!isNull _vehicle) then {
				_vehicle setVariable ["ace_cookoff_enable", false, true];
				_vehicle setVariable ["ace_cookoff_enableAmmoCookoff", false, true];
				_vehicle setDamage [1, false];
				sleep 15;
				deleteVehicle _vehicle;
			};
			_vehicle = [_spawnposition] call _callBackSpawn;
			_counter = 0;
		};
		false
	};
};
true
