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

comment "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";

comment "Set identity";
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

_this setVariable ["ace_medical_medicclass", 0, true];
_this setVariable ["ACE_IsEngineer", 0, true]; 
