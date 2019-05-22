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

waitUntil { !isNull player }; // Wait for player to initialize

/*
Local player script
*/
private ["_trgKickToSpecator", "_trgLocationInfo01"];

//3 tickets per player
[player, 1] call BIS_fnc_respawnTickets;

// hide markers
{if (_x find "wp_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;

sleep 1;

// kick player to specator upon death
_trgKickToSpecator = createTrigger ["EmptyDetector", getMarkerPos 'wp_air_field_01'];
_trgKickToSpecator setTriggerArea [0, 0, 0, false];
_trgKickToSpecator setTriggerActivation ["NONE", "PRESENT", false];
_trgKickToSpecator setTriggerStatements [
			"([player,nil,true] call BIS_fnc_respawnTickets) <= 0",
			"[true] call ace_spectator_fnc_setSpectator; [[west], [east,independent,civilian]] call ace_spectator_fnc_updateSides;",
			""
];
