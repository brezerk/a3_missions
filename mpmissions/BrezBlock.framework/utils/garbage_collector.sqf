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

params [["_ttl", 300], ["_collectionRadius", 150]];

while {true} do {
	{
		private _corpse = _x;
		private _timeStamp = (_x getVariable ["BB_CorpseTTL", 0]);
		if (_timeStamp == 0) then {
			_corpse setVariable ["BB_CorpseTTL", time];
		} else {
			if (_timeStamp != -1) then {
				if ((time - _timeStamp) > _ttl) then {
					//Ravage handler
					if (_corpse isKindOf "zombie") then {
						deleteVehicle _corpse;
					} else {
						if ({_x distance2d _corpse < _collectionRadius} count allPlayers == 0) then {
							deleteVehicle _corpse;
						} else {
							_corpse setVariable ["BB_CorpseTTL", time];
						};
					};
				};
			};
		};
	} forEach allDead;
	sleep 10;
};

