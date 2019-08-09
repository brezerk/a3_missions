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

//Player side triggers
// Client side code
if (hasInterface) then {};

if (isServer) then {

	/* 
		Iterate over all markers and spawn on matching the selected location
	*/
	Fn_Spawn_East_SupplyBoxes = {
		private _filter = format ["wp_%1_east_supply", D_LOCATION];
		{
			if (_x find _filter >= 0) then {
				[getMarkerPos _x] call Fn_Spawn_East_SupplyBox;
			};
		} forEach allMapMarkers;
	};

	/*
		Spawn supply box for EAST side
		//FIXME: Use sourced gear configuration map!
		
		@params Position
		
		@return SupplyBox object
	*/
	Fn_Spawn_East_SupplyBox = {
		params ['_pos'];
		private _obj = "B_supplyCrate_F" createVehicle _pos;
		
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
					
		_obj addWeaponCargoGlobal ["CUP_launch_Igla", 3];
		_obj addWeaponCargoGlobal ["CUP_launch_RPG7V", 5];
		_obj addWeaponCargoGlobal ["CUP_lmg_PKM", 5];
		_obj addWeaponCargoGlobal ["CUP_srifle_SVD", 5];
		_obj addWeaponCargoGlobal ["Laserdesignator_02", 2];

		_obj addMagazineCargoGlobal ["SmokeShell", 10];
		_obj addMagazineCargoGlobal ["SmokeShellRed", 10];
		_obj addMagazineCargoGlobal ["CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Red_M", 20];
		_obj addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK_M", 20];
		_obj addMagazineCargoGlobal ["CUP_10Rnd_762x54_SVD_M", 20];
		_obj addMagazineCargoGlobal ["CUP_PG7V_M", 8];
		_obj addMagazineCargoGlobal ["CUP_OG7_M", 10];
		_obj addMagazineCargoGlobal ["CUP_HandGrenade_RGD5", 4];
		_obj addMagazineCargoGlobal ["CUP_HandGrenade_RGO", 4];
		_obj addMagazineCargoGlobal ["CUP_MineE_M", 4];
		_obj addMagazineCargoGlobal ["APERSTripMine_Wire_Mag", 4];
		
		_obj addItemCargoGlobal ["ACE_MRE_CreamChickenSoup", 25];
		_obj addItemCargoGlobal ["ACE_MRE_MeatballsPasta", 25];
		_obj addItemCargoGlobal ["ACE_MRE_ChickenHerbDumplings", 25];
		_obj addItemCargoGlobal ["ACE_CableTie", 10];
		_obj addItemCargoGlobal ["ACE_Canteen", 4];
		_obj addItemCargoGlobal ["ACE_WaterBottle", 20];
		_obj addItemCargoGlobal ["ACE_EntrenchingTool", 4];
		_obj addItemCargoGlobal ["ACE_EarPlugs", 10];
		_obj addItemCargoGlobal ["ACE_fieldDressing", 20];
		_obj addItemCargoGlobal ["ACE_morphine", 10];
		_obj addItemCargoGlobal ["ACE_epinephrine", 6];
		_obj addItemCargoGlobal ["ACE_bloodIV", 20];
		_obj addItemCargoGlobal ["CUP_optic_PSO_1", 3];
		
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
		_obj;
	};

};