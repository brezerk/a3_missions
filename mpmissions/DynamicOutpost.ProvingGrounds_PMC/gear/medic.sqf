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
 
if !(_this getVariable ['Init_Gear_Applied', false]) then {
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
	_this addItemToUniform "ACE_EarPlugs";
	_this addItemToUniform "ACE_CableTie";
	for "_i" from 1 to 2 do {_this addItemToUniform "ACE_epinephrine";};
	for "_i" from 1 to 10 do {_this addItemToUniform "ACE_morphine";};
	for "_i" from 1 to 10 do {_this addItemToUniform "ACE_fieldDressing";};
	_this addVest "LOP_V_6B23_Medic_TAN";
	for "_i" from 1 to 5 do {_this addItemToVest "rhs_mag_rdg2_white";};
	for "_i" from 1 to 2 do {_this addItemToVest "rhs_30Rnd_545x39_7N6_AK";};
	for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_rgd5";};
	for "_i" from 1 to 3 do {_this addItemToVest "rhs_30Rnd_545x39_7N6M_AK";};
	_this addHeadgear "LOP_H_Beanie_tan";
	_this addGoggles "rhs_googles_clear";

	comment "Add weapons";
	_this addWeapon "rhs_weap_aks74u";
	_this addPrimaryWeaponItem "rhs_acc_pgs64_74u";

	comment "Add items";
	_this linkItem "ItemMap";
	_this linkItem "ItemCompass";
	_this linkItem "ItemWatch";

	comment "Set identity";
	_this setFace "Default";
	_this setSpeaker "NoVoice";
	//prevent from duble loading
	_this setVariable ['Init_Gear_Applied', true];
};
