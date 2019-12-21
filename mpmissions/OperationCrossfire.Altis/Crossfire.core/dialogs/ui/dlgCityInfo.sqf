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

params ["_exitCode"];

if (_exitCode in [0, 2]) then { 

sleep 5;

3 cutRsc ["dlgCityInfo", "PLAIN", 2, false];
 
//if (!isNil "_dlgCityInfo") then {
	private _dialog = findDisplay 3000;
	 
	private _ctrl = _dialog displayCtrl 3001;
	if (!isNil "_ctrl") then {
		_ctrl ctrlSetText localize "FROM_CITY_INFO_01";
	};
	
	private _ctrl = _dialog displayCtrl 3002;
	if (!isNil "_ctrl") then {
		_ctrl ctrlSetText localize "FROM_CITY_INFO_02";
	};
	
//};

};	