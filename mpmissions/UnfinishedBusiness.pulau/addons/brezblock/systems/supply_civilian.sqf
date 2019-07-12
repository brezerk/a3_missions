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
	
	private _radius = round ((getMarkerSize _marker select 0) / 2);
	private _center = getMarkerPos _marker;
	
	private _pos = [_center, 5, _radius, 5, 0, 0, 0] call BIS_fnc_findSafePos;
	
	private _obj = "Land_WoodenCrate_01_F" createVehicle (_pos);
		
	clearWeaponCargoGlobal _obj;
	clearMagazineCargoGlobal _obj;
	clearItemCargoGlobal _obj;
	clearBackpackCargoGlobal _obj;
	
	_obj addWeaponCargoGlobal ["ACE_Banana", 10];
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
	
	_pos = [_pos, 5, 15, 5, 0, 0, 0] call BIS_fnc_findSafePos;
	private _class = selectRandom ['Land_StallWater_F', 'Land_WaterTank_04_F', 'Land_ConcreteWell_01_F'];
	_obj = _class createVehicle (_pos);
	if (isClass(configFile >> "CfgPatches" >> "acex_field_rations")) then {
		_obj setVariable ["acex_field_rations_currentWaterSupply", 300, true];
	};
};