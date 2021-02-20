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
	params ["_marker"];
	
	systemChat format["Got marker: %1", _marker];
	
	enableEngineArtillery false; 

	waitUntil { alive player }; // Wait for player to initialize
	
	player setUnitLoadout (configFile >> "CfgVehicles" >> D_ROLE);
	
	if (getNumber (configfile >> "CfgVehicles" >> D_ROLE >> "attendant") == 1) then {
		if (D_MOD_ACE) then {
			player setVariable ["ace_medical_medicclass", 1, true];
			for "_i" from 1 to 20 do {player addItem "ACE_fieldDressing";};
			for "_i" from 1 to 5 do {player addItem "ACE_morphine";};
			for "_i" from 1 to 4 do {player addItem "ACE_tourniquet";};
			for "_i" from 1 to 19 do {player addItem "ACE_packingBandage";};
			for "_i" from 1 to 5 do {player addItem "ACE_epinephrine";};
			for "_i" from 1 to 10 do {player addItem "ACE_splint";};
			for "_i" from 1 to 10 do {player addItem "ACE_adenosine";};
			for "_i" from 1 to 4 do {player addItem "ACE_bloodIV_500";};
			for "_i" from 1 to 10 do {player addItem "ACE_quikclot";};
			for "_i" from 1 to 10 do {player addItem "ACE_elasticBandage";};
			player addItem "ACE_surgicalKit";
			player addItem "ACE_EarPlugs";
			player addItem "ACE_personalAidKit";
		} else {
			player setUnitTrait ["Medic", true];
		};
	} else {
		if (D_MOD_ACE) then {
			player setVariable ["ace_medical_medicclass", 0, true];
			for "_i" from 1 to 10 do {player addItem "ACE_fieldDressing";};
			for "_i" from 1 to 2 do {player addItem "ACE_tourniquet";};
			for "_i" from 1 to 6 do {player addItem "ACE_packingBandage";};
			for "_i" from 1 to 4 do {player addItem "ACE_splint";};
			for "_i" from 1 to 8 do {player addItem "ACE_quikclot";};
			for "_i" from 1 to 8 do {player addItem "ACE_elasticBandage";};
			player addItem "ACE_EarPlugs";
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
	
	player unassignItem "ItemGPS";
	player removeItem "ItemGPS";
	player linkItem "NECK_ItemConsole_F";
	
	private _pos = [];
	

	if (_marker != "") then {
		_pos = getMarkerPos _marker;
	} else {
		_pos = getPos player;
	};

	private _building = selectRandom(_pos nearObjects ["Base_WarfareBBarracks", 50]);
	if (not isNil "_building") then {
		_pos = getPos _building;
		player setPos _pos;
	} else {
		private _building = selectRandom((_pos) nearObjects ["House", 15]);
		if (not isNil "_building") then {
			private _positions = [_building] call CBA_fnc_buildingPositions;
			if ((count _positions) > 0) then {
				player setPos (selectRandom _positions);
			} else {
				player setPos _pos;
			};
		} else {
			player setPos _pos;
		};
	};
	
	/*
	private _marker = missionNamespace getVariable ["D_LOCATION", "wp_main"];
	
	if (_marker in ["wp_main", "wp_east"]) then {
		private _building = selectRandom((getMarkerPos _marker) nearObjects ["Base_WarfareBBarracks", 50]);
		player setPos (getPos _building);
	} else {
		private _building = selectRandom ((getMarkerPos _marker) nearObjects ["House", 10]);
		private _positions = [_building] call CBA_fnc_buildingPositions;
		if ((count _positions) > 0) then {
			player setPos (selectRandom _positions);
		} else {
			player setPos ([[[(getMarkerPos _marker), 30]],[]] call BIS_fnc_randomPos);
		};
	};
	*/
	
	//BG hotfix
	missionNamespace setVariable ["bg_playersdead_list", [], true];
	[false] call ace_spectator_fnc_setSpectator;
	
	sleep 3;
	missionNamespace setVariable ["bg_playersdead_list", [], true];
	[false] call ace_spectator_fnc_setSpectator;
};

waitUntil { !isNull player }; // Wait for player to initialize

player linkItem "ItemMap";

// hide markers
{if (_x find "wp_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;

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
	a3ua_mcc_health00,
	"Пнути сніговика",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"_this distance _target < 3",
	"_caller distance _target < 3",
	{},
	{},
	{
		for "_i" from 1 to 3 do {
			private _dmgType = selectRandom["bullet", "stub"];
			private _dmgLoc = selectRandom["head", "body", "leftarm", "rightarm", "leftleg", "rightleg"];
			private _dmg = (random 4) + 1;
			[player, (0.1 * _dmg), _dmgLoc, _dmgType] call ace_medical_fnc_addDamageToUnit;
		}; 
	},
	{ },
	[],
	2,
	nil,
	false,
	false] call BIS_fnc_holdActionAdd;
	
{if (_x find "wp_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;

[
	a3ua_mcc_medic02,
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
	a3ua_mcc_health00,
	"Пнути сніговика",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"_this distance _target < 3",
	"_caller distance _target < 3",
	{},
	{},
	{
		for "_i" from 1 to 3 do {
			private _dmgType = selectRandom["bullet", "stub"];
			private _dmgLoc = selectRandom["head", "body", "leftarm", "rightarm", "leftleg", "rightleg"];
			private _dmg = (random 4) + 1;
			[player, (0.1 * _dmg), _dmgLoc, _dmgType] call ace_medical_fnc_addDamageToUnit;
		}; 
	},
	{ },
	[],
	2,
	nil,
	false,
	false] call BIS_fnc_holdActionAdd;
	
{if (_x find "wp_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;
{if (_x find "respawn" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;

/*
[
	a3ua_mcc_medic03,
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
	false] call BIS_fnc_holdActionAdd;*/
	
a3ua_mcc_medic01 setVariable ['neck_noSurrender', true];
a3ua_mcc_medic02 setVariable ['neck_noSurrender', true];
//a3ua_mcc_medic03 setVariable ['neck_noSurrender', true];

[
	a3ua_mcc_health00,
	"Пнути сніговика",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"_this distance _target < 3",
	"_caller distance _target < 3",
	{},
	{},
	{
		for "_i" from 1 to 3 do {
			private _dmgType = selectRandom["bullet", "stub"];
			private _dmgLoc = selectRandom["head", "body", "leftarm", "rightarm", "leftleg", "rightleg"];
			private _dmg = (random 4) + 1;
			[player, (0.1 * _dmg), _dmgLoc, _dmgType] call ace_medical_fnc_addDamageToUnit;
		}; 
	},
	{ },
	[],
	2,
	nil,
	false,
	false] call BIS_fnc_holdActionAdd;

[
	a3ua_t_house01,
	"Заспавнити ворогів",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
	"_this distance _target < 3",
	"_caller distance _target < 3",
	{},
	{},
	{
		0 = [] spawn {
			private _bots = ['rhs_vdv_recon_medic', 'rhs_vdv_recon_rifleman_l', 'rhs_vdv_recon_marksman_asval', 'rhs_vdv_recon_rifleman', 'rhs_vdv_recon_rifleman_akms'];
			private _pos = getMarkerPos "mrk_t_house00";
			if (count (_pos nearObjects ["CAManBase", 15]) > 0) then {
				hint "В зоні є люди!";
			};
			{
				private _hpos = _x buildingPos -1;
				for "_i" from 1 to (random 2) do {
					private _pos = selectRandom _hpos;
					private _class = selectRandom _bots;
					private _grp = createGroup east;
					private _unit = _grp createUnit [_class, _pos, [], 0, "FORM"];
					_unit disableAI "MOVE";
					_unit setBehaviour "COMBAT";
					_unit setCombatMode "RED";
				};
			} forEach [a3ua_mcc_house01, a3ua_mcc_house02, a3ua_mcc_house03, a3ua_mcc_house04, a3ua_mcc_house05];
		};
	},
	{ },
	[],
	2,
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

cqb_book_01 addAction
[
	"Розпочати тренування",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _pos = getMarkerPos "mrk_t_mines00";
		if (count (_pos nearObjects ["CAManBase", 25]) > 0) then {
			hint "В зоні працюють люди!";
		};
		[50, iCenter] remoteExecCall ["CQB_Reset", 2]; 
		hint "Готово!";
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

[a3ua_info01, "data\traning\RPG-7V2.paa", ""] call BIS_fnc_initInspectable; 



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