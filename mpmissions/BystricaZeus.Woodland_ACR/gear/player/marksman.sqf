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
 
comment "[!] UNIT MUST BE LOCAL [!]";
if (!local _this) exitWith {};

comment "Exported from Arsenal by brezerk";

comment "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

comment "Add containers";
_this forceAddUniform "LOP_U_UKR_Fatigue_Digit";
for "_i" from 1 to 10 do {_this addItemToUniform "ACE_fieldDressing";};
for "_i" from 1 to 2 do {_this addItemToUniform "ACE_CableTie";};
_this addItemToUniform "ACE_EarPlugs";
_this addVest "LOP_V_6B23_Rifleman_TAN";
	
for "_i" from 1 to 8 do {_this addItemToVest "rhs_10Rnd_762x54mmR_7N14";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_rdg2_white";};
_this addBackpack "B_Kitbag_tan";
_this addItemToBackpack "ACE_EntrenchingTool";
for "_i" from 1 to 2 do {_this addItemToBackpack "rhs_mag_rdg2_white";};
for "_i" from 1 to 3 do {_this addItemToBackpack "rhs_mag_rgd5";};
for "_i" from 1 to 12 do {_this addItemToBackpack "rhs_10Rnd_762x54mmR_7N14";};
_this addHeadgear "LOP_H_Beanie_tan";
_this addGoggles "rhs_googles_clear";

comment "Add weapons";
_this addWeapon "rhs_weap_svdp_wd";
_this addPrimaryWeaponItem "rhs_acc_pso1m2";
_this addWeapon "rhs_weap_makarov_pm";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";

comment "Set identity";
_this setSpeaker "NoVoice";

//ACEX
_this addItemToVest "ACE_Canteen";
_this addItemToBackpack "ACE_MRE_MeatballsPasta";
for "_i" from 1 to 2 do {_this addItemToBackpack "ACE_MRE_CreamChickenSoup";};

_this setVariable ["ace_medical_medicclass", 0, true];
_this setVariable ["ACE_IsEngineer", 0, true]; 
