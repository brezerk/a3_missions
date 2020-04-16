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

bb_player_threat_chem = 0;
bb_player_threat_rad = 0;

bb_next_wave = false;

execVM "briefing.sqf";

// hide markers
{if (_x find "wp_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;

execVM "gear\base.sqf";

setViewDistance 750;

sleep 4;

['Чернорусія.', 'Блокпост', format ['14 листопада 2071 %s', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;

bb_player_threat_chem = 0;
bb_player_threat_rad = 0;

[] spawn BrezBlock_fnc_Local_Systems_Chemical_Controller;
[] spawn BrezBlock_fnc_Local_Systems_Radiation_Controller;

[] spawn BrezBlock_fnc_Local_Systems_Detector_Radiation;
[] spawn BrezBlock_fnc_Local_Systems_Detector_Chemical;
[] spawn BrezBlock_fnc_Local_Systems_Analyzer;

[] spawn BrezBlock_fnc_Local_Systems_Survival_Init;

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

Fn_Local_RespawnWave = {
	if (player isKindOf "zombie") then {
		bb_next_wave = true;
		player setDamage 1;
	};
};

[] spawn BrezBlock_fnc_Local_Systems_GasMask_Init;

[false] call BrezBlock_fnc_Local_Systems_Survival_Fireplace;
[false] call BrezBlock_fnc_Local_Systems_Survival_Medical;

[] spawn BrezBlock_fnc_Local_Systems_Fuel_Init;

[] spawn {
	while {true} do {
		waitUntil{bb_local_fog > 0};
		0.5 setFog [bb_local_fog, 0, getPos player];
		sleep 0.1;
	};
};

100 cutRsc ["BB_Survival_HUD","PLAIN", 1, false];
