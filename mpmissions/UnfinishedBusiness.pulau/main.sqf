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

_westHQ = createCenter west;
_eastHQ = createCenter east;
_indepHQ = createCenter independent;
_civilianHQ = createCenter civilian;

assault_group = [];


//[] execVM "missions\informator.sqf";
//[] execVM "missions\aa.sqf";
[] execVM "missions\intro.sqf";
[] execVM "missions\patrols.sqf";
[] execVM "missions\aa.sqf";
[] execVM "missions\leader.sqf";

if (isServer) then {

	Fn_Endgame = {
		params["_endingType"];
		if (isServer) then {
			_endingType call BIS_fnc_endMissionServer;
		};
	};

	Fn_Endgame_Loss = {
		if (isServer) then {
			//['t_defend_blockpost', 'FAILED'] call BIS_fnc_taskSetState;
			"EveryoneLost" call BIS_fnc_endMissionServer;
		};
	};

	Fn_Endgame_Win = {
		if (isServer) then {
			"EveryoneWon" call BIS_fnc_endMissionServer;
		};
	};
	
	sleep 5;
	
	call Fn_Create_MissionIntro;
	

	addMissionEventHandler ["EntityKilled",{
		params ["_killed", "_killer", "_instigator"];
		if (isNull _instigator) then {_instigator = UAVControl vehicle _killer select 0}; // UAV/UGV player operated road kill
		if (isNull _instigator) then {_instigator = _killer}; // player driven vehicle road kill
		systemChat format ["some %1 one died %2 %3", side group _killed, side group _killer, side group _instigator];
		if (isPlayer _instigator) then {
			systemChat "ok. _instigator is a plyer";
			if ((side group _instigator in [east, independent, civilian]) && (side group _killed in [east, independent])) then {
				systemChat "player killed an east or indep!";
			};
		};
	}];
};

// We need to end game if all players are no longer alive
//[] execVM "addons\brezblock\triggers\end_game.sqf";
