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

/*
Init mission file
*/

real_weather_init = false;

D_DEBUG = false;

//[] execVM "addons\code43\real_weather.sqf";

if (isServer) then {
	//waitUntil {real_weather_init};
	
	{
		_x addItemCargoGlobal ["LOP_H_6B27M_Digit", 3];
	} forEach [bmp_01, bmp_02];
	[] execVM "addons\BrezBlock.framework\utils\garbage_collector.sqf";
};
