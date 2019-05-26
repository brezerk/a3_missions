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

Fn_Local_FailTasks = {
	['t_crash_site', 'FAILED'] call BIS_fnc_taskSetState;
	['t_regroup', 'FAILED'] call BIS_fnc_taskSetState;
	['t_find_informator', 'FAILED'] call BIS_fnc_taskSetState;
};


Fn_Jet_GetOut = {
		[0, 5] execVM "addons\brezblock\utils\fade.sqf";
		doGetOut player;
		moveOut player;
	};
	
	Fn_Jet_Player_DoParadrop = {
		private ['_dmgType'];
		[] execVM "gear\player.sqf";
		//do some damage
		_dmgType = ["leg_l", "leg_r", "hand_r", "hand_l", "head"];
		[player, 1, selectRandom _dmgType, "bullet"] call ace_medical_fnc_addDamageToUnit;
		[1, 3] execVM "addons\brezblock\utils\fade.sqf";
		player setUnconscious true;
	};
	
	Fn_Jet_Player_Land = {
		player setUnconscious false;
		[
			player,
			"t_find_informator",
			[localize "TASK_05_DESC",
			localize "TASK_05_TITLE",
			localize "TASK_ORIG_01"],
			objNull,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_find_informator', "talk"] call BIS_fnc_taskSetType;
		[
			player,
			"t_regroup",
			[localize "TASK_03_DESC",
			localize "TASK_03_TITLE",
			localize "TASK_ORIG_01"],
			objNull,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_regroup', "meet"] call BIS_fnc_taskSetType;
		[
			player,
			"t_crash_site",
			[localize "TASK_04_DESC",
			localize "TASK_04_TITLE",
			localize "TASK_ORIG_01"],
			objNull,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_crash_site', "unknown"] call BIS_fnc_taskSetType;
	};

	Fn_FastTravel_Sleep = {
		if (alive player) then {
			playSound "radio_chatter_00";
			playSound "rhs_usa_land_rc_2";
			[0, 5] execVM "addons\brezblock\utils\fade.sqf";
		};
	};
	
	Fn_FastTravel_Wokeup = {
		if (alive player) then {
			playSound "radio_chatter_01";
			playSound "rhs_usa_land_rc_5";
			[1, 5] execVM "addons\brezblock\utils\fade.sqf";
		};
	};

//tickets
[player, 3] call BIS_fnc_respawnTickets;

// hide markers
{if (_x find "wp_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;
{if (_x find "respawn_" >= 0) then {_x setMarkerAlpha 0};} forEach allMapMarkers;

sleep 5;

[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_00', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;


[[west], [east,independent,civilian]] call ace_spectator_fnc_updateSides;
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