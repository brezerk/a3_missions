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
 
removeHeadgear player;
removeGoggles player;
removeAllPrimaryWeaponItems player;

player addHeadgear selectRandom [
	"FRITH_ruin_modhat_metgrn",
	"FRITH_ruin_modhat_mettan",
	"FRITH_ruin_modhat_ltrpntwht",
	"FRITH_ruin_modhat_ltrpntred",
	"FRITH_ruin_modhat_ltrpntblk",
	"FRITH_ruin_modhat_ltrpntgrn",
	"FRITH_ruin_modhat_ltr",
	"FRITH_ruin_modhat_metgrn"
];

player addGoggles selectRandom [
	"rvg_respirator_1",
	"rvg_respirator_2",
	"rvg_respirator_3",
	"rvg_respirator_4",
	"rvg_respirator_5",
	"rvg_bandanaSport_1",
	"rvg_bandanaSport_2",
	"rvg_bandanaSport_3",
	"rvg_bandanaSport_4",
	"rvg_bandanaSport_5",
	"rvg_bandana_1",
	"rvg_bandana_2",
	"rvg_bandana_3",
	"rvg_bandana_4",
	"rvg_bandana_5",
	"rvg_bandanaAvi_1",
	"rvg_bandanaAvi_2",
	"rvg_bandanaAvi_3",
	"rvg_bandanaAvi_4",
	"rvg_bandanaAvi_5",
	"rvg_balaclavaCombat_1",
	"rvg_balaclavaCombat_2",
	"rvg_balaclavaCombat_3",
	"rvg_balaclavaCombat_4",
	"rvg_balaclavaCombat_5",
	"rvg_balaclavaLow_1",
	"rvg_balaclavaLow_2",
	"rvg_balaclavaLow_3",
	"rvg_balaclavaLow_4",
	"rvg_balaclavaLow_5",
	"rvg_balaclava_1",
	"rvg_balaclava_2",
	"rvg_balaclava_3",
	"rvg_balaclava_4",
	"rvg_balaclava_5"
];

private _items_u = uniformItems player;
private _items_b = backpackItems player;
private _items_v = vestItems player;

removeUniform player;
player forceAddUniform selectRandom [
	"U_FRITH_RUIN_sdr_ltrdrk_rs",
	"U_FRITH_RUIN_sdr_ltrdrk",
	"U_FRITH_RUIN_sdr_ltrred_rs",
	"U_FRITH_RUIN_sdr_ltr_rs",
	"U_FRITH_RUIN_SDR_Tshirt_oli",
	"U_FRITH_RUIN_coffdpm",
	"U_FRITH_RUIN_coffgrn",
	"U_FRITH_RUIN_cofftan",
	"U_FRITH_RUIN_sdr_fab",
	"U_FRITH_RUIN_sdr_fab",
	"U_FRITH_RUIN_sdr_fabbrn_rs",
	"U_FRITH_RUIN_sdr_fabdpm_rs",
	"U_FRITH_RUIN_sdr_fabgrn"
];

{ player addItemToUniform _x; } forEach _items_u;

removeVest player;
player addVest selectRandom [
	"FRITH_ruin_vestia_tar",
	"FRITH_ruin_vestia_nja",
	"FRITH_ruin_vestia_ltr",
	"FRITH_ruin_vestia_ghm",
	"FRITH_ruin_vestia_lite_tar",
	"FRITH_ruin_vestia_lite_nja",
	"FRITH_ruin_vestia_lite_ltr",
	"FRITH_ruin_vestia_lite_ghm",
	"FRITH_ruin_vestiaGL_grnmtp",
	"FRITH_ruin_vestiaGL_ltrmtp",
	"FRITH_ruin_vestiaGL_grn",
	"FRITH_ruin_vestiaGL_nja",
	"FRITH_ruin_vestiaGL_tar",
	"FRITH_ruin_vestiaGL_ghm"
];
{ player addItemToVest _x; } forEach _items_v;

removeBackpack player;
player addBackpack selectRandom [
	"rvg_kitbag",
	"rvg_carryall_2",
	"rvg_field"
];
{ player addItemToBackpack _x; } forEach _items_b;

player setFace (selectRandom ['WhiteHead_01',
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

player setSpeaker "NoVoice";

/*
for "_i" from 1 to 2 do {player addItemToBackpack "ACE_tourniquet";};
for "_i" from 1 to 2 do {player addItemToBackpack "ACE_bloodIV_500";};
for "_i" from 1 to 20 do {player addItemToBackpack "ACE_fieldDressing";};
player addItemToBackpack "ACE_Canteen";

player addItemToUniform "ACE_CableTie";
for "_i" from 1 to 3 do {player addItemToUniform "ACE_epinephrine";};
for "_i" from 1 to 2 do {player addItemToUniform "ACE_morphine";};

player addItemToUniform "ACE_EarPlugs";
for "_i" from 1 to 5 do {player addItemToUniform "ACE_fieldDressing";};

//ACEX
player addItemToBackpack "ACE_MRE_MeatballsPasta";
for "_i" from 1 to 2 do {player addItemToBackpack "ACE_MRE_CreamChickenSoup";};

for "_i" from 1 to 2 do {player addItemToBackpack "SmokeShell";};*/

player addItemToBackpack "rvg_antiRad";             // Протизапальне
//player addItemToBackpack "AntidoteKit_01_F";        // Антидот
//player addItemToBackpack "rvg_purificationTablets"; // Жаропонижаюче
//player addItemToBackpack "rvg_notepad";
player addItemToBackpack "rvg_flare";             // Розвести вогонь
player addItemToBackpack "rvg_flare";             // Розвести вогонь
player addItemToBackpack "rvg_flare";             // Розвести вогонь


// Kick GPS if any
player unassignItem "ItemGPS";
player removeItem "ItemGPS";
