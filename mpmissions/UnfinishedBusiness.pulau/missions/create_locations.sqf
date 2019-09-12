
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

if (isServer) then {

	Fn_Task_Attack_City = {
		params['_marker'];
		private _pos = (getMarkerPos _marker);

		[_pos, 1] call Fn_Patrols_Create_AssaultGroup;
	};

	private _crashSitePos = getMarkerPos "mrk_west_crashsite";

	call Fn_Spawn_East_AntiAir;
	[_crashSitePos] call Fn_Spawn_East_Comtower;
	call Fn_Spawn_East_Helicopter;
	[_crashSitePos] call Fn_Task_Spawn_Indep_Objectives;
	
	private _ret = [_crashSitePos, 2000, 2] call BrezBlock_fnc_GetAllCitiesInRange;
	//Get all POI in the range of 3000m
	avaliable_locations = _ret select 0;
	avaliable_pois = _ret select 1;
	
	publicVariable "avaliable_pois";

	[_crashSitePos, 1500] execVM "addons\brezblock\utils\controller.sqf";
	[_crashSitePos, 1500, 80] execVM "addons\brezblock\utils\spawn_objects.sqf";

	//Create markers
	{ 
		private _mark = createMarker [format ["mrk_city_%1", _forEachIndex], _x select 1];
		_mark setMarkerType "hd_destroy";
		_mark setMarkerAlpha 0;
		
		[_x select 1, 1000] execVM "addons\brezblock\utils\controller.sqf";
		[_x select 1, 1000, 60] execVM "addons\brezblock\utils\spawn_objects.sqf";
		
		private _pos = [_x select 1, 5, 150, 3, 0, 0, 0] call BIS_fnc_findSafePos;
		_mark = createMarker [format ["respawn_civilian_%1", _forEachIndex], _pos];
		_mark setMarkerType "hd_destroy";
		_mark setMarkerAlpha 0;
		
		private _trg = createTrigger ["EmptyDetector", getMarkerPos (format ["mrk_city_%1", _forEachIndex])];
		_trg setTriggerArea [250, 250, 0, false];
		_trg setTriggerActivation ["WEST SEIZED", "PRESENT", false];
		_trg setTriggerTimeout [0, 5, 10, true];
		_trg setTriggerStatements ["this", format ["['mrk_city_%1'] call Fn_Task_Attack_City;", _forEachIndex], ""];
	} forEach avaliable_pois;

	[getMarkerPos "mrk_east_base_02", 600] execVM "addons\brezblock\utils\controller.sqf";
	[getMarkerPos "mrk_airfield", 1000] execVM "addons\brezblock\utils\controller.sqf";
	[getMarkerPos "mrk_east_base_01", 150] execVM "addons\brezblock\utils\controller.sqf";
	
	call Fn_Spawn_Civ_Air_Transport;
	call Fn_Spawn_East_Transport;

	//Select cities for spawn
	private _ret = [_crashSitePos, 4000, 6] call BrezBlock_fnc_GetAllCitiesInRange;
	private _pois = _ret select 1;
	
	[_pois] call Fn_Patrols_CreateCivilean_Traffic;
	[_pois] call Fn_Patrols_CreateMilitary_Traffic;
	[_pois] call Fn_Task_Spawn_Boats;
	[_pois] call Fn_Task_Spawn_Civilean_Cars;

	//Spawn stashes
	[_crashSitePos] call Fn_Task_West_Hidden_WaponStash;
	call Fn_Task_Create_Civilian_WaponStash;
	call Fn_Task_Create_Civilian_FloodedShip;
	
	call Fn_Create_Logic_CivilianLiberateCity;

};