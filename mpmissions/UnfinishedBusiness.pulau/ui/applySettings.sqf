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
 
if (!mission_requested) then { 
	private _cbDiff = lbCurSel 2101;
	private _cbLocation = lbCurSel 2100;

	_D_DIFFICLTY = _cbDiff;
	_D_LOCATION = nil;

	switch (_cbLocation) do {
		case 0: {
			_D_LOCATION = selectRandom D_LOCATIONS;
		};
		case 1: {
			_D_LOCATION = D_LOCATIONS select 0;
		};
		case 2: {
			_D_LOCATION = D_LOCATIONS select 1;
		};
	};

	closeDialog 1;

	PUB_fnc_missionPlanned = [_D_DIFFICLTY, _D_LOCATION];
	publicVariableServer "PUB_fnc_missionPlanned";
};
