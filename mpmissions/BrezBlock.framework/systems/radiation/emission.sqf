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

if (!hasInterface) exitWith {};

while {((!isNull player) && (!isNull _object))} do  {
	waitUntil {alive player};
	private _distance = player distance _object;
	if (_distance < (_radius + 5)) then {
		bb_player_threat_rad = 1.2;
		if (_distance < (_radius)) then {
			bb_player_threat_rad = parseNumber ((_distance/(_radius)) toFixed 1);
			player setDammage (getDammage player + (((_radius - _distance) / _distance) * _damage));
			if (getDammage player > 0.25) then  {
				_efect = ["NoSound","NoSound","NoSound","cough","NoSound","NoSound","NoSound","NoSound","tuse_5","NoSound","NoSound","NoSound","NoSound","tuse_6","NoSound","NoSound","NoSound","NoSound"] call BIS_fnc_selectRandom;
				playsound _efect;
				playsound "puls_1";
				sleep 0.5;
			};
		};
	} else {
		bb_player_threat_rad = 0;
	};
	sleep 0.1;
};

//Mask_M40