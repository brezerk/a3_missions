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

if (isServer) then {

	Fn_Task_Create_Civilian_WaponStash = {
		//params ["_markerPos"];
		
		{
			private _center = _x select 1;
			private _myPlaces = selectBestPlaces [_center, 1500, "(1 + forest * 10 + trees) * (1 - sea) * (1 - houses) * (1 - meadow)", 15, 1];

			private _markerPos = selectRandom _myPlaces select 0;

			private _mark = createMarker [format ["civ_stash_0%1", _forEachIndex], _markerPos];
			_mark setMarkerType "hd_destroy";
			_mark setMarkerAlpha 0;
			
			"Land_TentDome_F" createVehicle ([((_markerPos select 0) - 4), ((_markerPos select 1) + 10), 0]); 
			"FirePlace_burning_F" createVehicle ([((_markerPos select 0) - 3), ((_markerPos select 1) + 9), 0]); 

			[_markerPos] call Fn_Task_Civilian_WaponStash_SpawnRandomCargo;
		} forEach avaliable_pois;
		
		
		/*
		[[
			synd_boat_01,
			synd_boat_02
		]] call Fn_Patrols_Create_Random_SeaWaypoints;*/
		
		//locationFloodedShip = _markerPos;
		//publicVariable "locationFloodedShip";
		
		//call Fn_Task_Spawn_Boats;
	};
	
	Fn_Task_Civilian_WaponStash_SpawnRandomCargo = {
		params ["_markerPos"];
		private ["_obj"];
		
		_obj = "Box_FIA_Wps_F" createVehicle (_markerPos);
		
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
			
		_obj addWeaponCargoGlobal ["CUP_hgun_M9", 7];
		_obj addWeaponCargoGlobal ["Binocular", 3];
		_obj addWeaponCargoGlobal ["CUP_arifle_AK74", 5];
		_obj addWeaponCargoGlobal ["CUP_arifle_AKS74U", 7];
		_obj addWeaponCargoGlobal ["CUP_sgun_M1014", 25];
		_obj addMagazineCargoGlobal ["CUP_15Rnd_9x19_M9", 25];
		_obj addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK_M", 11];
		_obj addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK74_plum_M", 15];
		_obj addMagazineCargoGlobal ["CUP_8Rnd_B_Beneli_74Slug", 25];
		_obj addMagazineCargoGlobal ["CUP_8Rnd_B_Beneli_74Pellets", 25];
		_obj addItemCargoGlobal ["ACE_EarPlugs", 5];
		_obj addItemCargoGlobal ["ItemCompass", 4];
		_obj addItemCargoGlobal ["ACE_fieldDressing", 20];
		_obj addItemCargoGlobal ["ACE_morphine", 10];
		_obj addItemCargoGlobal ["ACE_epinephrine", 6];
		_obj addItemCargoGlobal ["ACE_bloodIV", 20];
		_obj addBackpackCargoGlobal ["B_Kitbag_tan", 5];
			
		if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
				_obj addItemCargoGlobal ["ACRE_PRC148", 2];
				_obj addItemCargoGlobal ["ACRE_PRC343", 6];
			} else {
				if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
					_obj addItemCargoGlobal ["tf_anprc148jem", 2];
					_obj addItemCargoGlobal ["tf_anprc152", 6];
				} else {
					comment "Fallback to native arma3 radio";
					_obj addItemCargoGlobal ["ItemRadio", 6];
				};
		};

	};

	Fn_Task_Create_Civilian_FloodedShip = {
		//params ["_markerPos"];
		
		private _center = selectRandom avaliable_pois select 1;
		private _myPlaces = selectBestPlaces [_center, 2000, "((waterDepth factor [10,30])/(1 + waterDepth))", 15, 1];

		private _markerPos = selectRandom _myPlaces select 0;

		private _mark = createMarker ["civ_ship_01", _markerPos];
		_mark setMarkerType "hd_destroy";
		_mark setMarkerAlpha 0;

		//spawn creater and wreck
		"Crater" createVehicle (_markerPos); 
		private _obj = "Land_Wreck_Traw_F" createVehicle ([((_markerPos select 0) - 5), ((_markerPos select 1) + 20), 0]); 
		_obj = "Land_Wreck_Traw2_F" createVehicle ([((_markerPos select 0) - 5), ((_markerPos select 1) - 10), 0]); 
		
		[_markerPos] call Fn_Task_Civilian_FloodedShip_SpawnRandomCargo;
		/*
		[[
			synd_boat_01,
			synd_boat_02
		]] call Fn_Patrols_Create_Random_SeaWaypoints;*/
		
		locationFloodedShip = _markerPos;
		publicVariable "locationFloodedShip";
		
		call Fn_Task_Spawn_Boats;
	};
	
	Fn_Task_Spawn_Boats = {
		private _boats = [
			'C_Boat_Civil_01_F',
			'C_Rubberboat',
			'C_Boat_Civil_01_rescue_F',
			'CUP_C_Fishing_Boat_Chernarus'		
		];
		{
			private _center = _x select 1;
			private _myPlaces = selectBestPlaces [_center, 600, "((waterDepth factor [1,1.4])/(1 + waterDepth))", 15, 2];
			{
				private _pos = _x select 0;
				private _obj = selectRandom _boats createVehicle (_pos);
				_obj addItemCargoGlobal ["V_RebreatherIA", 5];
				_obj addItemCargoGlobal ["I_Assault_Diver", 5];
				_obj addItemCargoGlobal ["G_I_Diving", 5];
			} forEach _myPlaces;
		
		} forEach avaliable_pois;
	};
	
	
	/*
	Spawn cargo crate randomly. Remove all predefined items and populate with a desired ones;
		Arguments: [spawn marker]
		Usage: [{SpawnMarker}]] call Fn_Task_Create_ArriveToIsland_SpawnRandomCargo;
		Return: create object
	*/
	Fn_Task_Civilian_FloodedShip_SpawnRandomCargo = {
		params ["_markerPos"];
		private ["_obj"];
		
		_obj = "B_supplyCrate_F" createVehicle ([((_markerPos select 0) + (round(random 25) - 10)), ((_markerPos select 1) + (round(random 25) - 10)), 0]);
		
		clearWeaponCargoGlobal _obj;
		clearMagazineCargoGlobal _obj;
		clearItemCargoGlobal _obj;
		clearBackpackCargoGlobal _obj;
			
		_action_id = [
			_obj,
			{ [_caller] remoteExec ["Fn_Task_Civilian_AddCargoToBoat", 2]; },
			"simpleTasks\types\boat",
			"ACTION_05",
			"",
			30,
			false
		] call BrezBlock_fnc_Attach_Hold_Action;	
			
		//_target setPosASL [getPos _target select 0, getPos _target select 1, 0];
		//_obj addAction [localize 'ACTION_04', { private['_target']; _target = _this select 0; _target tachTo [invisble_01, [0,0,0]]; }, nil, 1, false, true, "", "alive _this", 5];
		//_obj addAction [localize 'ACTION_05', { [_this select 1] call Fn_Task_Civilian_AddCargoToBoat; }, nil, 1, false, true, "", "alive _this", 5];
		_obj;
	};
	
	Fn_Task_Civilian_AddCargoToBoat = {
		params['_caller'];
		private _obj = nearestObjects [_caller, ["Ship"], 150];
		if ((count _obj) == 0) then {
			[["No Boat nearby", "PLAIN"]] remoteExec ["cutText", _caller];
		} else {
			if (_caller getVariable ["is_civilian", false]) then {
				_task = ['t_civ_boat', _caller] call BIS_fnc_taskReal;
				if (!isNull _task) then {
					_task setTaskState "Succeeded";
				};
			};
			_obj = _obj select 0;
			_obj addWeaponCargoGlobal ["CUP_hgun_M9", 2];
			_obj addWeaponCargoGlobal ["Binocular", 3];
			_obj addWeaponCargoGlobal ["CUP_arifle_AK74", 5];
			_obj addWeaponCargoGlobal ["CUP_arifle_AKS74U", 7];
			_obj addWeaponCargoGlobal ["CUP_launch_Igla", 2];
			_obj addWeaponCargoGlobal ["CUP_launch_RPG7V", 2];
			_obj addMagazineCargoGlobal ["CUP_15Rnd_9x19_M9", 10];
			_obj addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK_M", 11];
			_obj addMagazineCargoGlobal ["CUP_30Rnd_545x39_AK74_plum_M", 15];
			_obj addMagazineCargoGlobal ["CUP_20Rnd_762x51_DMR", 5];
			_obj addMagazineCargoGlobal ["CUP_OG7_M", 5];
			_obj addMagazineCargoGlobal ["CUP_PG7V_M", 5];
			_obj addItemCargoGlobal ["ACE_EarPlugs", 5];
			_obj addItemCargoGlobal ["ItemCompass", 4];
			_obj addItemCargoGlobal ["ACE_fieldDressing", 20];
			_obj addItemCargoGlobal ["ACE_morphine", 10];
			_obj addItemCargoGlobal ["ACE_epinephrine", 6];
			_obj addItemCargoGlobal ["ACE_bloodIV", 20];
			_obj addBackpackCargoGlobal ["B_Kitbag_tan", 5];
				
			if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
					_obj addItemCargoGlobal ["ACRE_PRC148", 2];
					_obj addItemCargoGlobal ["ACRE_PRC343", 6];
				} else {
					if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
						_obj addItemCargoGlobal ["tf_anprc148jem", 2];
						_obj addItemCargoGlobal ["tf_anprc152", 6];
					} else {
						comment "Fallback to native arma3 radio";
						_obj addItemCargoGlobal ["ItemRadio", 6];
					};
			};
			[["Done", "PLAIN"]] remoteExec ["cutText", _caller];
		};
	};
};