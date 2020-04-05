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

params ["_object", "_radius", "_damage"];

bb_threat_chem_areas pushBack [_object, D_THREAT_CHEM_LOCAL, _radius, _damage];

if (!hasInterface) exitWith {};

private _fog_obj = objNull;

while {((!isNull player) && (!isNull _object))} do  {
	waitUntil {alive player};
	private _distance = player distance _object;
	if (_distance < 300) then {
		if (isNull _fog_obj) then {
			_fog_obj = "#particlesource" createVehicleLocal (getPos _object); 
			_fog_obj setParticleCircle [10,[0.1,0.1,0]];
			_fog_obj setParticleRandom [6,[0,0,0],[1,1,0],1,1,[0,0,0,0.1],0,0];
			_fog_obj setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard",1,10,[0,0,0],[-1,-1,0],3,10.15,7.9,0.01,[10,10,10],[[0.1,0.5,0.1,0],[0.5,0.5,0.5,0.1],[1,1,1,0]], [0.08], 1, 0, "", "", _object];
			_fog_obj setDropInterval 0.01;
		};
	} else {
		if (!isNull _fog_obj) then {
			deleteVehicle _fog_obj;
			waitUntil {((player distance _object) < (_radius + 300))};
		};
	};
};
