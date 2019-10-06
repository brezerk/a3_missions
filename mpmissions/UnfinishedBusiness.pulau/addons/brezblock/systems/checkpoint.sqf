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
	Usage: [_marker] call BrezBlock_fnc_CreateCheckpoint;
	Return: Group
*/
if (isServer) then {
	params['_marker'];
	
	private _center = getMarkerPos _marker;
	private _good_roads = [];
			
	{
		private _pos = getPosASL _x;
		if ((count (_pos nearEntities[["Car", "Truck"], 20]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 20, false, true]) == 0)) then {
			private _bbox = boundingboxReal _x;
			private _a = _bbox select 0;
			private _b = _bbox select 1;
			private _size = _a distance _b;
			if (_size >= 25) then {
				_good_roads append [_x];
			};
		};
		if (count _good_roads >= 4) exitWith {};
	} count (_center nearRoads 25);
	
	private _road = selectRandom _good_roads;
	if (!isNil "_road") then {
		private _pos = getPos _road;
		private _dir = getDir _road;
		private _connected = roadsConnectedto (_road);
					
		if (count _connected > 0) then {
			private _connected_pos = getPos (_connected select 0);
			_dir = [_pos, _connected_pos] call BIS_fnc_DirTo;	
		};
					
		private _o_pos = [_pos, 6, _dir + 90] call BIS_Fnc_relPos;
		private _vehicle = createVehicle ["Land_BagBunker_01_small_green_F", _o_pos];
		_vehicle setDir _dir;
		_o_pos = [_pos, -5, _dir + 90] call BIS_Fnc_relPos;
		_o_pos = [_o_pos, 1, _dir] call BIS_Fnc_relPos;
		_vehicle = createVehicle ["Land_HBarrier_01_line_3_green_F", _o_pos];
		_vehicle setDir _dir;
		
		if (D_MOD_ACEX) then {
			_o_pos = [_pos, 5, _dir + 90] call BIS_Fnc_relPos;
			_o_pos = [_o_pos, 7, _dir] call BIS_Fnc_relPos;
			private _obj = "Land_WoodenCrate_01_F" createVehicle (_o_pos);
				
			clearWeaponCargoGlobal _obj;
			clearMagazineCargoGlobal _obj;
			clearItemCargoGlobal _obj;
			clearBackpackCargoGlobal _obj;
		
			_obj addItemCargoGlobal ["ACE_Banana", ((random 15) + 10)];
			_obj addItemCargoGlobal ["ACE_Humanitarian_Ration", 10];
			_obj addItemCargoGlobal ["ACE_WaterBottle", 15];
		};
		
		private _side = objNull;
		
		switch (getMarkerColor _marker) do
		{
			case "ColorWEST": { _side = west; };
			case "ColorEAST": { _side = east; };
			case "ColorGUER": { _side = resistance; };
			case "ColorWEST": { _side = civilian; };
		};
		
		if (!isNil "_side") then {
			_o_pos = [_pos, -6, _dir + 90] call BIS_Fnc_relPos;
			_o_pos = [_o_pos, 7, _dir] call BIS_Fnc_relPos;
			
			private _units = [];
			switch(_side) do {
				case west: {
					
				};
				case east: {
					_units = D_FRACTION_EAST_UNITS_CARS;
				};
				case resistance: {
					_units = D_FRACTION_INDEP_UNITS_CARS;
				};
			};
			
			private _class = selectRandom _units;
			
			_vehicle = createVehicle [_class, _o_pos];
			_vehicle setDir (_dir + 180);
			private _crew = createVehicleCrew (_vehicle);
			
			[_pos, _side, 3, 50] call BrezBlock_fnc_CreateDefend;
		};
	};
};