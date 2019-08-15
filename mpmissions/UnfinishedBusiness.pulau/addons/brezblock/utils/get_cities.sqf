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
Create civilian presence module
	Arguments: [_pos, _range]
	Usage: [_pos, _range] call BrezBlock_fnc_GetAllCitiesInRange;
	Return: none
*/

if (isServer) then { 
		
	params['_pos', '_range', '_cap'];
	//Get all POI in the range of 3000m
	private _lcs = [];
	private _poi = [];
	private _blacklist = [];
	//Fixme could be an argument, but who cares?
	switch(D_LOCATION) do
	{
		case "Gurun": {
			_blacklist = [
				'Monyet Airfield',
				'Gurun airfield',
				'Pulau Gurun',
				'Pulau Monyet',
				'Mabau',
				'Ahiolo',
				'Selamat',
				'Boano',
				'Moko',
				'Lepar',
				'Seliu',
				'Liat',
				'Pasowe',
				'Mandomai',
				'Keras',
				'Tabako',
				'Laora',
				'Larete',
				'Tanjung',
				'Nirwana',
				'Jaya',
				'Tinobu',
				'Kolaka',
				'Nurul'
			];
		};
		case "Monyet": {
			_blacklist = [
				'Monyet Airfield',
				'Gurun airfield',
				'Pulau Gurun',
				'Pulau Monyet',
				'Mandomai',
				'Mabau',
				'Ahiolo',
				'Selamat',
				'Boano',
				'Liat',
				'Pasowe',
				'Seliu',
				'Moko',
				'Lepar',
				'Balalon',
				'Bibung',
				'Loholoho',
				'Kinandal',
				'Kambani',
				'Minanga',
				'Monse',
				'Lalomo',
				'Apal'
			];
		};
		case "Stratis": {
			_blacklist = [
				'Stratis Air Base',
				'Camp Maxvell',
				'Tusoukalia',
				'LZ Baldy',
				'Pythos',
				'Xiros',
				'The Spartan',
				'Air Station Mike-26',
				'Camp Rogain'
			];
		
		};
	};

	{	
		if (!(text _x in _blacklist)) then {
			_lcs pushBack [text _x, locationPosition _x];
		};
	} forEach nearestLocations [_pos, ["NameVillage", "NameCity", "NameCityCapital"], _range];
		
	//Select no more than 4 to create tasks
	private _avalible_lcs = _lcs;
	for "_i" from 1 to _cap do {
		private _lc = selectRandom _avalible_lcs;
		if (isNil "_lc") exitWith {};
		_avalible_lcs = _avalible_lcs - [_lc];
		_poi pushBackUnique _lc;
	};
		
	[_lcs, _poi];

};