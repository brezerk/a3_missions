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
	
};

if (isServer) then {

	//Global task state
	task_complete_intormator = false;


	"PUB_fnc_informatorFound" addPublicVariableEventHandler {(_this select 1) call EventHander_InformatorFound};
	
	/*
	Event Handler for loaded or unloaded box
	*/
	EventHander_InformatorFound = {
		task_complete_intormator = true;
	};

	/*
	Select random Informator unit. Disable MOVE and place the trigger
		Arguments: None
		Usage: call Fn_Task_Create_Informator
	*/		
	Fn_Task_Create_Informator = {
		{
			private _size_x = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> (_x select 0) >> "radiusA");
			private _size_y = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> (_x select 0) >> "radiusB");
			private _base_count = 5 - D_DIFFICLTY + (round((_size_x max _size_y)/100));
			
			for "_i" from 1 to _base_count do {
				private _center = _x select 1;
				//private _pos = [_center, 0, 150, 1, 0, 0, 0] call BIS_fnc_findSafePos;
				private _pos = [[[_center, 50]],[]] call BIS_fnc_randomPos;
				private _builing = nearestBuilding (_pos);
				_pos = selectRandom (_builing buildingPos -1);
				if (!isNil "_pos") then {
					private _class = selectRandom [
							'C_man_polo_1_F',
							'C_man_polo_2_F',
							'C_man_polo_3_F',
							'C_man_polo_4_F',
							'C_man_polo_5_F',
							'C_man_polo_6_F',
							'C_man_1_1_F',
							'C_man_1_2_F',
							'C_man_1_3_F'
						];
					private _group = createGroup [civilian, true];
					private _unit = _group createUnit [_class, _pos, [], 0, "FORM"];
					//Keep it in place :)
					_unit setBehaviour "CARELESS";
					_unit disableAi "MOVE";
				};
			};
			
			[avaliable_locations, avaliable_pois] remoteExecCall ["Fn_Local_Create_MissionInformator", [0,-2] select isDedicated];
			
			trgRegroupIsDone = createTrigger ["EmptyDetector", getMarkerPos (format["wp_%1_airfield_01", D_LOCATION])];
			trgRegroupIsDone setTriggerArea [0, 0, 0, false];
			trgRegroupIsDone setTriggerActivation ["NONE", "PRESENT", false];
			trgRegroupIsDone setTriggerStatements [
					"task_complete_intormator && task_complete_regroup",
					"call Fn_Informator_Complete; deleteVehicle trgRegroupIsDone;",
					""
			];
		} forEach avaliable_pois;
	};

	call Fn_Task_Create_Informator;
	
	Fn_Informator_Complete = {
		if (hasInterface) then {
			remoteExecCall ["Fn_Local_Create_Task_West_WaponStash"];
		} else {
			remoteExecCall ["Fn_Local_Create_Task_West_WaponStash", -2];
		};
		call Fn_Task_Create_KillLeader;
		call Fn_Create_Mission_DestroyAmmo;
		call Fn_Create_Mission_DestroyFuel;
		call Fn_Create_Mission_DestroyWindMill;
		call Fn_Create_Mission_KillDoctor;
	};
};
