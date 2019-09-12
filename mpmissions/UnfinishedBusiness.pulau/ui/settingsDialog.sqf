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
 
#include "..\config\fractions.sqf"; 
 
private _settingsDialog = createDialog "SettingsDialog";
 
if (!isNil "_settingsDialog") then {
	private _dialog = findDisplay 3773;
 
	private _cbDiff = _dialog displayCtrl 2101;
	if (!isNil "_cbDiff") then {
		_cbDiff lbAdd (localize "FROM_01_DIF_SELECT_01");
		_cbDiff lbAdd (localize "FROM_01_DIF_SELECT_02");
		_cbDiff lbAdd (localize "FROM_01_DIF_SELECT_03");
		_cbDiff lbSetCurSel 0;
	};
	
	private _cbLocation = _dialog displayCtrl 2100;
	if (!isNil "_cbLocation") then {
		_cbLocation lbAdd (localize "FROM_01_LOC_SELECT_01");
		{
			_cbLocation lbAdd _x;
		} forEach D_LOCATIONS;
		_cbLocation lbSetCurSel 0;
	};
	
	private _cbStart = _dialog displayCtrl 2102;
	if (!isNil "_cbStart") then {
		_cbStart lbAdd (localize "FROM_01_START_SELECT_01");
		_cbStart lbAdd (localize "FROM_01_START_SELECT_02");
		_cbStart lbSetCurSel 0;
	};
	
	private _cbNavToolsMap = _dialog displayCtrl 2103;
	if (!isNil "_cbNavToolsMap") then {
		_cbNavToolsMap lbAdd (localize "FROM_01_NAVTOOS_SELECT_01");
		_cbNavToolsMap lbAdd (localize "FROM_01_NAVTOOS_SELECT_02");
		_cbNavToolsMap lbAdd (localize "FROM_01_NAVTOOS_SELECT_03");
		_cbNavToolsMap lbSetCurSel 0;
	};
	
	private _cbNavToolsCompass = _dialog displayCtrl 2104;
	if (!isNil "_cbNavToolsCompass") then {
		_cbNavToolsCompass lbAdd (localize "FROM_01_NAVTOOS_SELECT_01");
		_cbNavToolsCompass lbAdd (localize "FROM_01_NAVTOOS_SELECT_02");
		_cbNavToolsCompass lbAdd (localize "FROM_01_NAVTOOS_SELECT_03");
		_cbNavToolsCompass lbSetCurSel 0;
	};
	
	private _cbFractionWest = _dialog displayCtrl 2105;
	if (!isNil "_cbFractionWest") then {
		{
			private _name = getText (configFile >> "CfgFactionClasses" >> _x >> "displayName");
			_cbFractionWest lbAdd (_name);
		} forEach ([west] call Fn_Config_GetFractions);
		_cbFractionWest lbSetCurSel 0;
	};
	
	private _cbFractionEast = _dialog displayCtrl 2106;
	if (!isNil "_cbFractionEast") then {
		{
			private _name = getText (configFile >> "CfgFactionClasses" >> _x >> "displayName");
			_cbFractionEast lbAdd (_name);
		} forEach ([east] call Fn_Config_GetFractions);
		_cbFractionEast lbSetCurSel 0;
	};
	
	private _cbFractionIndep = _dialog displayCtrl 2107;
	if (!isNil "_cbFractionIndep") then {
		{
			private _name = getText (configFile >> "CfgFactionClasses" >> _x >> "displayName");
			_cbFractionIndep lbAdd (_name);
		} forEach ([independent] call Fn_Config_GetFractions);
		_cbFractionIndep lbSetCurSel 0;
	};
	
	private _cbFractionCiv = _dialog displayCtrl 2108;
	if (!isNil "_cbFractionCiv") then {
		{
			private _name = getText (configFile >> "CfgFactionClasses" >> _x >> "displayName");
			_cbFractionCiv lbAdd (_name);
		} forEach ([civilian] call Fn_Config_GetFractions);
		_cbFractionCiv lbSetCurSel 0;
	};
};