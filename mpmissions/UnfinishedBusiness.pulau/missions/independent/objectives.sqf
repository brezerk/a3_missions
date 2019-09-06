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
	task_complete_ammo = false;
	task_complete_fuel = false;
	task_complete_wind = false;
	task_complete_lab = false;
	
	indep_ammo_01 = objNull;
	indep_fuel_01 = objNull;
	indep_wind_01 = objNull;
	indep_lab_01 = objNull;
	
	Fn_Task_Spawn_Indep_Objectives = {
		params['_center'];
		//Land_Research_HQ_F, Land_Cargo_HQ_V4_F
		private _classes = ["Land_Medevac_house_V1_F", "Land_Cargo_Patrol_V1_F", "Land_wpp_Turbine_V1_off_F", "Land_dp_smallTank_F"];
		private _markers = [_center, ["n_mortar"], 3000] call BrezBlock_fnc_GetAllMarkerTypesInRange;
		
		for "_i" from 1 to 2 do {
			private _marker = selectRandom (_markers);
			private _center = getMarkerPos (_marker);
			private _dir = markerDir _marker;
			private _pos = [_center, 9, _dir + 90] call BIS_Fnc_relPos;
			private _obj = createVehicle ["CUP_O_Ural_Reammo_RU", _pos, [], 0, "CAN_COLLIDE"];
			_obj setDir _dir;
						
			private _unitRef = ["defence_point", _center, [0,0,0], 0, true] call LARs_fnc_spawnComp;
			
			private _class = selectRandom (_classes);
			_classes = _classes - [_class];
			switch (_class) do {
				case 'Land_Medevac_house_V1_F': {
					private _obj = createVehicle [_class, _center];
					_obj setVectorUp [0,0,1];
					//_obj setDir _dir;
					private _pos = selectRandom (_obj buildingPos -1);
					if (!isNil "_pos") then {
						private _group = createGroup [independent, true];
						indep_lab_01 = _group createUnit ["C_scientist_F", _pos, [], 0, "FORM"];
						indep_lab_01 allowDamage true;
					};
					private _trg = createTrigger ["EmptyDetector", getPos indep_lab_01];
					_trg setTriggerArea [0, 0, 0, false];
					_trg setTriggerActivation ["NONE", "PRESENT", false];
					_trg setTriggerStatements [
						"!alive indep_lab_01",
						"call Fn_Task_DestroyAmmo_Complete; deleteVehicle thisTrigger;",
						""
					];
				};
				case 'Land_Cargo_Patrol_V1_F': {
					private _obj = createVehicle [_class, _center];
					_obj setVectorUp [0,0,1];

					private _dir = markerDir _marker;
					private _pos = [_center, 8, _dir] call BIS_Fnc_relPos;
					indep_ammo_01 = createVehicle ["B_Slingload_01_Ammo_F", _pos, [], 0, "CAN_COLLIDE"]; // Land_Pallet_MilBoxes_F
					indep_ammo_01 setDir (_dir + 90);
					indep_ammo_01 allowDamage true;
					private _trg = createTrigger ["EmptyDetector", getPos indep_ammo_01];
					_trg setTriggerArea [0, 0, 0, false];
					_trg setTriggerActivation ["NONE", "PRESENT", false];
					_trg setTriggerStatements [
						"!alive indep_ammo_01",
						"call Fn_Task_DestroyAmmo_Complete; deleteVehicle thisTrigger;",
						""
					];
				};
				case 'Land_wpp_Turbine_V1_off_F': {
					indep_wind_01 = createVehicle [_class, _center];
					indep_wind_01 setVectorUp [0,0,1];
					indep_wind_01 allowDamage true;
					private _trg = createTrigger ["EmptyDetector", getPos indep_wind_01];
					_trg setTriggerArea [0, 0, 0, false];
					_trg setTriggerActivation ["NONE", "PRESENT", false];
					_trg setTriggerStatements [
						"!alive indep_wind_01",
						"call Fn_Task_DestroyWindMill_Complete; deleteVehicle thisTrigger;",
						""
					];
				};
				case 'Land_dp_smallTank_F': {
					indep_fuel_01 = createVehicle [_class, _center];
					indep_fuel_01 setVectorUp [0,0,1];
					indep_fuel_01 allowDamage true;
					private _trg = createTrigger ["EmptyDetector", getPos indep_fuel_01];
					_trg setTriggerArea [0, 0, 0, false];
					_trg setTriggerActivation ["NONE", "PRESENT", false];
					_trg setTriggerStatements [
						"!alive indep_fuel_01",
						"call Fn_Task_DestroyFuel_Complete; deleteVehicle thisTrigger;",
						""
					];
				};
			};
			
			[_center, resistance, 2, 150] call BrezBlock_fnc_CreatePatrol;
			[_center, resistance, 2, 150] call BrezBlock_fnc_CreatePatrol;
			[_center, resistance, 5, 20] call BrezBlock_fnc_CreateDefend;
			[_center, resistance, 5, 20] call BrezBlock_fnc_CreateGarrison;
			
			//Remove marker
			_markers = _markers - [_marker];
			deleteMarker _marker;
		};
	};
	
	Fn_Create_Mission_DestroyAmmo = {
		params['_requestor'];
		if (!isNull indep_ammo_01) then {
			if (_requestor in assault_group) then {
				if (task_complete_regroup) then {
					{
						[(getPos indep_ammo_01)] remoteExecCall ["Fn_Local_Create_Mission_DestroyAmmo", _x];
					} forEach assault_group;
				} else {
					shared_missions pushBack "Fn_Local_Create_Mission_DestroyAmmo";
				};
			};
			[(getPos indep_ammo_01)] remoteExecCall ["Fn_Local_Create_Mission_DestroyAmmo", _requestor];
		};
	};
	
	Fn_Create_Mission_DestroyFuel = {
		params['_requestor'];
		if (!isNull indep_fuel_01) then {
			if (_requestor in assault_group) then {
				if (task_complete_regroup) then {
					{
						[(getPos indep_fuel_01)] remoteExecCall ["Fn_Local_Create_Mission_DestroyFuel", _x];
					} forEach assault_group;
				} else {
					shared_missions pushBack "Fn_Local_Create_Mission_DestroyFuel";
				};
			};
			[(getPos indep_fuel_01)] remoteExecCall ["Fn_Local_Create_Mission_DestroyFuel", _requestor];
		};
	};
	
	Fn_Create_Mission_DestroyWindMill = {
		params['_requestor'];
		if (!isNull indep_wind_01) then {
			if (_requestor in assault_group) then {
				if (task_complete_regroup) then {
					{
						[(getPos indep_wind_01)] remoteExecCall ["Fn_Local_Create_Mission_DestroyWindMill", _x];
					} forEach assault_group;
				} else {
					shared_missions pushBack "Fn_Local_Create_Mission_DestroyWindMill";
				};
			};
			[(getPos indep_wind_01)] remoteExecCall ["Fn_Local_Create_Mission_DestroyWindMill", _requestor];			
		};
	};
	
	Fn_Create_Mission_KillDoctor = {
		params['_requestor'];
		if (!isNull indep_lab_01) then {
			if (_requestor in assault_group) then {
				if (task_complete_regroup) then {
					{
						[(getPos indep_lab_01)] remoteExecCall ["Fn_Local_Create_Mission_KillDoctor", _x];
					} forEach assault_group;
				} else {
					shared_missions pushBack "Fn_Local_Create_Mission_KillDoctor";
				};
			};
			[(getPos indep_lab_01)] remoteExecCall ["Fn_Local_Create_Mission_KillDoctor", _requestor];	
		};
	};
	
	Fn_Task_DestroyAmmo_Complete = {
		if (!isNull indep_ammo_01) then {
			{
				[(getPos indep_ammo_01)] remoteExecCall ["Fn_Local_Task_DestroyAmmo_Complete", _x];
			} forEach assault_group;
		};
	};
	
	Fn_Task_DestroyFuel_Complete = {
		if (!isNull indep_fuel_01) then {
			{
				[(getPos indep_fuel_01)] remoteExecCall ["Fn_Local_Task_DestroyFuel_Complete", _x];
			} forEach assault_group;
		};
	};
	
	Fn_Task_DestroyWindMill_Complete = {
		if (!isNull indep_wind_01) then {
			{
				[(getPos indep_wind_01)] remoteExecCall ["Fn_Local_Task_DestroyWindMill_Complete", _x];
			} forEach assault_group;
		};
	};
	
	Fn_Task_KillDoctor_Complete = {
		if (!isNull indep_lab_01) then {
			{
				[(getPos indep_lab_01)] remoteExecCall ["Fn_Local_Task_KillDoctor_Complete", _x];
			} forEach assault_group;
		};
	};
	
	
};
