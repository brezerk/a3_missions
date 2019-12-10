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
 
//UNIT MUST BE LOCAL
if (!local _this) exitWith {};

//Remove existing items
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

//Add weapons
_this addWeapon "rhs_weap_ak74";
_this addPrimaryWeaponItem "rhs_acc_dtk";
	
//Add containers
_this forceAddUniform "LOP_U_UKR_Fatigue_Digit";
_this addItemToUniform "ACE_CableTie";
for "_i" from 1 to 10 do {_this addItemToUniform "ACE_morphine";};
_this addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 20 do {_this addItemToUniform "ACE_fieldDressing";};
_this addItemToUniform "ACE_Canteen";
_this addVest "LOP_V_6B23_Rifleman_TAN";
	
//Give player a radio depending on radio mod loaded
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
	_this addItemToVest "ACRE_SEM52SL";
} else {
	if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
		_this linkItem "tf_anprc152";
	} else {
		//Fallback to native arma3 radio
		_this linkItem "ItemRadio";
	};
};
	
_this addItemToVest "rhs_mag_rdg2_white";
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_rgd5";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_30Rnd_545x39_7N6_AK";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_30Rnd_545x39_7N6M_AK";};
_this addBackpack "rhs_rpg_empty";
for "_i" from 1 to 10 do {_this addItemToBackpack "ACE_fieldDressing";};
for "_i" from 1 to 2 do {_this addItemToBackpack "ACE_bloodIV";};
for "_i" from 1 to 10 do {_this addItemToBackpack "ACE_morphine";};
_this addItemToBackpack "rhs_rpg7_OG7V_mag";
_this addItemToBackpack "rhs_rpg7_PG7VL_mag";
for "_i" from 1 to 2 do {_this addItemToBackpack "rhs_30Rnd_545x39_7N6_AK";};
for "_i" from 1 to 2 do {_this addItemToBackpack "rhs_30Rnd_545x39_7N6M_AK";};
_this addHeadgear "LOP_H_6B27M_Digit";
_this addGoggles "rhs_googles_clear";

//Add items
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";

//Set identity
_this setFace (selectRandom ['WhiteHead_01',
'WhiteHead_02',
'WhiteHead_03',
'WhiteHead_04',
'WhiteHead_05',
'WhiteHead_06',
'WhiteHead_07',
'WhiteHead_08',
'WhiteHead_09',
'WhiteHead_10',
'WhiteHead_11',
'WhiteHead_12',
'WhiteHead_13',
'WhiteHead_14',
'WhiteHead_15',
'WhiteHead_16',
'WhiteHead_17',
'WhiteHead_18',
'WhiteHead_19',
'WhiteHead_20',
'WhiteHead_21',
'WhiteHead_23']);
_this setSpeaker "NoVoice";

//ACEX
for "_i" from 1 to 2 do {_this addItemToBackpack "ACE_MRE_CreamChickenSoup";};
