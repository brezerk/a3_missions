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
	Fn_West_Populate_Supply = {
		params['_obj', '_type'];
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
				
		{
			_obj addWeaponCargoGlobal [(_x select 0), (_x select 1)];
		} forEach ([west, D_FRACTION_WEST, (format ["stash_%1_weapon", _type])] call Fn_Config_GetFraction_Units);
		
		{
			_obj addMagazineCargoGlobal [(_x select 0), (_x select 1)];
		} forEach ([west, D_FRACTION_WEST, (format ["stash_%1_mags", _type])] call Fn_Config_GetFraction_Units);

		{
			_obj addItemCargoGlobal [(_x select 0), (_x select 1)];
		} forEach ([west, D_FRACTION_WEST, (format ["stash_%1_items", _type])] call Fn_Config_GetFraction_Units);
		
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
	};
};
