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
		
		private _markers = [_center, ["o_mortar", "n_mortar", "b_mortar"], 3000] call BrezBlock_fnc_GetAllMarkerTypesInRange;
		
		{
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
				private _mark = createMarker [format ["east_stash_0%1", _x], _pos];
				_mark setMarkerType "hd_objective";
				_mark setMarkerText format ['Emergency spot %1', _x];
				_mark setMarkerColor "ColorWEST";
			
				[_pos] call Fn_Task_West_Safe_SpawnRandomCargo;

				_markers = _markers - [_marker];
				deleteMarker _marker;
			};
		} forEach ['A', 'B'];
	};
	
	Fn_Task_West_Safe_SpawnRandomCargo = {
		params ["_markerPos"];
			
		private _pos = [_markerPos, 0, 35, 4, 0, 0, 0] call BIS_fnc_findSafePos;
		private _obj = "B_supplyCrate_F" createVehicle (_pos);
			
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
				
		_obj addWeaponCargoGlobal ["CUP_hgun_M9", 2];
		_obj addWeaponCargoGlobal ["Binocular", 3];
		_obj addWeaponCargoGlobal ["CUP_arifle_M4A1", 2];
		_obj addWeaponCargoGlobal ["CUP_arifle_M4A1_GL_carryhandle", 2];
		_obj addWeaponCargoGlobal ["CUP_arifle_M16A4_Base", 2];
		_obj addWeaponCargoGlobal ["CUP_launch_M72A6", 2];	
		_obj addWeaponCargoGlobal ["ACE_VMH3", 2];

		_obj addMagazineCargoGlobal ["CUP_15Rnd_9x19_M9", 10];
		_obj addMagazineCargoGlobal ["CUP_7Rnd_45ACP_1911", 10];
		_obj addMagazineCargoGlobal ["CUP_30Rnd_556x45_Stanag", 16];
		_obj addMagazineCargoGlobal ["CUP_20Rnd_762x51_DMR", 8];
		_obj addMagazineCargoGlobal ["CUP_1Rnd_HE_M203", 10];
		_obj addMagazineCargoGlobal ["CUP_M72A6_M", 4];
		_obj addMagazineCargoGlobal ["CUP_100Rnd_TE4_Green_Tracer_556x45_M249", 4];

		_obj addItemCargoGlobal ["ACE_EntrenchingTool", 4];
		_obj addItemCargoGlobal ["ACE_EarPlugs", 10];
		_obj addItemCargoGlobal ["ItemCompass", 4];
		_obj addItemCargoGlobal ["ACE_fieldDressing", 20];
		_obj addItemCargoGlobal ["ACE_morphine", 10];
		_obj addItemCargoGlobal ["ACE_epinephrine", 6];
		_obj addItemCargoGlobal ["ACE_bloodIV", 3];
		_obj addItemCargoGlobal ["CUP_HandGrenade_M67", 10];
		_obj addItemCargoGlobal ["CUP_H_USMC_LWH_WDL", 10];
		_obj addItemCargoGlobal ["ACE_DefusalKit", 4];
		_obj addItemCargoGlobal ["ClaymoreDirectionalMine_Remote_Mag", 6];
		_obj addItemCargoGlobal ["DemoCharge_Remote_Mag", 4];
		_obj addItemCargoGlobal ["ACE_Humanitarian_Ration", 10];
		_obj addItemCargoGlobal ["ACE_WaterBottle", 15];
			
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
					_obj addItemCargoGlobal ["ItemRadio", 10];
				};
		};
		
		private _group = [_pos, WEST, 3] call BIS_fnc_spawnGroup;
		_group deleteGroupWhenEmpty true;
		
		{
			[_x] execVM "gear\west_dead.sqf";
			_x setDamage 1;
		} forEach units _group;
		
		_obj;
	};

};