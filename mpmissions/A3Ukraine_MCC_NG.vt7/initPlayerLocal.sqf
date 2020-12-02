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

mission_requested = false;
mission_generated = false;
D_SIDE_FACTIONS = [];
D_FACTION_CACHE = [];

Fn_Local_WaitPublicVariables = {
	params ['_vars'];
	private _done = true;
	{
		if (isNil _x) then { _done = false; };
	} forEach _vars;
	_done;
};

Fn_Local_Respawn = {
	enableEngineArtillery false; 

	player setVariable ["BB_CorpseTTL", -1, true];
	player setVariable ["MCC_valorPoints", 10000, true];

	waitUntil { alive player }; // Wait for player to initialize
	
	player setUnitLoadout (configFile >> "CfgVehicles" >> D_ROLE);
	
	if (getNumber (configfile >> "CfgVehicles" >> D_ROLE >> "attendant") == 1) then {
		if (D_MOD_ACE) then {
			player setVariable ["ace_medical_medicclass", 1, true];
		} else {
			player setUnitTrait ["Medic", true];
		};
	} else {
		if (D_MOD_ACE) then {
			player setVariable ["ace_medical_medicclass", 0, true];
		} else {
			player setUnitTrait ["Medic", false];
		};
	};
	if (getNumber (configfile >> "CfgVehicles" >> D_ROLE >> "engineer") == 1) then {
		if (D_MOD_ACE) then {
			player setVariable ["ACE_IsEngineer", 1, true];
		} else {
			player setUnitTrait ["engineer", true];
		};
	} else {
		if (D_MOD_ACE) then {
			player setVariable ["ACE_IsEngineer", 0, true];
		} else {
			player setUnitTrait ["engineer", false];
		};
	};
	private _building = selectRandom((getMarkerPos "wp_main") nearObjects ["Base_WarfareBBarracks", 50]);
	player setPos (getPos _building);
	
	
};

waitUntil { !isNull player }; // Wait for player to initialize

