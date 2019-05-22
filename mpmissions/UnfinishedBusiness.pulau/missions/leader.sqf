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
Spawn start objectives, triggers for informator contact
*/

//Player side triggers
// Client side code
if (hasInterface) then {
	private ["_trg"];
	_trg = createTrigger ["EmptyDetector", getMarkerPos "wp_air_field_01"];
	_trg setTriggerArea [500, 500, 0, false];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setTriggerStatements [
		"(vehicle player) in thisList",
		"[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_07', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;",
		""
	];
	
	private ["_trg"];
	_trg = createTrigger ["EmptyDetector", getMarkerPos "wp_kambani"];
	_trg setTriggerArea [150, 150, 0, false];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setTriggerStatements [
		"(vehicle player) in thisList",
		"[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_08', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;",
		""
	];
	
	
};

if (isServer) then {

	Fn_Task_Create_KillLeader = {
		private['_trg'];
		[
			west,
			"t_kill_leader",
			[localize "TASK_08_DESC",
			localize "TASK_08_TITLE",
			localize "TASK_ORIG_01"],
			getMarkerPos "wp_air_field_01",
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_kill_leader', "kill"] call BIS_fnc_taskSetType;
		_trg = createTrigger ["EmptyDetector", getPos e_pvo_01];
		_trg setTriggerArea [0, 0, 0, false];
		_trg setTriggerActivation ["NONE", "PRESENT", false];
		_trg setTriggerStatements [
			"!alive target_01;",
			"if (isServer) then { call Fn_Task_KillLeader_Complete };",
			""
		];
	};
	
	Fn_Task_KillLeader_Complete = {
		['t_kill_leader', 'SUCCEEDED'] call BIS_fnc_taskSetState;
		sleep 5;
		call Fn_Endgame_Win;
	};

};