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
Local player script
*/

waitUntil { !isNull player }; // Wait for player to initialize

#include "config\fractions.sqf";

Fn_Local_WaitPublicVariables = {
	params ['_vars'];
	private _done = true;
	{
		if ( isNil _x) then { _done = false; };
	} forEach _vars;
	_done;
};

// hide markers
if (isServer) then {
	{if (_x find "wp_" >= 0) then {_x setMarkerAlphaLocal 0;}} forEach allMapMarkers;
} else {
	//FIXME:
	//{if (_x find "wp_" >= 0) then {deleteMarkerLocal _x;}} forEach allMapMarkers;
	{if (_x find "wp_" >= 0) then {_x setMarkerAlphaLocal 0;}} forEach allMapMarkers;
};

{if (_x find "respawn_" >= 0) then {_x setMarkerAlphaLocal 0;}} forEach allMapMarkers;

waitUntil { sleep 1; [["mission_requested"]] call Fn_Local_WaitPublicVariables; };

[0] execVM "Crossfire.core\dialogs\ui\dlgCounter.sqf";
[0] execVM "Crossfire.core\dialogs\ui\dlgCityInfo.sqf";
