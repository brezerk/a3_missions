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

//tickets
[player, 3] call BIS_fnc_respawnTickets;

// hide markers
{if (_x find "wp_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;
{if (_x find "respawn_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;

sleep 5;

[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_00', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;

/*
// kick player to specator upon death
//private ["_trgKickToSpecator"];
_trgKickToSpecator = createTrigger ["EmptyDetector", getMarkerPos 'ua_secret_01'];
_trgKickToSpecator setTriggerArea [0, 0, 0, false];
_trgKickToSpecator setTriggerActivation ["NONE", "PRESENT", false];
_trgKickToSpecator setTriggerStatements [
			"!alive player",
			"[true] call ace_spectator_fnc_setSpectator; [[west], [east, independent, civilian]] call ace_spectator_fnc_updateSides;",
			""
];*/