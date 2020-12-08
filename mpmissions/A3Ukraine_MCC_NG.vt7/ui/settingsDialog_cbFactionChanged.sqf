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
 
private _selections = profileNamespace getVariable ["a3ua_mcc_userSettings", []];
private _cbFraction = lbCurSel 2105;
if (_cbFraction > 0) then {
	private _cacheFactions = uiNamespace getVariable ["settingsDialog_cacheFaction", []];
	private _faction = _cacheFactions # _cbFraction;
	private _cacheFactionsVehicles = [_faction, "soldier"] call NECK_fnc_configGetVehicles;
	uiNamespace setVariable ["settingsDialog_cacheFactionsVehicles", _cacheFactionsVehicles];
	private _dialog = findDisplay 3773;
	private _cbRole = _dialog displayCtrl 2106;
	lbClear _cbRole;
	if (!isNil "_cbRole") then {
		{
			private _name = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
			_cbRole lbAdd (_name);
		} forEach (_cacheFactionsVehicles);
		if (count _selections > 0) then {
			_index = _cacheFactionsVehicles find (_selections # 7);
			if (!isNil "_index") then {
				if (_index > 0) then {
					_cbRole lbSetCurSel _index;
				} else {
					_cbRole lbSetCurSel 0;
				};
			};
		} else {
			_cbRole lbSetCurSel 0;
		};
	};
	
};
