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

params ["_side"];

private _fraction = "";

switch (_side) do {
	case east: {
		_fraction = "UnfinishedBusiness.core\data\images\id\east.paa";
	};
	case civilian: {
		_fraction = "UnfinishedBusiness.core\data\images\id\guer.paa";
	};
	case west: {
		if (player getVariable ["is_civilian", false]) then {
			_fraction = "UnfinishedBusiness.core\data\images\id\guer.paa";
		} else {
			_fraction = "UnfinishedBusiness.core\data\images\id\west.paa";
		};
	};
	case resistance: {
		_fraction = "UnfinishedBusiness.core\data\images\id\guer.paa";
	};
};

private _dialog = createDialog "IDDialog";
 
if (!isNil "_dialog") then {
	private _dialog = findDisplay 4000;
	private _ctrl = _dialog displayCtrl 4533;
	if (!isNil "_ctrl") then {
		_ctrl ctrlSetText (_fraction);
	};
};
