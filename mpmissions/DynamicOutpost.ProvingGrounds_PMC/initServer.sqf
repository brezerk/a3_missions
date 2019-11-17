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
Server init file
*/

main_story_started = false;
task_completed_00 = false; // officer
task_completed_01 = false; // patrol
task_completed_02 = false; // heli
task_completed_03 = false; // inform
task_completed_04 = false; // inform docs
task_completed_05 = false; // heli docs
task_completed_06 = false; // patrol docs
task_completed_07 = false; // spotter
task_completed_08 = false; // spotter docs

publicVariable "task_completed_00";
publicVariable "task_completed_01";
publicVariable "task_completed_02";
publicVariable "task_completed_03";
publicVariable "task_completed_04";
publicVariable "task_completed_05";
publicVariable "task_completed_06";
publicVariable "task_completed_07";
publicVariable "task_completed_08";

//remove AI-controled unis for playable objects
{
	_x addMPEventHandler ["MPRespawn", {
		_unit = _this select 0;
		if (!isPlayer _unit) exitWith {
			deleteVehicle _unit
		}
	}]
} forEach playableUnits;

[ 
	true, 
	[
		[ independent , 0.2, 0.2, 0.8, 0.5 ],
		[ EAST		  , 0.2, 0.2, 0.3, 0.3 ] 
	]
] call BIS_fnc_EXP_camp_dynamicAISkill;
