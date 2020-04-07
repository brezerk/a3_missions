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

_hud_active = false;

while {true} do
{
	if (goggles player in ['Mask_M40', 'Mask_M40_OD', 'Mask_M50']) then {
		if (!_hud_active) then {
			0 cutRsc ["GasMaskHUD","PLAIN", 1, false];
			_hud_active = true;
		};
		playsound selectRandom ["bb_mask_01", "bb_mask_02", "bb_mask_03"];
		//gen_1 say3D ["generator_04", 50, 1.0, false]; //, false];
		sleep (2.6);
	} else {
		if (_hud_active) then {
			0 cutText ["", "PLAIN"];
			_hud_active = false;
		};
	};
	sleep 0.5;
};
