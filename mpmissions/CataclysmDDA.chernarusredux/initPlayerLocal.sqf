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

['Чернорусія.', 'Пограничне поселення', format ['31 жовтня 2071 %s', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;

//player addEventHandler ["Killed", {"zombie_runner" createUnit [getMarkerPos "wp_test", (createGroup [civilian, true])]}]

/*
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
*/

/*
Fn_MakeMeZombie = {
	_none = player;
	_pos = markerPos "wp_zed";
	player setPos _pos;
	if (!bb_next_wave) then {
		{
			if (alive _x) exitWith { _pos = getPos _x };
		} forEach (switchableUnits + playableUnits);
		_pos = [_pos, 350, 500, 5, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
		_pos = markerPos "wp_test";
		private _unit = (createGroup [civilian, true]) createUnit ["zombie_runner", _pos, [], 0, "FORM"];
		
		waitUntil {alive _unit};
		
		//[_unit, 35] call rvg_fnc_setDamage;
		execVM "gear\base.sqf";
		//
		selectPlayer _unit;
		
		deleteVehicle _none;
		vehicle player switchCamera "EXTERNAL";
		
		[_unit, _none] spawn { params ["_unit", "_none"]; waitUntil { !alive _unit; }; selectPlayer _none; player addEventHandler ["Respawn", { params ["_unit", "_corpse"]; _unit = call Fn_MakeMeZombie; _unit} ]; player setDamage 1.0; };
		
		bb_next_wave = true;
		_unit;
	} else {
		private _unit = (createGroup [civilian, true]) createUnit ["B_Survivor_F", _pos, [], 0, "FORM"];
		waitUntil {alive _unit};
		selectPlayer _unit;
		player addEventHandler ["Respawn", { params ["_unit", "_corpse"]; _unit = call Fn_MakeMeZombie; _unit} ];
		execVM "gear\base.sqf";
		_pos = markerPos "wp_test";
		player setPos _pos;
		bb_next_wave = false;
	};
};*/

bb_player_threat_chem = 0;
bb_player_threat_rad = 0;

[] spawn BrezBlock_fnc_Local_Systems_Chemical_Controller;
[] spawn BrezBlock_fnc_Local_Systems_Radiation_Controller;

[] spawn BrezBlock_fnc_Local_Systems_Detector_Radiation;
[] spawn BrezBlock_fnc_Local_Systems_Detector_Chemical;
//[] spawn BrezBlock_fnc_Local_Systems_Analyzer;

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

[] spawn BrezBlock_fnc_Local_Systems_GasMask_Init;

call BrezBlock_fnc_Local_Systems_Survival_Fireplace;
call BrezBlock_fnc_Local_Systems_Survival_Medical;

[] spawn BrezBlock_fnc_Local_Systems_Fuel_Init;

[] spawn {
	while {true} do {
		waitUntil{bb_local_fog > 0};
		0.5 setFog [bb_local_fog, 0, getPos player];
		sleep 0.1;
	};
};

100 cutRsc ["BB_Survival_HUD","PLAIN", 1, false];

//player addEventHandler ["Respawn", { params ["_unit", "_corpse"]; _unit = call Fn_MakeMeZombie; _unit } ];

/*
null = [
		true, //boolean, if true snowflakes made out of particles will be created
		3000000, //number, life time of the SNOW STORM expressed in seconds
		30,   //seconds/number, a random number will be generated based on your input value and used to set the frequency for played ambient sounds
		true, //boolean, if true you will see breath vapors for all units, however if you have many units in your mission you should set this false to diminish the impact on frames
		45,    //seconds/number, if higher than 0 burst of snow will be generated at intervals based on your value
		false, //boolean, if is true occasionally a random object will be pushed by the wind during the snow burst if the later is enabled
		false, //boolean, vanilla fog will be managed by the script if true, otherwise the values you set in editor will be used 
		true, // boolean, if true particles will be used to create sort of waves of fog and snow
		true, //boolean, if is true the wind will blow with force otherwise default value from Eden or other script will be used
		true   //boolean, if is true the at random units will sneeze/caugh and will shiver when snow burst occurs
	] execVM "AL_snowstorm\al_snow.sqf";*/

/*
[
	player,
	"Використати Антірадін",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
	" && ((getDammage player) > 0))",
	"true",
	{
		//Execute revive animation
		[player, "AinvPknlMstpSnonWrflDr_medic3"] remoteExec ["playMoveNow", 0, false];
		//Wait for revive animation to be set
		waitUntil {sleep 0.05; ((animationState player) == "AinvPknlMstpSnonWrflDr_medic3")};
	},
	{
		params ["_target", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
		if (_progress >= 10) then {
			player removeItem "ACE_plasmaIV";
		};
	},
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
	0,
	false,
	false
] call BIS_fnc_holdActionAdd;
*/
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

