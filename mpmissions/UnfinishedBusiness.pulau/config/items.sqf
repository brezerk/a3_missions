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
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
	call compile preprocessFileLineNumbers "defines\ace.h";
	if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
		#define D_MOD_ACE_MEDICAL true
		call compile preprocessFileLineNumbers "defines\ace_medical.h";
	};
};
if (isClass(configFile >> "CfgPatches" >> "acex_main")) then {
	call compile preprocessFileLineNumbers "defines\acex.h";
	#define D_MOD_ACEX true
};

//fixme check cup (no idea if it iworking or not :D
if (isClass(configFile >> "CfgPatches" >> "cup_main")) then {
	call compile preprocessFileLineNumbers "defines\cup.h";
	#define D_MOD_CUP true
	if (isClass(configFile >> "CfgPatches" >> "cup_weapons")) then {
		#define D_MOD_CUP_WEAPONS true
	};
	if (isClass(configFile >> "CfgPatches" >> "cup_vehicles")) then {
		#define D_MOD_CUP_VEHICLES true
	};
};*/ 

D_HOUSE_ITEMS = [
	'Binocular',
	'ItemCompass',
	'ItemMap',
	'ItemWatch',
	'ItemRadio',
	'ItemGPS',
	'B_Kitbag_cbr',
	'B_Kitbag_rgr',
	'B_Kitbag_sgg',
	'B_Kitbag_tan',
	'B_FieldPack_cbr',
	'B_FieldPack_ocamo',
	'B_FieldPack_oucamo',
	'B_Carryall_cbr',
	'B_Carryall_mcamo',
	'B_TacticalPack_blk'
];

if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
	D_HOUSE_ITEMS = D_HOUSE_ITEMS + [
		'ACE_EarPlugs',
		'ACE_rope15',
		'ACE_EntrenchingTool',
		'ACE_DefusalKit',
		'ACE_SpraypaintBlue'
	];
	if (isClass(configFile >> "CfgPatches" >> "acex_main")) then {
		D_HOUSE_ITEMS = D_HOUSE_ITEMS + [
			'ACE_Banana',
			'ACE_Can_Franta',
			'ACE_Can_RedGull',
			'ACE_Can_Spirit',
			'ACE_Humanitarian_Ration',
			'ACE_MRE_MeatballsPasta',
			'ACE_MRE_LambCurry',
			'ACE_MRE_SteakVegetables',
			'ACE_MRE_CreamTomatoSoup',
			'ACE_MRE_CreamChickenSoup',
			'ACE_MRE_ChickenHerbDumplings',
			'ACE_MRE_ChickenTikkaMasala',
			'ACE_MRE_BeefStew',
			'ACE_WaterBottle'
		];
	};
};

if (isClass(configFile >> "CfgPatches" >> "cup_main")) then {
	D_HOUSE_ITEMS = D_HOUSE_ITEMS + [
		'CUP_B_Predator_MTP'
	];
};
