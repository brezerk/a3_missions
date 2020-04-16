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

params['_center', '_range', '_capacity', ['_capacity_max', 1000]];

{ 
	_x setFuelCargo 0;
	[_x, (random _capacity), _capacity_max, false] call BrezBlock_fnc_Systems_Refuel_Init;
} forEach (nearestObjects [_center, ["Land_A_FuelStation_Feed", "Land_fs_feed_F", "Land_FuelStation_Feed_PMC", "Land_Ind_FuelStation_Feed_EP1", "Land_FuelStation_03_F"], _range]);
