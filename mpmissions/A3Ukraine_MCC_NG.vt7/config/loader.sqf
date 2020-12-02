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
 
Fn_Config_GetFactions = {
	params ["_side"];
	private _factions = [];
	{ _factions pushBack (configName _x) } forEach ( (format ["(getNumber ( _x >> ""side"") == %1)", _side]) configClasses (configfile >> "CfgFactionClasses"));
	_factions
};
	
Fn_Config_GetFactionVehicles = {
	//params ["_side"];
	params ["_faction", "_simulation"];
	private _classes = [];
	{ _classes pushBack (configName _x) } forEach ( (format ["(getText ( _x >> ""faction"") == ""%1"") && (getText ( _x >> ""simulation"") == ""%2"")", _faction, _simulation]) configClasses (configfile >> "CfgVehicles"));
	_classes
};