// hide markers
{if (_x find "wp_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;

cutText ["", "BLACK"];

waitUntil { sleep 1; [["mission_requested", "mission_generated", "real_weather_init"]] call Fn_Local_WaitPublicVariables; };

//FIXME: Dynamic side?
D_SIDE_FACTIONS = [2] call Fn_Config_GetFactions;

if ((!mission_requested) || (!mission_generated)) then {
	["ui\settingsDialogHandler.sqf"] call BrezBlock_fnc_WaitForStart;
};

waitUntil { sleep 1; [["D_LOCATION", "D_FACTION", "D_ROLE"]] call Fn_Local_WaitPublicVariables; }; 

[1, "BLACK", 1, 1] call BIS_fnc_fadeEffect;
[[""]] call BIS_fnc_music;


[
	a3ua_mcc_medic01,
	"Змінити налаштування",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"_this distance _target < 3",
	"_caller distance _target < 3",
	{},
	{},
	{ [0] execVM "ui\settingsDialog.sqf"; },
	{ },
	[],
	3,
	nil,
	false,
	false] call BIS_fnc_holdActionAdd;

[
	a3ua_vehSpawn01,
	"Запросити технику",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"_this distance _target < 3",
	"_caller distance _target < 3",
	{},
	{},
	{ [(getPos a3ua_vehSpawn_lcs01), (getDir a3ua_vehSpawn_lcs01)] execVM "ui\vehicleSpawnDialog.sqf"; },
	{ },
	[],
	3,
	nil,
	false,
	false] call BIS_fnc_holdActionAdd;
	
[
	a3ua_vehSpawn02,
	"Запросити технику",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"_this distance _target < 3",
	"_caller distance _target < 3",
	{},
	{},
	{ [(getPos a3ua_vehSpawn_lcs02), (getDir a3ua_vehSpawn_lcs02)] execVM "ui\vehicleSpawnDialog.sqf"; },
	{ },
	[],
	3,
	nil,
	false,
	false] call BIS_fnc_holdActionAdd;

[
	a3ua_vehSpawn03,
	"Запросити технику",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"_this distance _target < 3",
	"_caller distance _target < 3",
	{},
	{},
	{ [(getPos a3ua_vehSpawn_lcs03), (getDir a3ua_vehSpawn_lcs03)] execVM "ui\vehicleSpawnDialog.sqf"; },
	{ },
	[],
	3,
	nil,
	false,
	false] call BIS_fnc_holdActionAdd;

[
	a3ua_vehSpawn04,
	"Запросити технику",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"_this distance _target < 3",
	"_caller distance _target < 3",
	{},
	{},
	{ [(getPos a3ua_vehSpawn_lcs04), (getDir a3ua_vehSpawn_lcs04)] execVM "ui\vehicleSpawnDialog.sqf"; },
	{ },
	[],
	3,
	nil,
	false,
	false] call BIS_fnc_holdActionAdd;	


a3ua_mcc_pc01 addAction
[
	"Брама",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _phase = a3ua_mcc_prison01 doorPhase "door_1";
		if ((a3ua_mcc_prison01 animationPhase "door_1_rot") == 0) then {
			a3ua_mcc_prison01 animate ["door_1_rot", 1];
		} else {
			a3ua_mcc_prison01 animate ["door_1_rot", 0];
		};
	},
	nil,
	1.5,
	true,
	false,
	"",
	"true", // _target, _this, _originalTarget
	3,
	false,
	"",
	""
];

a3ua_t_mine01 addAction
[
	"Міни (тренувальні)",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _pos = getMarkerPos "mrk_t_mines00";
		if (count (_pos nearObjects ["CAManBase", 50]) > 0) then {
			hint "В зоні працюють люди!";
		};
		{ deleteVehicle _x; } forEach (_pos nearObjects ["MineBase", 150]);
		for "_i" from 1 to 25 do {
			_mine = createMine ["TrainingMine_01_F", _pos, [], 50];
		};
	},
	nil,
	1.5,
	true,
	true,
	"",
	"true", // _target, _this, _originalTarget
	3,
	false,
	"",
	""
];

a3ua_t_mine01 addAction
[
	"Міни (протипіхотні)",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _pos = getMarkerPos "mrk_t_mines00";
		if (count (_pos nearObjects ["CAManBase", 50]) > 0) then {
			hint "В зоні працюють люди!";
		};
		{ deleteVehicle _x; } forEach (_pos nearObjects ["MineBase", 150]);
		for "_i" from 1 to 25 do {
			_mine = createMine ["APERSMine", _pos, [], 50];
		};
	},
	nil,
	1.5,
	true,
	true,
	"",
	"true", // _target, _this, _originalTarget
	3,
	false,
	"",
	""
];

a3ua_t_mine01 addAction
[
	"Міни (протитанкові)",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _pos = getMarkerPos "mrk_t_mines00";
		if (count (_pos nearObjects ["CAManBase", 50]) > 0) then {
			hint "В зоні працюють люди!";
		};
		{ deleteVehicle _x; } forEach (_pos nearObjects ["MineBase", 150]);
		for "_i" from 1 to 25 do {
			_mine = createMine ["ATMine", _pos, [], 50];
		};
	},
	nil,
	1.5,
	true,
	true,
	"",
	"true", // _target, _this, _originalTarget
	3,
	false,
	"",
	""
];


/*
// Hide markers of enemy side
{
    _x setMarkerAlphaLocal 0
} count (allMapMarkers select {
    private _marker = _x;
    !([east,west,civilian,resistance] select {_marker find toLower str _x != -1} isEqualTo []) && 
    {
        _x find toLower str playerSide == -1
    }
});

// Select TFAR channel name
_TFARTS3 = ["TFARTS3",0] call BIS_fnc_getParamValue;
if (_TFARTS3 == 0) then {tf_radio_channel_name = "TaskForceRadio";};
if (_TFARTS3 == 1) then {tf_radio_channel_name = "MCCTaskForceRadio";};

*/