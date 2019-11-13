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
Spawn start objectives, triggers for informator contact
*/

while {true} do {
	{
		private _timeStamp = _x getVariable "BB_CorpseTTL";
		if (isNil "_timeStamp") then 
		{
			_x setVariable ["BB_CorpseTTL", time];
		} else {
			private _playerNearby = false;
			if (_timeStamp != -1) then {
				if ((time - _timeStamp) > 300) then {
					{
						scopeName "units_loop";
						//player found withing 150m
						if (isPlayer _x) then {
							_playerNearby = true;
							breakOut "units_loop";
						};
					} forEach nearestObjects [_x, ["SoldierEB", "SoldierGB", "SoldierWB"], 250];
					if (!_playerNearby) then {
						deleteVehicle _x;
					} else {
						_x setVariable ["BB_CorpseTTL", time];
					};
				};
			};
		};
	} forEach allDead;
	sleep 10;
};