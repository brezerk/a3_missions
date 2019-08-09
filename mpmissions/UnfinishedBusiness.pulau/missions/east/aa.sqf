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
if (hasInterface) then {};

if (isServer) then {
	
	Fn_Spawn_East_AntiAir = {
		private _marker = "mrk_aa";
		private _pos = getMarkerPos _marker;
		private _class = "CUP_O_2S6_RU";
		obj_east_antiair = createVehicle [_class, _pos];
		obj_east_antiair setDir (markerDir _marker);
		private _crew = createVehicleCrew (obj_east_antiair);
		
		publicVariable "obj_east_antiair";
		
		private['_trg'];
		_trg = createTrigger ["EmptyDetector", getPos obj_east_antiair];
		_trg setTriggerArea [0, 0, 0, false];
		_trg setTriggerActivation ["NONE", "PRESENT", false];
		_trg setTriggerStatements [
			"!alive obj_east_antiair || !canFire obj_east_antiair;",
			"call Fn_Task_AA_Complete; deleteVehicle thisTrigger;",
			""
		];
	};

	Fn_Task_Create_AA = {
		if (hasInterface) then {
			remoteExecCall ["Fn_Local_Create_MissionAA"];
		} else {
			remoteExecCall ["Fn_Local_Create_MissionAA", -2];
		};
	};
	
	Fn_Task_AA_Complete = {
		if (hasInterface) then {
			remoteExecCall ["Fn_Local_Task_AA_Complete"];
		} else {
			remoteExecCall ["Fn_Local_Task_AA_Complete", -2];
		};

		task_complete_antiair = true;
	};

};