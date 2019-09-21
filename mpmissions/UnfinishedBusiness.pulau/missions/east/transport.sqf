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
Spawn start objectives, triggers for informator contact
*/

//Player side triggers
// Client side code
if (hasInterface) then {};

if (isServer) then {
	Fn_Spawn_East_Light_Transport = {
        params ["_spawnposition"];
        private ["_pos", "_vec"];
        _vec = objNull;
        private _class = (selectRandom ([east, D_FRACTION_EAST, "cars"] call Fn_Config_GetFraction_Units));
        _pos = getMarkerPos _spawnposition findEmptyPosition [0, 15, _class];
        _vec = createVehicle [_class, _pos, [], 0];
        _vec setDir (markerDir _spawnposition);
        _vec;
	};
	
	Fn_Spawn_East_Transport = {
		private _filter = format ["wp_%1_east_transport_spawn", D_LOCATION];
		{
			if (_x find _filter >= 0) then {
				private _marker = createMarker [format ["mrk_east_transport_%1", _forEachIndex], getMarkerPos _x];
				_marker setMarkerType "hd_destroy";
				_marker setMarkerAlpha 0;
				[Fn_Spawn_East_Light_Transport, _marker, 20, 10] execVM 'addons\brezblock\triggers\respawn_transport.sqf';
			};
		} forEach allMapMarkers;
	};
};