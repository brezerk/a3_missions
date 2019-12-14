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
Search for empty roads
	Arguments:
		position: Object, PositionAGL or Position2D - where to find the roads, center position 
		range: Effective ranage
		max count: Maximal count good roads search for
		random_pos: Use random pos as a center
	Usage: [_center, _range] call BrezBlock_fnc_GetEmptyRoads;
	Return: array of roads
*/

params['_center', '_range', '_count', ['_random_pos', false]];

private _empty_roads = [];

if (_random_pos) then {
	_center = [[_center, _range], ["water"]] call BIS_fnc_randomPos;
};
			
{
	private _pos = position _x;
	if ((count (_pos nearEntities[["Car", "Truck"], 10]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 5, false, true]) == 0)) then {
		private _bbox = boundingboxReal _x;
		private _a = _bbox select 0;
		private _b = _bbox select 1;
		private _size = _a distance _b;
		if (_size >= 25) then {
			_empty_roads append [_x];
		};
	};
	if (count _empty_roads >= _count) exitWith {};
} forEach (_center nearRoads _range);

_empty_roads;
