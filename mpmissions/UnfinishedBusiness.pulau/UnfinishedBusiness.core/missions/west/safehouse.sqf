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

if (isServer) then {
	Fn_Task_West_SafeHouse_WaponStash = {
		params['_center'];
		
		private _markers = [_center, ["o_mortar", "n_mortar", "b_mortar"], 2000] call BrezBlock_fnc_GetAllMarkerTypesInRange;
		
		if (count _markers > 0) then {
			{
				private _marker = selectRandom _markers;
				_center = getMarkerPos _marker;
				avaliable_markers deleteAt (avaliable_markers find _marker);
				
				private _pos = objNull;
				
				private _builing = nearestBuilding (_center);
				
				if ((_center distance2D (getPos _builing)) >= 100) then {
					_pos = [_center, 0, 60, 4, 0, 0, 0] call BIS_fnc_findSafePos;
				} else {
					_pos = selectRandom (_builing buildingPos -1);
				};

				if (!isNil "_pos") then {
					private _mark = createMarker [format ["mrk_east_stash_0%1", _x], _pos];
					_mark setMarkerType "hd_objective";
					_mark setMarkerAlpha 0;
				
					[_pos] call Fn_Task_West_Safe_SpawnRandomCargo;

					_markers = _markers - [_marker];
					deleteMarker _marker;
				};
			} forEach ['1', '2'];
		};
	};
	
	Fn_Task_West_Safe_SpawnRandomCargo = {
		params ["_markerPos"];
			
		private _pos = [_markerPos, 0, 35, 4, 0, 0, 0] call BIS_fnc_findSafePos;
		private _obj = "B_supplyCrate_F" createVehicle (_pos);

		_obj addItemCargoGlobal ["ItemCompass", 3];
		_obj addItemCargoGlobal ["ItemMap", 3];
		
		_obj addBackpackCargoGlobal ["B_Kitbag_tan", 5];
		
		if (isClass(configFile >> "CfgPatches" >> "acex_main")) then {
			_obj addItemCargoGlobal ["ACE_Humanitarian_Ration", 10];
			_obj addItemCargoGlobal ["ACE_WaterBottle", 15];
		};
			
		_obj;
	};

};