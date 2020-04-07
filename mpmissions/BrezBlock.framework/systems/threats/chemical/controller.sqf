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

while {(!isNull player)} do  {
	private _threat = 0;
	private _fog = 0;
	waitUntil {alive player};
	{
		private _object = _x select 0;
		private _type   = _x select 1;
		private _radius = _x select 2;
		private _distance = player distance _object;
		private _threat_new = 0;
		private _fog_new = 0;
		switch (_type) do {
			case D_THREAT_CHEM_AREAL: {
				if (_distance < (_radius + 100)) then {
					_threat_new = 0.1;
					if (_distance < (_radius)) then {
						_threat_new = (1.0 - parseNumber ((_distance/(_radius)) toFixed 1)) + 0.1;
						_fog_new = (1.0 - (_distance/(_radius)));
						if (!(goggles player in ['Mask_M40', 'Mask_M40_OD', 'Mask_M50'])) then {
							bb_srv_dmg_chem = bb_srv_dmg_chem + (_x select 3);
						};
					};
				};
			};
			case D_THREAT_CHEM_LOCAL: {
				if (_distance < (_radius + 10)) then {
					_threat_new = 0.1;
					if (_distance < (_radius)) then {
						_threat_new = (1.0 - parseNumber ((_distance/(_radius)) toFixed 1)) + 0.1;
						if (!(goggles player in ['Mask_M40', 'Mask_M40_OD', 'Mask_M50'])) then {
							bb_srv_dmg_chem = bb_srv_dmg_chem + (_x select 3);
						};
					};
				};
			};
		};
		if (_threat_new > _threat) then {
			_threat = _threat_new;
		};
		if (_fog_new > _fog) then {
			_fog = _fog_new;
		};
	} forEach bb_threat_chem_areas;
	bb_player_threat_chem = _threat;
	bb_local_fog = _fog;
	sleep 0.5;
};