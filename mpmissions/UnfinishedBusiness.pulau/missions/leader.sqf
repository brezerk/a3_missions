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
if (hasInterface) then { };

if (isServer) then {

	Fn_Task_Create_KillLeader = {
		private['_trg'];
		_trg = createTrigger ["EmptyDetector", getPos target_Gurun_01];
		_trg setTriggerArea [0, 0, 0, false];
		_trg setTriggerActivation ["NONE", "PRESENT", false];
		_trg setTriggerStatements [
			format["!alive target_%1_01;", D_LOCATION],
			"if (isServer) then { call Fn_Task_KillLeader_Complete };",
			""
		];
		
		if (hasInterface) then {
			[D_LOCATION] remoteExecCall ["Fn_Local_Create_KillLeader"];
		} else {
			[D_LOCATION] remoteExecCall ["Fn_Local_Create_KillLeader", -2];
		};
		
	};
	
	Fn_Task_KillLeader_Complete = {
		['t_kill_leader', 'SUCCEEDED'] call BIS_fnc_taskSetState;
		call Fn_Endgame_LeaderKilled;
	};

};