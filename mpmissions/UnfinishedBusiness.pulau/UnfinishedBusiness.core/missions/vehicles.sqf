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
 
private _respawnDelay = D_RESPAWN_DELAY;

while {true} do {
	sleep (_respawnDelay - (servertime % _respawnDelay));
	
	[west_rack_01] call Fn_Spawn_Boat_At_Rack;
	[west_rack_02] call Fn_Spawn_Boat_At_Rack;
	[(us_liberty_01 modelToWorldWorld [0,50.6011,8.95]), (getDir us_liberty_01)] call Fn_Spawn_Heli;
	
	{
		if (_x find "mrk_east_transport_" >= 0) then {
			[(getMarkerPos _x), (markerDir _x)] call Fn_Spawn_East_Cars_Transport;
		};
	} forEach allMapMarkers;
	
};


