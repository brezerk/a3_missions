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
 
 if (isServer) then {
	params ["_center", "_distance", "_chance"];
	
	{
		if ((random 100) <= _chance) then {
			private _building = _x;
			for "_i" from 1 to random(3) do {
				private _positions = _building buildingPos -1;
				if (count _positions > 0) then {
					private _pos = selectRandom (_positions);
					if (!isNil "_pos") then {
						(selectRandom D_HOUSE_ITEMS) createVehicle _pos; //[(_pos select 0), (_pos select 1), ((_pos select 2) + 1)];
					};
				};
			};
		};
	} forEach (_center nearObjects ["House" , _distance]);
};