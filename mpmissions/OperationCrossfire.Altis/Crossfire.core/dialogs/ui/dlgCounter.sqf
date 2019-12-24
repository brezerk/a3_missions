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

4 cutRsc ["dlgCounter", "PLAIN", 0, false];

UI_Update_Counter_SideMoney = {
	params ['_value'];
	private _ctrl = uiNamespace getVariable "ui_score" displayCtrl 3701;
	if (!isNil "_ctrl") then { _ctrl ctrlSetText (format ["%1$", (_value)]) };
};

UI_Update_Counter_PrivateMoney = {
	params ['_value'];
	private _ctrl = uiNamespace getVariable "ui_score" displayCtrl 3702;
	if (!isNil "_ctrl") then { _ctrl ctrlSetText (format ["%1$", (_value)]) };
};

UI_Update_Counter_SideAmmo = {
	params ['_value'];
	private _ctrl = uiNamespace getVariable "ui_score" displayCtrl 3702; //FIXME: incorrect id
	if (!isNil "_ctrl") then { _ctrl ctrlSetText (format ["%1", (_value)]) };
};

UI_Update_Counter_SideFuel = {
	params ['_value'];
	private _ctrl = uiNamespace getVariable "ui_score" displayCtrl 3703;
	if (!isNil "_ctrl") then { _ctrl ctrlSetText (format ["%1", (_value)]) };
};

UI_Update_Counter_SideMedicine = {
	params ['_value'];
	private _ctrl = uiNamespace getVariable "ui_score" displayCtrl 3704;
	if (!isNil "_ctrl") then { _ctrl ctrlSetText (format ["%1", (_value)]) };
};

UI_Update_Counter_SideResources = {
	params ['_value'];
	private _ctrl = uiNamespace getVariable "ui_score" displayCtrl 3705;
	if (!isNil "_ctrl") then { _ctrl ctrlSetText (format ["%1", (_value)]) };
};

UI_Update_Counter_SideScouts = {
	params ['_value'];
	private _ctrl = uiNamespace getVariable "ui_score" displayCtrl 3706;
	if (!isNil "_ctrl") then { _ctrl ctrlSetText (format ["%1", (_value)]) };
};

UI_Update_Counter_PrivateRank = {
	params ['_value'];
	private _ctrl = uiNamespace getVariable "ui_score" displayCtrl 3707;
	if (!isNil "_ctrl") then { _ctrl ctrlSetText (format ["%1", (_value)]) };
};


"WEST_SIDE_COUNTS" addPublicVariableEventHandler {
	private _SIDE_COUNTS = _this select 1;
	[(_SIDE_COUNTS select 0)] call UI_Update_Counter_SideMoney;
	[(_SIDE_COUNTS select 1)] call UI_Update_Counter_SideAmmo;
	[(_SIDE_COUNTS select 2)] call UI_Update_Counter_SideFuel;
	[(_SIDE_COUNTS select 3)] call UI_Update_Counter_SideMedicine;
	[(_SIDE_COUNTS select 4)] call UI_Update_Counter_SideResources;
	[(_SIDE_COUNTS select 5)] call UI_Update_Counter_SideScouts;
};

"WEST_MONEY_COUNT" addPublicVariableEventHandler {
	[(_this select 1)] call UI_Update_Counter_SideMoney;
};

"WEST_AMMO_COUNT" addPublicVariableEventHandler {
	[(_this select 1)] call UI_Update_Counter_SideAmmo;
};

"WEST_FUEL_COUNT" addPublicVariableEventHandler {
	[(_this select 1)] call UI_Update_Counter_SideFuel;
};

"WEST_MED_COUNT" addPublicVariableEventHandler {
	[(_this select 1)] call UI_Update_Counter_SideMedicine;
};

"WEST_RES_COUNT" addPublicVariableEventHandler {
	[(_this select 1)] call UI_Update_Counter_SideResources;
};

