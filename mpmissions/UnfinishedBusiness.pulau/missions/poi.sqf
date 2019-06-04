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
		
	Fn_POI_GetAllCitiesInPlayerRange = {
		params['_players'];
		//Get all POI in the range of 3000m
		private _lcs = [];
		private _poi = [];
		private _blacklist = [
			'Pulau Monyet',
			'Monyet Airfield',
			'Pulau Gurun',
			'Gurun Airfield'
		];
		{
			if (alive _x) exitWith {
				{	
					if (!(text _x in _blacklist)) then {
						_lcs pushBack [text _x, locationPosition _x];
					};
				} forEach nearestLocations [getPos _x, ["NameVillage", "NameCity", "NameCityCapital"], 3500];	
			};
		} forEach _players;
		
		//Select no more than 4 to create tasks
		private _avalible_lcs = _lcs;
		if (count _lcs <= 4) then {
			_poi = _lcs;
		} else {
			for "_i" from 0 to 3 do {
				private _lc = selectRandom _avalible_lcs;
				_avalible_lcs = _avalible_lcs - [_lc];
				_poi pushBackUnique _lc;
			};
		};
		
		[_lcs, _poi];
	};
};