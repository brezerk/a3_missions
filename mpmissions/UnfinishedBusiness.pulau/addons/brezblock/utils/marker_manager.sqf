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
 
waitUntil 
{
  !isNil "connected_users"
};
 
 while { isNil "_my_marker_tag" } do {
	{
		if ((_x select 0) == (name player)) then {
			_my_marker_tag = _x select 1;
		};
	} forEach connected_users;
	if (D_DEBUG) then {
		systemChat "Getting user id...";
	};
	sleep 1;
 };
 
 if (D_DEBUG) then {
	systemChat format ["ok my tag: %1", _my_marker_tag];
 };
 
 scopeName "main";
 while { true } do {
 
	if (side player == west) then {
		scopeName "marker";
		{
			private _marker = _x;
			if ((_marker find "_USER_DEFINED #") >= 0) then {
				private _id = [_marker, "#"] call CBA_fnc_split select 1;
				_id = ([_id, "/"] call CBA_fnc_split) select 0;
				_id = parseNumber _id;
				_id = _id call CBA_fnc_formatNumber;
				
				if (_id == _my_marker_tag) then {
					systemChat "Found ny marker. Skip..";
				} else {
					systemChat format ["FOUND %1",  _marker];
					scopeName "player";
					{
						if (_id == _x select 1) then {
							_x setMarkerAlphaLocal 1;
							breakTo "marker";
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