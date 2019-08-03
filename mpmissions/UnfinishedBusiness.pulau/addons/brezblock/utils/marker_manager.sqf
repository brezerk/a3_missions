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
 
 private _my_marker_tag = nil;
 private _nearest_players = [];
 
 while { isNil "_my_marker_tag" } do {
	{
		if ((_x select 0) == (name player)) then {
			_my_marker_tag = _x select 2;
		};
	} forEach connected_users;
	sleep 1;
 };
 
 if (D_DEBUG) then {
	systemChat format ["ok my tag: %1", _my_marker_tag];
 };
 
 while { true } do {
 
	if (side player == west) then {
		{
			private _marker = _x;
			//_USER_DEFINED #<PlayerID>/
			if ((_marker find _my_marker_tag) >= 0) then {
				//skip me
				//systemChat "ok";
			} else {
				if ((_marker find "_USER_DEFINED #") >= 0) then {
					{
						if ((_marker find _x select 2) >= 0) exitWith {
							_x setMarkerAlphaLocal 1;
						};
					} forEach _nearest_players;
					_x setMarkerAlphaLocal 0;
				};
			};
		} forEach allMapMarkers;
		
		if (D_DEBUG) then {
			{
				systemChat format ["name: %1 id: %2", _x select 0, (_x select 2)];
			} forEach connected_users;
		};
		
		_nearest_players = [];
		private _nearest = nearestObjects [player, ["SoldierWB"], 25];
		{
			if ((_x in playableUnits) || (_x in switchableUnits)) then {
				_nearest_players pushBackUnique _x;
			};
		} forEach _nearest;
	};
	sleep 1;
 };