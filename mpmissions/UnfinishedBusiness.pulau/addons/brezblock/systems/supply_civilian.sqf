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
	
	private _radius = (getMarkerSize _marker select 0);
	private _center = getMarkerPos _marker;
	private _roads = _center nearRoads 25;
	private _good_roads = [];
			
	{
		private _pos = position _x;
		if ((count (nearestObjects [_pos, ["Car", "Truck"], 10]) == 0) and (count (nearestTerrainObjects [_pos, ["TREE", "BUILDING", "HOUSE", "FENCE", "WALL", "ROCK", "ROCKS"], 10, false, true]) == 0)) then {
			_good_roads append [_x];
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
		
		private _rel_pos = [_pos, 3, _dir + 90] call BIS_Fnc_relPos;
		private _obj = "Land_WoodenCrate_01_F" createVehicle (_rel_pos);
		
			
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		
		if (isClass(configFile >> "CfgPatches" >> "acex_main")) then {
			_obj addWeaponCargoGlobal ["ACE_Banana", (random 5)];
			_obj addWeaponCargoGlobal ["ACE_SpraypaintBlue", 2];
			_obj addWeaponCargoGlobal ["ACE_Can_Franta", 2];
			_obj addWeaponCargoGlobal ["ACE_Can_RedGull", 4];
			_obj addWeaponCargoGlobal ["ACE_Can_Spirit", 2];
			_obj addWeaponCargoGlobal ["ACE_Humanitarian_Ration", 10];
			_obj addWeaponCargoGlobal ["ACE_MRE_MeatballsPasta", 2];
			_obj addWeaponCargoGlobal ["ACE_MRE_LambCurry", 6];
			_obj addWeaponCargoGlobal ["ACE_MRE_SteakVegetables", 1];
			_obj addWeaponCargoGlobal ["ACE_MRE_CreamTomatoSoup", 2];
			_obj addWeaponCargoGlobal ["ACE_MRE_CreamChickenSoup", 6];
			_obj addWeaponCargoGlobal ["ACE_MRE_ChickenHerbDumplings", 3];
			_obj addWeaponCargoGlobal ["ACE_MRE_ChickenTikkaMasala", 5];
			_obj addWeaponCargoGlobal ["ACE_MRE_BeefStew", 5];
			_obj addWeaponCargoGlobal ["ACE_rope15", 2];
			_obj addWeaponCargoGlobal ["ACE_WaterBottle", 15];
		};
		
		private _rel_pos = [_pos, 3, _dir - 90] call BIS_Fnc_relPos;
		private _class = selectRandom ['Land_StallWater_F', 'Land_WaterTank_04_F', 'Land_ConcreteWell_01_F'];
		_obj = _class createVehicle (_rel_pos);
		if (isClass(configFile >> "CfgPatches" >> "acex_field_rations")) then {
			_obj setVariable ["acex_field_rations_currentWaterSupply", 300, true];
		};
	};
};