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

	/*
	Fn_Task_West_Hidden_WaponStash = {
		private _markers = [];
		{
			if ((markerType _x) in ["o_mortar", "b_mortar"]) then {
				_markers append [_x];
			};
		} forEach avaliable_markers;
		
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
				[_pos] call Fn_Task_West_Hidden_SpawnRandomCargo;
				_markers = _markers - [_marker];
				deleteMarker _marker;
				avaliable_markers deleteAt (avaliable_markers find _marker);
			};
		}
	};
	
	//APERSTripMine
	Fn_Task_West_Hidden_SpawnRandomCargo = {
		params ["_pos"];
		private ["_obj"];
		
		private _allPistols        = "getNumber (_x >> 'scope') isEqualTo 2 && { getNumber(_x >> 'type') isEqualTo 2 }" configClasses(configfile >> "CfgWeapons") apply { configName _x };
		private _allPrimaryWeapons = "getNumber (_x >> 'scope') isEqualTo 2 && { getNumber(_x >> 'type') isEqualTo 1 }" configClasses(configFile >> "CfgWeapons") apply { configName _x };
		private _allLaunchers      = "getNumber (_x >> 'scope') isEqualTo 2 && { getNumber(_x >> 'type') isEqualTo 4 }" configClasses(configFile >> "CfgWeapons") apply { configName _x };

		private _class = selectRandom ['Box_NATO_Ammo_F', 'Box_EAF_Ammo_F', 'Box_IND_Ammo_F', 'Box_East_Ammo_F', 'Box_T_East_Ammo_F'];
		
		private _obj = _class createVehicle [0,0,0];
		_obj setPos _pos;
		
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
		if (D_MOD_ACEX) then {
			_obj addItemCargoGlobal ["ACE_Humanitarian_Ration", 10];
			_obj addItemCargoGlobal ["ACE_WaterBottle", 15];
		};
		
		for "_i" from 0 to 3 do {
			private _class = selectRandom _allPistols;
			_obj addWeaponCargoGlobal [_class, 1];
			_magazines = getArray (configFile >> "cfgWeapons" >> _class >> "magazines");
			{
				_obj addMagazineCargoGlobal [_x, random(15)];
			} forEach _magazines;
		};
		
		for "_i" from 0 to 5 do {
			private _class = selectRandom _allPrimaryWeapons;
			_obj addWeaponCargoGlobal [_class, 1];
			_magazines = getArray (configFile >> "cfgWeapons" >> _class >> "magazines");
			{
				_obj addMagazineCargoGlobal [_x, random(20)];
			} forEach _magazines;
		};
		
		for "_i" from 0 to 2 do {
			private _class = selectRandom _allLaunchers;
			_obj addWeaponCargoGlobal [_class, 1];
			_magazines = getArray (configFile >> "cfgWeapons" >> _class >> "magazines");
			{
				_obj addMagazineCargoGlobal [_x, random(4)];
			} forEach _magazines;
		};
			
		_obj addWeaponCargoGlobal ["Binocular", 3];
		
		if (D_MOD_ACE) then {
			_obj addWeaponCargoGlobal ["ACE_VMH3", 2];
			_obj addItemCargoGlobal ["ACE_EntrenchingTool", 4];
			_obj addItemCargoGlobal ["ACE_EarPlugs", 10];
			_obj addItemCargoGlobal ["ACE_DefusalKit", 5];
		} else {
			_obj addItemCargoGlobal ["MineDetector", 5];
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
	*/

};