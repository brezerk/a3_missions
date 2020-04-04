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


params["_src", "_dst"];		
		
if ((_src getVariable ["fuel_capacity", 0]) > 0) then {	
	//Execute revive animation
	[player, "AinvPknlMstpSnonWnonDnon_medicUp3"] remoteExec ["playMoveNow", 0, false];
	//Wait for revive animation to be set
	waitUntil {sleep 0.05; ((animationState player) == "AinvPknlMstpSnonWnonDnon_medicUp3")};
	//call progress
	[
		5,
		[_src, _dst],
		{
			_this params ["_parameter"];
			_parameter params ["_src", "_dst"];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
			
			_dst_is_vehicle = { if (_dst isKindOf _x) exitWith {true}; false } forEach ["Car", "Tank", "Truck"];
			_dst_fuel_needed = false;
			if (_dst_is_vehicle) then {
				_dst_fuel_needed = (fuel _dst < 1.0);
			} else {
				_dst_fuel_needed = ((_dst getVariable ["fuel_capacity", 0]) < (_dst getVariable ["fuel_max_capacity", 0]));
			};
			//systemChat format ["V: %1 N: %2", _dst_is_vehicle, _dst_fuel_needed];
			if (_dst_fuel_needed) then {
				_fuel_avaliable = (_src getVariable ["fuel_capacity", 0]);
				if (_fuel_avaliable > 0) then {
					_amount = 0;
					_capacity_max = 0;
					_capacity = 0;
					if (_dst_is_vehicle) then {
						_capacity_max = getNumber (configfile >> "CfgVehicles" >> typeOf _dst >> "ace_refuel_fuelCapacity");
						_capacity = _capacity_max - (_capacity_max * (fuel _dst));
					} else {
						_capacity_max = (_dst getVariable ["fuel_max_capacity", 0]);
						_capacity = _capacity_max - (_dst getVariable ["fuel_capacity", 0]);
					};
					systemChat format ["V Capacity: %1 of %2", _capacity, _capacity_max];
					if (_capacity >= 10) then {
						if (_fuel_avaliable >= 10) then {
							_amount = 10;
							systemChat "Залито 10л!";
						} else {
							_amount = _fuel_avaliable;
							systemChat format ["Залито залишки ~%1л!", (round _amount)];
						};
					} else {
						if (_fuel_avaliable >= _capacity) then {
							_amount = _capacity;
							systemChat format ["Залито ~%1л. Повний бак!", (round _amount)];
						} else {
							_amount = _fuel_avaliable;
							systemChat format ["Залито залишки ~%1л!", (round _amount)];
						};
					};
					_src setVariable ["fuel_capacity", (_fuel_avaliable - _amount), true];
					if (_dst_is_vehicle) then {
						_amount_f = parseNumber ((_amount / _capacity_max) toFixed 2);
						[_dst, ((fuel _dst) + _amount_f)] remoteExec ['setFuel', _dst];
					} else {
						_dst setVariable ["fuel_capacity", ((_dst getVariable ["fuel_capacity", 0]) + _amount), true];
					};
					//systemChat format ["Transfer: %1 aka %2", _amount, _amount_f];
				} else {
					systemChat "Нема більше пального!";
				};
			} else {
				systemChat "Вже повний бак!";
			};
		},
		{
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
		}, "Заправляємо"
	] call ace_common_fnc_progressBar;
} else {
	systemChat "Нема більше пального!";
};
