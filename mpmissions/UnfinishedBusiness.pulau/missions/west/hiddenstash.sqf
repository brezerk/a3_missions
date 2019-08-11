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
	Fn_Task_West_Hidden_WaponStash = {
		params['_center'];
		
		private _markers = [_center, ["o_mortar", "n_mortar", "b_mortar"], 3000] call BrezBlock_fnc_GetAllMarkerTypesInRange;
		
		for "_i" from 1 to (count _markers / 2) do {
			private _marker = selectRandom _markers;
			_center = getMarkerPos _marker;
			
			private _pos = objNull;
			
			private _builing = nearestBuilding (_center);
			
			
			if ((_center distance2D (getPos _builing)) >= 100) then {
				_pos = [_center, 0, 60, 4, 0, 0, 0] call BIS_fnc_findSafePos;
			} else {
				_pos = selectRandom (_builing buildingPos -1);
			};

			if (!isNil "_pos") then {
				private _mark = createMarker [format ["east_stash_0%1", _i], _pos];
				_mark setMarkerType "hd_destroy";
				_mark setMarkerAlpha 0;
			
				[_pos] call Fn_Task_West_Hidden_SpawnRandomCargo;
			
				_markers = _markers - [_marker];
				deleteMarker _marker;
			};
		}
		
		
		/*
		[[
			synd_boat_01,
			synd_boat_02
		]] call Fn_Patrols_Create_Random_SeaWaypoints;*/
		
		//locationFloodedShip = _markerPos;
		//publicVariable "locationFloodedShip";
		
		//call Fn_Task_Spawn_Boats;
	};
	
	//APERSTripMine
	Fn_Task_West_Hidden_SpawnRandomCargo = {
		params ["_pos"];
		private ["_obj"];
		
		private _class = selectRandom ['B_supplyCrate_F', 'Land_WoodenCrate_01_F', 'O_CargoNet_01_ammo_F', 'I_CargoNet_01_ammo_F'];
		
		_obj = _class createVehicle (_pos);
		

		
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
			
		_obj addWeaponCargoGlobal ["CUP_hgun_M9", 7];
		_obj addWeaponCargoGlobal ["Binocular", 3];
		_obj addWeaponCargoGlobal ["CUP_arifle_AK74", 5];
		_obj addWeaponCargoGlobal ["CUP_arifle_AKS74U", 7];
		_obj addWeaponCargoGlobal ["CUP_sgun_M1014", 25];
		_obj addMagazineCargoGlobal ["CUP_15Rnd_9x19_M9", 25];
		_obj addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK_M", 11];
		_obj addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK74_plum_M", 15];
		_obj addMagazineCargoGlobal ["CUP_8Rnd_B_Beneli_74Slug", 25];
		_obj addMagazineCargoGlobal ["CUP_8Rnd_B_Beneli_74Pellets", 25];
		_obj addItemCargoGlobal ["ACE_EarPlugs", 10];
		_obj addItemCargoGlobal ["ItemCompass", 4];
		_obj addItemCargoGlobal ["ACE_EntrenchingTool", 4];
		_obj addItemCargoGlobal ["ACE_fieldDressing", 20];
		_obj addItemCargoGlobal ["ACE_morphine", 10];
		_obj addItemCargoGlobal ["ACE_epinephrine", 6];
		_obj addItemCargoGlobal ["ACE_bloodIV", 20];
		_obj addBackpackCargoGlobal ["B_Kitbag_tan", 5];
			
		if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
				_obj addItemCargoGlobal ["ACRE_PRC148", 2];
				_obj addItemCargoGlobal ["ACRE_PRC343", 6];
			} else {
				if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
					_obj addItemCargoGlobal ["tf_anprc148jem", 2];
					_obj addItemCargoGlobal ["tf_anprc152", 6];
				} else {
					comment "Fallback to native arma3 radio";
					_obj addItemCargoGlobal ["ItemRadio", 6];
				};
		};
		
		private _dir = getDir _obj;
		private _o_pos = [_pos, 2, _dir] call BIS_Fnc_relPos;
		_obj = "APERSTripMine" createVehicle (_o_pos);
		_o_pos = [_pos, -2, _dir] call BIS_Fnc_relPos;
		_obj = "APERSTripMine" createVehicle (_o_pos);
		

	};

};