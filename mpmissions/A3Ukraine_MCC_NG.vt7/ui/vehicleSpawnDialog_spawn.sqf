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
 
//D_SPN_POS = _pos;
//D_SPN_DIR = _dir;

if (count(nearestObjects [D_SPN_POS, ["AllVehicles"], 7]) > 0) then {
	hint(localize "STR_ZONE_NOT_EMPTY");
} else {
	private _cbVehicle = lbCurSel 2202;
	if (_cbVehicle >= 0) then {
		private _cls = D_FACTION_CACHE # _cbVehicle;
		_veh = createVehicle [_cls, [0, 0, 0], [], 0, "NONE"];
		_veh setPos D_SPN_POS;
		_veh setDir D_SPN_DIR;
	};
	

};
 