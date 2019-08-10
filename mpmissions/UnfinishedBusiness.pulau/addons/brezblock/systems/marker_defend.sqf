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
Create CBA defend
	Arguments: [_marker]
	Usage: [_marker] call BrezBlock_fnc_MarkerCreateDefend;
	Return: Group
*/
if (isServer) then {
	params['_marker'];
	private['_side'];
	private _grp = grpNull;
	private _radius = getMarkerSize _marker select 0;
	private _center = getMarkerPos _marker;

	private _count =  parseNumber (markerText _marker);
	
	if (_count <= 0) then {
		_count = 3 + (D_DIFFICLTY / 2);
	};
	
	//https://community.bistudio.com/wiki/Arma_3_CfgMarkerColors
	switch (getMarkerColor _marker) do
	{
		case "ColorWEST": { _side = west; };
		case "ColorEAST": { _side = east; };
		case "ColorGUER": { _side = resistance; };
		case "ColorCIV": { _side = civilian; };
		default { _side = sideUnknown; };
	};
	
	if (_side != sideUnknown) then {
		_grp = [_center, _side, _count, _radius] call BrezBlock_fnc_CreateDefend;
	} else {
		systemChat format ["Error: Can't get side from %1", _marker];
	};
	
	_grp;
};