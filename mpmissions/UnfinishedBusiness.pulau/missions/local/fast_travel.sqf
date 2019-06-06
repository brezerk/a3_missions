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

if (hasInterface) then {
	Fn_Local_FastTravel_Sleep = {
		if (alive player) then {
			playSound "radio_chatter_00";
			[0, 5] execVM "addons\brezblock\utils\fade.sqf";
		};
	};
		
	Fn_Local_FastTravel_Wokeup = {
		if (alive player) then {
			playSound "radio_chatter_01";
			[1, 5] execVM "addons\brezblock\utils\fade.sqf";
		};
	};
};