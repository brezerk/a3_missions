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
 
// UNIT MUST BE LOCAL
if (!local _this) exitWith {};

// Remove existing items
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

//Uniform
_this forceAddUniform "LOP_U_UKR_Fatigue_Digit";
_this addItemToUniform "ACE_CableTie";
for "_i" from 1 to 10 do {_this addItemToUniform "ACE_morphine";};
_this addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 20 do {_this addItemToUniform "ACE_fieldDressing";};
_this addItemToUniform "ACE_DefusalKit";
_this addItemToUniform "ACE_Canteen";

//Vest
_this addVest "LOP_V_6B23_Rifleman_TAN";
	
comment "Give player a radio depending on radio mod loaded";
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
	_this addItemToVest "ACRE_SEM52SL";
} else {
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		_this linkItem "tf_anprc152";
	} else {
		comment "Fallback to native arma3 radio";
		_this linkItem "ItemRadio";
	};
};
	
for "_i" from 1 to 2 do {_this addItemToVest "rhs_30Rnd_545x39_7N6_AK";};
for "_i" from 1 to 6 do {_this addItemToVest "rhs_VOG25";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_rgd5";};

//Backpack
_this addBackpack "B_Kitbag_tan";
for "_i" from 1 to 2 do {_this addItemToBackpack "ACE_bloodIV";};
for "_i" from 1 to 10 do {_this addItemToBackpack "ACE_fieldDressing";};
for "_i" from 1 to 10 do {_this addItemToBackpack "ACE_morphine";};
_this addItemToBackpack "ACE_personalAidKit";
for "_i" from 1 to 8 do {_this addItemToBackpack "rhs_VOG25";};
for "_i" from 1 to 6 do {_this addItemToBackpack "rhs_30Rnd_545x39_7N6_AK";};
for "_i" from 1 to 6 do {_this addItemToBackpack "rhs_30Rnd_545x39_7N6M_AK";};
for "_i" from 1 to 2 do {_this addItemToBackpack "rhs_mag_rdg2_white";};
_this addItemToBackpack "ACE_EntrenchingTool";
for "_i" from 1 to 2 do {_this addItemToBackpack "ClaymoreDirectionalMine_Remote_Mag";};

//Headgear and Googles
_this addHeadgear "LOP_H_6B27M_Digit";
_this addGoggles "rhs_googles_clear";

//Add weapons
_this addWeapon "rhs_weap_ak74_gp25";
_this addPrimaryWeaponItem "rhs_acc_dtk";

//Add items
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";

//Set identity
_this setFace "Default";
_this setSpeaker "NoVoice";

//ACEX
_this addItemToBackpack "ACE_MRE_MeatballsPasta";
for "_i" from 1 to 2 do {_this addItemToBackpack "ACE_MRE_CreamChickenSoup";};
