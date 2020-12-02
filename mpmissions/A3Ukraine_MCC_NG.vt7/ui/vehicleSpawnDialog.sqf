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

params['_pos', '_dir'];

//fixme: have invisible controls to put this into?
D_SPN_POS = _pos;
D_SPN_DIR = _dir;

	private _spawnDialog = createDialog "vehicleSpawnDialog";
	 
	if (!isNil "_spawnDialog") then {
		private _dialog = findDisplay 3873;
		
		private _cbFraction = _dialog displayCtrl 2201;
		if (!isNil "_cbFraction") then {
			{
				private _name = getText (configFile >> "CfgFactionClasses" >> _x >> "displayName");
				_cbFraction lbAdd (_name);
			} forEach (D_SIDE_FACTIONS);
			_cbFraction lbSetCurSel 22;
		};
		
		private _cbClass = _dialog displayCtrl 2200;
		if (!isNil "_cbClass") then {
			_cbClass lbAdd (localize "STR_FROM_02_CLASS_01");
			_cbClass lbAdd (localize "STR_FROM_02_CLASS_02");
			_cbClass lbAdd (localize "STR_FROM_02_CLASS_03");
			_cbClass lbAdd (localize "STR_FROM_02_CLASS_04");
			_cbClass lbSetCurSel 0;
		};
	};

	//sleep 1;
	//#include "vehicleSpawnDialog_factionSelectionChanged.sqf";