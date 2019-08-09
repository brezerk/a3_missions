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
Spawn start objectives, triggers for informator contact
*/

//Player side triggers
// Client side code
if (hasInterface) then {};

if (isServer) then {
	
	Fn_Spawn_East_Helicopter = {
		private _class = "";
		switch (D_DIFFICLTY) do {
			case 0: {
				_class = "CUP_O_UH1H_slick_SLA";
			};
			case 1: {
				_class = "CUP_O_UH1H_armed_SLA";
			};
			case 2: {
				_class = "CUP_O_UH1H_gunship_SLA";
			};
		};
		private _vehicle = createVehicle [_class, (getMarkerPos format["wp_%1_east_helicopter", D_LOCATION])];
	};
};