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
	Fn_Spawn_East_Cars_Transport = {
        params ["_spawnposition", "_spawndir"];
		private _veh = objNull;
		if (count (nearestObjects [_spawnposition, ["Car", "Tank", "APC", "Boat", "Drone", "Plane", "Helicopter"], 8]) == 0) then {
			private _class = (selectRandom ([east, D_FRACTION_EAST, "cars"] call Fn_Config_GetFraction_Units));
			private _pos = _spawnposition; // findEmptyPosition [0, 6, _class];
			_veh = createVehicle [_class, _pos, [], 0];
			_veh setDir _spawndir;
			[_veh] execVM 'addons\BrezBlock.framework\triggers\despawn_transport.sqf';
		};
        _veh;
	};
	
	Fn_Spawn_East_Light_Transport = {
        params ["_spawnposition", "_spawndir"];
        private ["_pos", "_vec"];
        _vec = objNull;
        private _class = (selectRandom ([east, D_FRACTION_EAST, "light"] call Fn_Config_GetFraction_Units));
        _pos = _spawnposition findEmptyPosition [0, 6, _class];
        _vec = createVehicle [_class, _pos, [], 0];
        _vec setDir _spawndir;
        _vec;
	};
	
	Fn_Spawn_East_Ammo_Transport = {
		private _marker = "mrk_east_ammo";
        private _pos = getMarkerPos _marker;
		private _dir = markerDir _marker;
        private _veh = objNull;
        private _class = (selectRandom ([east, D_FRACTION_EAST, "transport_ammo"] call Fn_Config_GetFraction_Units));
        _veh = createVehicle [_class, _pos, [], 0];
		_veh setDir _dir;
        _veh;
	};
	
	Fn_Spawn_East_Fuel_Transport = {
		private _marker = "mrk_east_fuel";
        private _pos = getMarkerPos _marker;
		private _dir = markerDir _marker;
        private _veh = objNull;
        private _class = (selectRandom ([east, D_FRACTION_EAST, "transport_fuel"] call Fn_Config_GetFraction_Units));
        _veh = createVehicle [_class, _pos, [], 0];
		_veh setDir _dir;
        _veh;
	};
	
	Fn_Spawn_East_Truck_Transport = {
		private _marker = "mrk_east_truck";
        private _pos = getMarkerPos _marker;
		private _dir = markerDir _marker;
        private _veh = objNull;
		if (count (nearestObjects [_pos, ["Car", "Tank", "APC", "Boat", "Drone", "Plane", "Helicopter"], 8]) == 0) then {
			private _class = (selectRandom ([east, D_FRACTION_EAST, "transport"] call Fn_Config_GetFraction_Units));
			_veh = createVehicle [_class, _pos, [], 0];
			_veh setDir _dir;
		};
        _veh;
	};
	
	Fn_Spawn_East_Transport = {
		private _filter = format ["wp_%1_east_transport_spawn", D_LOCATION];
		{
			if (_x find _filter >= 0) then {
				private _marker = createMarker [format ["mrk_east_transport_%1", _forEachIndex], getMarkerPos _x];
				_marker setMarkerType "hd_destroy";
				_marker setMarkerAlpha 0;
				[(getMarkerPos _marker), (markerDir _marker)] call Fn_Spawn_East_Cars_Transport;
			};
		} forEach allMapMarkers;
		private _filter = format ["wp_%1_east_apc_spawn", D_LOCATION];
		{
			if (_x find _filter >= 0) then {
				[(getMarkerPos _x), (markerDir _x)] call Fn_Spawn_East_Light_Transport;
			};
		} forEach allMapMarkers;
		call Fn_Spawn_East_Truck_Transport;
		call Fn_Spawn_East_Ammo_Transport;
		call Fn_Spawn_East_Fuel_Transport;
	};
};