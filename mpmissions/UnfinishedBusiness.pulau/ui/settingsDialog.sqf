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
 
 
private _settingsDialog = createDialog "SettingsDialogControl";
 
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
		_cbLocation lbAdd (localize "FROM_02_DIF_SELECT_01");
		{
			_cbLocation lbAdd _x;
		} forEach D_LOCATIONS;
		_cbLocation lbSetCurSel 0;
	};
};