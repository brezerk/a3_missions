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
	player setPos _pos;
	{
		if (alive _x) exitWith { _pos = getPos _x };
	} forEach (switchableUnits + playableUnits);
	_pos = [_pos, 350, 500, 5, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
	_unit = (createGroup [civilian, true]) createUnit ["zombie_runner", _pos, [], 0, "FORM"];
	[_unit, 0.85] call rvg_fnc_setDamage;
	execVM "gear\base.sqf";
	waitUntil {alive _unit};
	selectPlayer _unit;
	deleteVehicle _none;
	[] execVM "AL_snowstorm\alias_hunt.sqf"; waitUntil {!isNil "hunt_alias"};
	_unit;
};

_nill = [] spawn { 
	while {(!isNull player)} do {
		if (player_distance > 0) then {
			if ("ChemicalDetector_01_watch_F" in assignedItems player) then {
				playsound selectRandom["geiger_01", "geiger_02", "geiger_03"];
				sleep (player_distance);
			};
		};
		sleep 0.2;
	};
};

player addEventHandler
[
   "Respawn",
   {
		private _zed = call Fn_MakeMeZombie;
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

Fn_LoadSupply = {
	params["_object"];
	private _vechs = nearestObjects [player, ["CUP_C_V3S_Open_TKC"], 50];
	private _loaded = false;
	if ((count _vechs) > 0) then {
		{ 
			if (!(_x getVariable ["loaded", false])) exitWith {
				_x setVariable ["loaded", true, true];
				_object enableSimulation false;
				_object allowDamage false;
				_object attachTo [_x, [0, -1, 0]]; 
				_loaded = true;
			} 
		} forEach (_vechs); 
		if (!_loaded) then {
			systemChat "Ці вантажівкі зайняти. Знайдіть вільну вантажівку з відкритим верхом!";
		};
	} else {
		systemChat "Ці вантажівкі не підходять. Знайдіть вантажівку з відкритим верхом!";
	};
};

_null = [] spawn {
	while {true} do
	{
		gen_1 say3D ["generator_04", 50, 1.0, false]; //, false];
		sleep (1.5);
	};
};

[
	player,
	"Використати Антірадін",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
	"(""ACE_plasmaIV"" in (items player))",
	"true",
	{
		//Execute revive animation
		[player, "AinvPknlMstpSnonWrflDr_medic3"] remoteExec ["playMoveNow", 0, false];
		//Wait for revive animation to be set
		waitUntil {sleep 0.05; ((animationState player) == "AinvPknlMstpSnonWrflDr_medic3")};
		player removeItem "ACE_plasmaIV";
	},
	{ },
	{ 
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
		player setDamage 0;
	},
	{
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["playMoveNow", 0, true];
		[player, "AmovPknlMstpSrasWrflDnon"] remoteExecCall ["switchMove", 0, true];
	},
	[],
	10,
	100,
	false,
	false
] call BIS_fnc_holdActionAdd;

//player addAcction ["Db", {call Fn_UseAntirad;}];

/*addAction ["Завантажити", {[gen_1] call Fn_LoadSupply;}];
gen_2 addAction ["Завантажити", {[gen_2] call Fn_LoadSupply;}];
gen_3 addAction ["Завантажити", {[gen_3] call Fn_LoadSupply;}];*/

//waitUntil {!isNil "insecticid"};
/*
player addEventHandler
[
	"Fired",
	{
		private ["_al_throwable"];
		_al_throwable = _this select 6;
		_shooter = _this select 0;
		[_al_throwable] execVM "AL_swarmer\smoke_detect.sqf";
	}
];*/

