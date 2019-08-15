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
	Fn_Task_West_Create_Supply = {
		params['_obj'];
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
				
		_obj addWeaponCargoGlobal ["ACE_VMH3", 2];

		_obj addMagazineCargoGlobal ["CUP_15Rnd_9x19_M9", 20];
		_obj addMagazineCargoGlobal ["CUP_7Rnd_45ACP_1911", 20];
		_obj addMagazineCargoGlobal ["CUP_30Rnd_556x45_Stanag", 30];
		_obj addMagazineCargoGlobal ["CUP_20Rnd_762x51_DMR", 10];
		_obj addMagazineCargoGlobal ["CUP_1Rnd_HE_M203", 10];
		_obj addMagazineCargoGlobal ["CUP_M72A6_M", 10];
		_obj addMagazineCargoGlobal ["CUP_100Rnd_TE4_Green_Tracer_556x45_M249", 10];

		_obj addItemCargoGlobal ["ACE_EntrenchingTool", 4];
		_obj addItemCargoGlobal ["ACE_EarPlugs", 10];
		_obj addItemCargoGlobal ["ACE_fieldDressing", 40];
		_obj addItemCargoGlobal ["ACE_morphine", 30];
		_obj addItemCargoGlobal ["ACE_epinephrine", 20];
		_obj addItemCargoGlobal ["ACE_bloodIV", 10];
		_obj addItemCargoGlobal ["CUP_HandGrenade_M67", 25];
		_obj addItemCargoGlobal ["ACE_DefusalKit", 10];
		_obj addItemCargoGlobal ["ClaymoreDirectionalMine_Remote_Mag", 10];
		_obj addItemCargoGlobal ["DemoCharge_Remote_Mag", 6];
			
		if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
				_obj addItemCargoGlobal ["ACRE_PRC148", 20];
				_obj addItemCargoGlobal ["ACRE_PRC343", 30];
			} else {
				if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
					_obj addItemCargoGlobal ["tf_anprc148jem", 20];
					_obj addItemCargoGlobal ["tf_anprc152", 30];
				} else {
					comment "Fallback to native arma3 radio";
					_obj addItemCargoGlobal ["ItemRadio", 10];
				};
		};
	};
};
