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


params["_dst", "_src"];		
		
if ((fuel _src) > 0) then {
	//systemChat format ["refuel: %1 to %2", _src, _dst];		
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
			//systemChat format ["refuel DONE: %1 to %2", _src, _dst];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
			
			_fuel_max = getNumber (configfile >> "CfgVehicles" >> typeOf _src >> "ace_refuel_fuelCapacity");
			_fuel_avaliable = _fuel_max - (_fuel_max * (fuel _src));
			
			if (_fuel_avaliable > 0) then {
				_amount = 0;
				_capacity_max = 0;
				_capacity = 0;
				//FIXME: use objects as dst?
				_capacity_max = (_dst getVariable ["fuel_max_capacity", 0]);
				_capacity = _capacity_max - (_dst getVariable ["fuel_capacity", 0]);
				if (_capacity >= 10) then {
					if (_fuel_avaliable >= 10) then {
						_amount = 10;
						systemChat "Злито 10л!";
					} else {
						_amount = _fuel_avaliable;
						systemChat format ["Злито залишки ~%1л!", (round _amount)];
					};
				} else {
					if (_fuel_avaliable >= _capacity) then {
						_amount = _capacity;
						systemChat format ["Злито ~%1л. Повний бак!", (round _amount)];
					} else {
						_amount = _fuel_avaliable;
						systemChat format ["Злито залишки ~%1л!", (round _amount)];
					};
				};
				
				_dst setVariable ["fuel_capacity", ((_dst getVariable ["fuel_capacity", 0]) + _amount), true];
				_amount_f = parseNumber ((_amount / _fuel_max) toFixed 2);
				[_src, ((fuel _src) - _amount_f)] remoteExec ['setFuel', _src];
			} else {
				systemChat "Нема більше пального!";
			};
		},
		{
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
			[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
		}, "Зливаємо пальне"
	] call ace_common_fnc_progressBar;
} else {
	systemChat "Нема більше пального!";
};
