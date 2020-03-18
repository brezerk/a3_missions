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

execVM "briefing.sqf";

// hide markers
{if (_x find "wp_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;

execVM "gear\base.sqf";

sleep 4;

['Чернорусія.', 'Східна границя', format ['31 жовтня 2071 %s', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;

//player addEventHandler ["Killed", {"zombie_runner" createUnit [getMarkerPos "wp_test", (createGroup [civilian, true])]}]

player addEventHandler
[
	"Killed",
	{
		if (playerSide == west) then {
			private _player = player; 
			[player] joinSilent createGroup [civilian, true];
			selectNoPlayer;
		};
	}
];

player addEventHandler
[
   "Respawn",
   {
		/*
		_handler = [] spawn {
			_noPlayer = createGroup sideLogic createUnit [
				"Logic",
				[0,0,1000],
				[],
				0,
				"NONE"
			];
			sleep 1;
			selectPlayer _noPlayer;
			systemChat format ["FOO: %s !", playerSide];
			_unit = (createGroup [civilian, true]) createUnit ["zombie_runner", (markerPos "wp_test"), [], 0, "FORM"];
			sleep 1;
			selectPlayer _unit;
		};*/
		execVM "gear\zombie_runner.sqf";
		player enableStamina false;
		player allowSprint true;
		player setCombatMode "BLUE";
		player setVariable ["_zTarget", false, true];
		player setBehaviour "CARELESS";
		//_zed setCombatMode "RED";
		[player, 0.85] call rvg_fnc_setDamage;
		player setVariable ["mrg_unit_sfx_hitRecently", true];//quickfix for mrgSFX mod
		player addRating -7000;
		player enableSimulationGlobal true;
		_nul = [player] spawn rvg_fnc_zed_behaviour;
		
		//player switchCamera "EXTERNAL";
   }
];
