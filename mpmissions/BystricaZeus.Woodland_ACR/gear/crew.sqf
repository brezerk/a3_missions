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
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_this addItemToUniform "rhs_30Rnd_545x39_AK";};
_this addVest "rhs_vest_pistol_holster";
_this addItemToVest "rhs_mag_rdg2_white";
_this addItemToVest "rhs_mag_nspd";
_this addHeadgear "rhs_tsh4";

comment "Add weapons";
_this addWeapon "rhs_weap_aks74u";
_this addPrimaryWeaponItem "rhs_acc_pgs64_74u";

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";

comment "Set identity";
_this setSpeaker "NoVoice";
