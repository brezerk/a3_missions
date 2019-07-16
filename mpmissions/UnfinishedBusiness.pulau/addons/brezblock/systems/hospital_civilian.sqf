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
	Arguments: [_marker]
	Usage: [_marker] call BrezBlock_fnc_CreateCivilianPresence;
	Return: none
*/
if (isServer) then {
	params['_marker'];
	private['_i'];
	
	private _center = getMarkerPos _marker;
	private _roads = _center nearRoads 25;
	private _good_roads = [];
			
	{
		private _pos = position _x;
		if ((count (nearestObjects [_pos, ["Car", "Truck"], 10]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 10, false, true]) == 0)) then {
			private _bbox = boundingboxReal _x;
			private _a = _bbox select 0;
			private _b = _bbox select 1;
			private _size = _a distance _b;
			if (_size >= 25) then {
				_good_roads append [_x];
			};
		};
		if (count _good_roads >= 4) exitWith {};
	} forEach _roads;
	
	private _road = selectRandom _good_roads;
	if (!isNil "_road") then {
		private _pos = position _road;
		private _dir = getDir _road;
		private _connected = roadsConnectedto (_road);
					
		if (count _connected > 0) then {
			private _connected_pos = getPos (_connected select 0);
			_dir = [_pos, _connected_pos] call BIS_fnc_DirTo;	
		};
					
		_pos = [_pos, 3, _dir + 90] call BIS_Fnc_relPos;
					
		private _vehicle = createVehicle ["CUP_O_LR_Ambulance_TKA", _pos];
		_vehicle setDir _dir;
			
		clearWeaponCargoGlobal _vehicle;
		clearMagazineCargoGlobal _vehicle;
		clearItemCargoGlobal _vehicle;
		clearBackpackCargoGlobal _vehicle;
		
		_vehicle addItemCargoGlobal ["ACE_fieldDressing", 10];
		_vehicle addItemCargoGlobal ["ACE_bloodIV", 4];
		_vehicle addItemCargoGlobal ["ACE_morphine", 2];
		_vehicle addItemCargoGlobal ["ACE_bodyBag", 10];
		_vehicle addItemCargoGlobal ["ACE_epinephrine", 2];
	};
	
	private _builing = nearestBuilding (_center);
	private _pos = selectRandom (_builing buildingPos -1);
	if (!isNil "_pos") then {
		private _obj = "ACE_medicalSupplyCrate" createVehicle (_pos);
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;

		_obj addItemCargoGlobal ["ACE_fieldDressing", 20];
		_obj addItemCargoGlobal ["ACE_bloodIV", 8];
		_obj addItemCargoGlobal ["ACE_morphine", 6];
		_obj addItemCargoGlobal ["ACE_bodyBag", 10];
		_obj addItemCargoGlobal ["ACE_epinephrine", 2];
	};	
};