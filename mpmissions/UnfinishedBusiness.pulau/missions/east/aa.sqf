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
		private _class = (selectRandom ([east, D_FRACTION_EAST, "antiair"] call Fn_Config_GetFraction_Units));
		obj_east_antiair = createVehicle [_class, _pos];
		obj_east_antiair setDir (markerDir _marker);
		private _crew = createVehicleCrew (obj_east_antiair);
		obj_east_antiair addEventHandler [
			"HandleDamage", {
				private _object = _this select 0;
				private _projectile = _this select 4;
				if ( _projectile isKindOf "PipeBombBase" ) then {
					_object setDammage 1;
				};
			}
		];
		
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
		remoteExecCall ["Fn_Local_Create_MissionAA", [0,-2] select isDedicated];
	};
	
	Fn_Task_AA_Complete = {
		remoteExecCall ["Fn_Local_Task_AA_Complete", [0,-2] select isDedicated];
		task_complete_antiair = true;
	};

};