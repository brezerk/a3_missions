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
	Arguments: [CallBack, Spawn Position, Spawn Direction, Timeout (/6), Initial Spawn Delay]
	Usage: [{CallBack},{SpawnPosition},{SpawnDir},{Timeout},{InitialSpawnDelay}] execVM ["addons/BrezBlock.framework/triggers/respawn_transport.sqf"];
	Return: true
*/

//Respawn vehicle on desired marker using provided function on vechicle death or timeout

if (isServer) then {
	params ["_vehicle"];
	
	// trigger area
	private _triggerArea = createTrigger ["EmptyDetector", (getPos _vehicle)];
	_triggerArea setTriggerArea [100, 100, 0, false];
	_triggerArea setTriggerActivation ["NONE", "PRESENT", true];
	_triggerArea setTriggerStatements [
		"this",
		"",
		""
	];
	
	private _counter = 0;
	private _timeout = 15;
	
		waitUntil {
		sleep 10;
		if (!alive _vehicle) exitWith {
			true;
		};
		if (!([_triggerArea, _vehicle] call BIS_fnc_inTrigger)) then {
			private _crew = {alive _x} count crew _vehicle;
			if (_crew == 0) then {
				private _nearest = nearestObjects [_vehicle, ["SoldierEB", "SoldierGB", "SoldierWB"], 600];
				if (count _nearest > 0) then {
					{
						//player found withing 500m
						if (isPlayer _x && alive _x) exitWith { _counter = 0; };
						_counter = _counter + 1;
					} forEach _nearest;
				} else {
					_counter = _counter + 1;
				};
			} else {
				_counter = 0;
			};
		};
		if (_counter >= _timeout) then {
			if (!isNull _vehicle) exitWith {
				_vehicle setVariable ["ace_cookoff_enable", false, true];
				_vehicle setVariable ["ace_cookoff_enableAmmoCookoff", false, true];
				_vehicle setDamage [1, false];
				true;
			};
			_counter = 0;
		};
		false;
	};
};
true
