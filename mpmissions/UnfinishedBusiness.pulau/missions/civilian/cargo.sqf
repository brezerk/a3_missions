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
			private _myPlaces = selectBestPlaces [_center, 600, "(1 + forest * 10 + trees) * (1 - sea) * (1 - houses) * (1 - meadow)", 15, 1];

			private _markerPos = selectRandom _myPlaces select 0;

			private _mark = createMarker [format ["civ_stash_0%1", _forEachIndex], _markerPos];
			_mark setMarkerType "hd_destroy";
			_mark setMarkerAlpha 0;
			
			"Land_TentDome_F" createVehicle ([((_markerPos select 0) - 4), ((_markerPos select 1) + 10), 0]); 
			"FirePlace_burning_F" createVehicle ([((_markerPos select 0) - 3), ((_markerPos select 1) + 9), 0]); 

			[_markerPos] call Fn_Task_Civilian_WaponStash_SpawnRandomCargo;
		} forEach avaliable_pois;
	};
	
	Fn_Task_Civilian_WaponStash_SpawnRandomCargo = {
		params ["_markerPos"];
		private ["_obj"];
		
		_obj = "Box_FIA_Wps_F" createVehicle (_markerPos);
		[_obj, "base", civilian, D_FRACTION_CIV] call BrezBlock_fnc_PopulateBaseSupply;
	};

	Fn_Task_Create_Civilian_FloodedShip = {
		private _blacklist = [];
		private _myPlaces = [];
		switch(D_LOCATION) do
		{
			case "Gurun": {
				_blacklist = [
					'Kambani',
					'Bibung',
					'Loholoho'
				];
			};
			case "Monyet": {
				_blacklist = [
					'Tinobu'
				];
			};
		};
		{
			if (!((_x select 0) in _blacklist)) then {
				_myPlaces pushBackUnique (_x select 1);
			};
		} forEach avaliable_pois;
		if (count _myPlaces > 0) then {
			private _center =  selectRandom _myPlaces;
			_myPlaces = [];
			_myPlaces = selectBestPlaces [_center, 1000, "((waterDepth factor [10,30])/(1 + waterDepth))", 15, 1];
			if (count _myPlaces > 0) then {
				private _markerPos = selectRandom _myPlaces select 0;

				private _mark = createMarker ["civ_ship_01", _markerPos];
				_mark setMarkerType "hd_destroy";
				_mark setMarkerAlpha 0;

				//spawn creater and wreck
				"Crater" createVehicle (_markerPos); 
				private _obj = "Land_Wreck_Traw_F" createVehicle ([((_markerPos select 0) - 5), ((_markerPos select 1) + 20), 0]); 
				_obj = "Land_Wreck_Traw2_F" createVehicle ([((_markerPos select 0) - 5), ((_markerPos select 1) - 10), 0]); 
				
				[_markerPos] call Fn_Task_Civilian_FloodedShip_SpawnRandomCargo;
			};
		};
	};
	
	Fn_Task_Spawn_Boats = {
		params ["_poi"];
		private _blacklist = [];
		
		//Avoid spawning boats for certain locations (to far from sea, bad location, e.t.c.)
		switch(D_LOCATION) do
		{
			case "Gurun": {
				_blacklist = [
					'Kambani',
					'Bibung',
					'Loholoho'
				];
			};
			case "Monyet": {
				_blacklist = [
					'Tinobu'
				];
			};
		};

		{
			if (!((_x select 0) in _blacklist)) then {
				private _center = _x select 1;
				private _myPlaces = selectBestPlaces [_center, 600, "((waterDepth factor [1,1.4])/(1 + waterDepth))", 15, 4];
				{
					private _pos = _x select 0;
					private _obj = ((selectRandom D_FRACTION_CIV_UNITS_BOATS) createVehicle (_pos));
					_obj addItemCargoGlobal ["V_RebreatherIA", 5];
					_obj addItemCargoGlobal ["I_Assault_Diver", 5];
					_obj addItemCargoGlobal ["G_I_Diving", 5];
					if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
						_obj addItemCargoGlobal ["ACE_EarPlugs", 5];
					};
				} forEach _myPlaces;
			};
		} forEach _poi;
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
			[_obj, "ship", civilian, D_FRACTION_CIV] call BrezBlock_fnc_PopulateBaseSupply;
			[["Done", "PLAIN"]] remoteExec ["cutText", _caller];
		};
	};
};