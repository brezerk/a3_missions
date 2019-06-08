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
Get random index
	Arguments: [prefix, max, min]
	Usage: [{SomeStringPrefix}],[{MaximumIndex},{MinimumIndex}] call BrezBlock_fnc_Get_RND_Index
	Return: String composition using prefix and random index (in range from min to max) concated
*/
params ["_prefix", "_max", ["_min", 1]];
private ["_rnd"];

_rnd = [_min, _max] call BIS_fnc_randomInt;
if (_rnd < 10) then {
	format ["%1_0%2", _prefix, _rnd];
} else {
	format ["%1_%2", _prefix, _rnd];
};
