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
Paradrop
	Arguments: [vehicle, group]
	Usage: [{Vehicle}],[{Group}] execVM ["addons/brezblock/systems/paradrop.sqf"];
	Return: true
*/

_veh = _this select 0;
_grp = _this select 1;

{
unassignVehicle _x;
_x action ["EJECT", _veh];
sleep 0.5;
} forEach (units _grp);

{
_x action ["openParachute", _x];
sleep 0.5;
} forEach (units _grp);

true
