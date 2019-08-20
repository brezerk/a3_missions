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
		
		private _markers = [_center, ["o_mortar", "b_mortar"], 3000] call BrezBlock_fnc_GetAllMarkerTypesInRange;
		
		for "_i" from 1 to (count _markers / 2) do {
			private _marker = selectRandom _markers;
			_center = getMarkerPos _marker;
			
			private _pos = objNull;
			
			private _builing = nearestBuilding (_center);
			
			
			if ((_center distance2D (getPos _builing)) >= 100) then {
				_pos = [_center, 0, 60, 4, 0, 0, 0] call BIS_fnc_findSafePos;
			} else {
				_pos = selectRandom (_builing buildingPos -1);
				 private _exit_pos = (_builing buildingExit 0); 
				 private _mine = createMine ["APERSTripMine", [_exit_pos select 0, _exit_pos select 1, 0], [], 0];  
				 _mine setDir (random 360);
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
	};
	
	//APERSTripMine
	Fn_Task_West_Hidden_SpawnRandomCargo = {
		params ["_pos"];
		private ["_obj"];
		
		private _class = selectRandom ['Box_NATO_Ammo_F', 'Box_EAF_Ammo_F', 'Box_IND_Ammo_F', 'Box_East_Ammo_F', 'Box_T_East_Ammo_F'];
		
		_obj = _class createVehicle (_pos);
		
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		
		for "_i" from 1 to random(5) + 1 do {
			private _class = selectRandom D_SMUGGLER_STASH_WEAPON_CONFIG;
			_obj addWeaponCargoGlobal [_class select 0, _class select 1];
			{
				_obj addMagazineCargoGlobal [_x, (((random (_class select 3)) * (_class select 1)) + 3)];
			} forEach (_class select 2);
		};
		
		_obj addItemCargoGlobal ["ACE_EarPlugs", 10];
		_obj addItemCargoGlobal ["ItemCompass", 4];
		_obj addItemCargoGlobal ["ACE_EntrenchingTool", 4];
		_obj addItemCargoGlobal ["ACE_fieldDressing", 20];
		_obj addItemCargoGlobal ["ACE_morphine", 10];
		_obj addItemCargoGlobal ["ACE_epinephrine", 6];
		_obj addItemCargoGlobal ["ACE_bloodIV",5];
		_obj addItemCargoGlobal ["DemoCharge_Remote_Mag", 4];
		
		for "_i" from 1 to random(2) + 1 do {
			private _class = selectRandom D_SMUGGLER_STASH_ITEM_CONFIG;
			_obj addItemCargoGlobal [_class select 0, (random (_class select 1) + 1)];
		};
		
		for "_i" from 1 to random(1) + 1 do {
			private _class = selectRandom D_SMUGGLER_STASH_BACKPACK_CONFIG;
			_obj addBackpackCargoGlobal [_class select 0, (random (_class select 1) + 1)];
		};
			
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
	    private _o_pos = [];   
	    _o_pos = [_pos, 2, _dir] call BIS_Fnc_relPos;   
	    _obj = createMine ["APERSTripMine", _o_pos, [], 0];   
	    _o_pos = [_pos, -2, _dir] call BIS_Fnc_relPos;   
	    _obj = createMine ["APERSTripMine", _o_pos, [], 0];  
	    _o_pos = [_pos, -2, _dir + 90] call BIS_Fnc_relPos;   
	    _obj = createMine ["APERSTripMine", _o_pos, [], 0];  
	    _obj setDir (_dir + 90);  
	    _o_pos = [_pos, 2, _dir + 90] call BIS_Fnc_relPos;   
	    _obj = createMine ["APERSTripMine", _o_pos, [], 0];  
	    _obj setDir (_dir + 90);

	};

};