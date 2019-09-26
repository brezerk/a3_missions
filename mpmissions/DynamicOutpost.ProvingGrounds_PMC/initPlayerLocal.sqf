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
[player, 3] call BIS_fnc_respawnTickets;

// hide markers
{if (_x find "wp_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;

sleep 1;

// save current load out
[player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_saveInventory;

// kick player to specator upon death
_trgKickToSpecator = createTrigger ["EmptyDetector", getMarkerPos 'ua_secret_01'];
_trgKickToSpecator setTriggerArea [0, 0, 0, false];
_trgKickToSpecator setTriggerActivation ["NONE", "PRESENT", false];
_trgKickToSpecator setTriggerStatements [
			"([player,nil,true] call BIS_fnc_respawnTickets) <= 0",
			"[true] call ace_spectator_fnc_setSpectator; [[independent], [east,west,civilian]] call ace_spectator_fnc_updateSides;",
			""
];

// cargo load hooks
["ace_cargoLoaded", { 
	if (_vehicle == ua_ural_ammo_01) then { 
		PUB_fnc_cargoLoaded = [_vehicle, _item, true];
		publicVariableServer "PUB_fnc_cargoLoaded";
	}; 	
}] call CBA_fnc_addEventHandler;
["ace_cargoUnloaded", { 
	if (_vehicle == ua_ural_ammo_01) then { 
		PUB_fnc_cargoLoaded = [_vehicle, _item, false];
		publicVariableServer "PUB_fnc_cargoLoaded";
	}; 	
}] call CBA_fnc_addEventHandler;

Fn_Local_SetPersonalTaskState = {
	params['_name', '_state', '_title'];
	private _task = [_name, player] call BIS_fnc_taskReal;
	if (!isNull _task) then {
		[format["Task%1", _state],["", _title]] call BIS_fnc_showNotification;
		_task setTaskState _state;
	};
};

sleep 3;

// display intro

_trgLocationInfo01 = createTrigger ["EmptyDetector", getMarkerPos "ua_secret_01"];
_trgLocationInfo01 setTriggerArea [80, 80, 0, false];
_trgLocationInfo01 setTriggerActivation ["ANYPLAYER", "PRESENT", true];
_trgLocationInfo01 setTriggerStatements [
	"(vehicle player) in thisList",
	"[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_03', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;",
	""
];










