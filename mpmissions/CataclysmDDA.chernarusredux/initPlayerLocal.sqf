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

Fn_MakeMeZombie = {
	_none = player;
	_pos = markerPos "wp_test";
	{
		if (alive _x) exitWith { _pos = getPos _x };
	} forEach (switchableUnits + playableUnits);
	_pos = [_pos, 350, 500, 5, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
	_unit = (createGroup [civilian, true]) createUnit ["zombie_runner", _pos, [], 0, "FORM"];
	selectPlayer _unit;
	deleteVehicle _none;
	[_unit, 0.85] call rvg_fnc_setDamage;
	execVM "gear\base.sqf";
	_unit;
};

player addEventHandler
[
   "Respawn",
   {
		_zed = call Fn_MakeMeZombie;
		_zed addEventHandler
		[
		   "Respawn",
		   {
				_zed = call Fn_MakeMeZombie;
			}
		];
		vehicle player switchCamera "EXTERNAL";
    }
];

_null = [] spawn {
	while{true} do {
		if (cameraView == "EXTERNAL") then {
			if (!(player isKindOf "zombie")) then {
				vehicle player switchCamera "INTERNAL";
			};
		};
		sleep 0.5;
	};
};


waitUntil {!isNil "insecticid"};

player addEventHandler
[
	"Fired",
	{
		private ["_al_throwable"];
		_al_throwable = _this select 6;
		_shooter = _this select 0;
		[_al_throwable] execVM "AL_swarmer\smoke_detect.sqf";
	}
];

