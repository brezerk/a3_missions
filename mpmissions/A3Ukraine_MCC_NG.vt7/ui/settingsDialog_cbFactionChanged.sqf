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
 
private _cbFractionWest = lbCurSel 2105;
private _faction = D_SIDE_FACTIONS # _cbFractionWest;
 
 private _dialog = findDisplay 3773;
private _cbFractionEast = _dialog displayCtrl 2106;
lbClear _cbFractionEast;
if (!isNil "_cbFractionEast") then {
	{
		private _name = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
		_cbFractionEast lbAdd (_name);
	} forEach ([_faction, "soldier"] call Fn_Config_GetFactionVehicles);
	_cbFractionEast lbSetCurSel 0;
};
 