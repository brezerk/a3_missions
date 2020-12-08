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
 
private _cbRole = (lbCurSel 2106);

if (!isNil "_cbRole") then {
	if (_cbRole > 0) then {
		private _cacheFactionsVehicles = uiNamespace getVariable ["settingsDialog_cacheFactionsVehicles", []];
		private _class = _cacheFactionsVehicles # _cbRole;
		private _weapons = [];

		{
			if (!(_x in ['Throw', 'Put'])) then {
				_weapons pushBack (getText(configfile >> "CfgWeapons" >> _x >> "displayName"));
			};
		} forEach (getArray(configfile >> "CfgVehicles" >> _class >> "weapons"));

		ctrlSetText [1003, format[
			"Роль: %1\nМедик: %2\nІнженер: %3\nУніформа: %4\nЗброя: %5",
			getText(configfile >> "CfgVehicles" >> _class >> "role"),
			localize (["STR_FROM_INFO_NO", "STR_FROM_INFO_YES"] # getNumber (configfile >> "CfgVehicles" >> _class >> "attendant")),
			localize (["STR_FROM_INFO_NO", "STR_FROM_INFO_YES"] # getNumber (configfile >> "CfgVehicles" >> _class >> "engineer")),
			getText(configfile >> "CfgWeapons" >> (getText(configfile >> "CfgVehicles" >> _class >> "uniformClass")) >> "displayName"),
			(_weapons joinString ", ")]];
	};
} else {
	ctrlSetText [1003, ""];
};
