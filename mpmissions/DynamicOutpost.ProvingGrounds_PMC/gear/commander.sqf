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
	for "_i" from 1 to 10 do {_this addItemToUniform "ACE_fieldDressing";};
	for "_i" from 1 to 2 do {_this addItemToUniform "ACE_CableTie";};
	_this addItemToUniform "ACE_EarPlugs";
	for "_i" from 1 to 10 do {_this addItemToUniform "ACE_morphine";};
	_this addItemToUniform "ACE_personalAidKit";
	_this addVest "LOP_V_6B23_CrewOfficer_TAN";
	_this addItemToVest "ItemRadio";
	for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_rgd5";};
	_this addItemToVest "rhs_mag_rdg2_white";
	_this addItemToVest "rhs_30Rnd_545x39_7N6M_AK";
	_this addItemToVest "rhs_30Rnd_545x39_7N6_AK";
	_this addHeadgear "LOP_H_6B27M_ess_Digit";

	comment "Add weapons";
	_this addWeapon "rhs_weap_ak74_gp25";
	_this addPrimaryWeaponItem "rhs_acc_dtk";
	_this addWeapon "rhs_weap_makarov_pmm";
	_this addWeapon "Binocular";

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