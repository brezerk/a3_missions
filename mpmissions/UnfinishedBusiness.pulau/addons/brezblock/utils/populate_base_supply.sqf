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
Populate base items for supply box
*/

params['_obj', '_type', '_side', '_faction'];
clearWeaponCargoGlobal _obj;
clearMagazineCargoGlobal _obj;
clearItemCargoGlobal _obj;
clearBackpackCargoGlobal _obj;

{
	private _class = (_x select 0);
	private _count = (_x select 1);
	private _type = _class call BIS_fnc_itemType;
		switch (_type select 0) do {
			case 'Weapon': { 
				_obj addWeaponCargoGlobal [_class, _count];
			};
			case 'Magazine': {
				_obj addMagazineCargoGlobal [_class, _count];
			};
			case 'Item': { _obj addItemCargoGlobal [_class, _count]; };
			case 'Mine': { _obj addItemCargoGlobal [_class, _count]; };
			case 'Equipment': { 
				if ((_type select 1) == "Backpack") then {
					_obj addBackpackCargoGlobal [_class, _count];	
				} else {
					_obj addItemCargoGlobal [_class, _count];									
				};
			};
			default { systemChat format ["Error: can't get item type: %1", _class]; };
		};	
} forEach ([_side, _faction, (format ["stash_%1_items", _type])] call Fn_Config_GetFraction_Units);
		
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
	_obj addWeaponCargoGlobal ["ACE_VMH3", 2];
	_obj addItemCargoGlobal ["ACE_EntrenchingTool", 4];
	_obj addItemCargoGlobal ["ACE_EarPlugs", 10];
	_obj addItemCargoGlobal ["ACE_DefusalKit", 5];
} else {
	_obj addItemCargoGlobal ["MineDetector", 5];
};
		
if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
	_obj addItemCargoGlobal ["ACE_fieldDressing", 25];
	_obj addItemCargoGlobal ["ACE_morphine", 10];
	_obj addItemCargoGlobal ["ACE_epinephrine", 5];
	_obj addItemCargoGlobal ["ACE_bloodIV", 6];
} else {
	_obj addItemCargoGlobal ["FirstAidKit", 25];
};
		
_obj addItemCargoGlobal ["ClaymoreDirectionalMine_Remote_Mag", 6];
_obj addItemCargoGlobal ["DemoCharge_Remote_Mag", 4];
			
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
		_obj addItemCargoGlobal ["ACRE_PRC148", 4];
		_obj addItemCargoGlobal ["ACRE_PRC343", 10];
} else {
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		_obj addItemCargoGlobal ["tf_anprc148jem", 4];
		_obj addItemCargoGlobal ["tf_anprc152", 10];
	} else {
		_obj addItemCargoGlobal ["ItemRadio", 10];
	};
};
