
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

	private _crashSitePos = getMarkerPos "mrk_west_crashsite";

	call Fn_Spawn_East_AntiAir;
	call Fn_Spawn_East_Helicopter;
	call Fn_Spawn_East_Transport;
	
	call Fn_Spawn_Civ_Air_Transport;
	
	//Get all POI in the range
	private _ret = [_crashSitePos, 2000, 2] call BrezBlock_fnc_GetAllCitiesInRange;
	avaliable_locations = _ret select 0;
	avaliable_pois = _ret select 1;
	
	//FIXME: do we really need this?
	publicVariable "avaliable_pois";
	
	{ avaliable_markers pushBackUnique _x; } forEach ([_crashSitePos, 1500] call BrezBlock_fnc_CotrollerCreate);
	{ if (!((markerType _x) in ["b_recon", "b_plane"])) then { avaliable_markers pushBackUnique _x; }; } forEach ([getMarkerPos "mrk_east_base_02", 600] call BrezBlock_fnc_CotrollerCreate);
	{ if (!((markerType _x) in ["b_recon", "b_plane"])) then { avaliable_markers pushBackUnique _x; }; } forEach ([getMarkerPos "mrk_airfield", 1000] call BrezBlock_fnc_CotrollerCreate);
	[getMarkerPos "mrk_east_base_01", 150] call BrezBlock_fnc_CotrollerCreate;

	//Create city markers
	{ 
		private _pos = _x select 1;
		private _mark = createMarker [format ["mrk_city_%1", _forEachIndex], _pos];
		_mark setMarkerType "hd_destroy";
		_mark setMarkerAlpha 0;
		
		//{ if (!((markerType _x) in ["b_recon", "b_plane"])) then { avaliable_markers pushBackUnique _x; }; } forEach ([_pos, 600] call BrezBlock_fnc_CotrollerCreate);
		
		private _size = 100;
		private _loc_size_x = ((_x select 2) select 0);
		private _loc_size_y = ((_x select 2) select 1);
		if ((_loc_size_x > 100) && (_loc_size_x >= _loc_size_y)) then {
			_size = _loc_size_x;
		} else {
			if (_loc_size_y > 100) then {
				_size = _loc_size_y;
			};
		};
		[_pos, (_size + 100), 40] call BrezBlock_fnc_SpawnObjects;
		
		_pos = [_x select 1, 5, 150, 3, 0, 0, 0] call BIS_fnc_findSafePos;
		_mark = createMarker [format ["respawn_civilian_%1", _forEachIndex], _pos];
		_mark setMarkerType "hd_destroy";
		_mark setMarkerAlpha 0;
	} forEach avaliable_pois;
	//Create city triggers
	call Fn_Create_Logic_CivilianLiberateCity;
	
	[_crashSitePos] call Fn_Spawn_East_Comtower;
	[_crashSitePos] call Fn_Task_Spawn_Indep_Objectives;
	call Fn_Task_West_Hidden_WaponStash;
	
	[_crashSitePos, 1500, 50] call BrezBlock_fnc_SpawnObjects;
	
	call Fn_Task_Create_Civilian_WaponStash;
	call Fn_Task_Create_Civilian_FloodedShip;
	
	//private _result = diag_codePerformance [_code, []];
	//systemChat format ["diag_codePerformance: controller.sqf exec time: %1ms %2cycles", _result select 0, _result select 1];
	
	//FIXME: Search for roads, create cache use it for patrols and civil spawn
	
	private _pios = avaliable_pois;
	{
		_pios pushBackUnique _x;
	} forEach (([_crashSitePos, 4000, 6] call BrezBlock_fnc_GetAllCitiesInRange) select 1);
	
	//Select cities for spawn
	{
		private _pos = _x select 1;
		if (!((_x select 0) in ['Kambani','Bibung','Loholoho','Tinobu'])) then {
			[_pos] call Fn_Task_Spawn_Boats;
		};
		
		private _size = 100;
		private _loc_size_x = ((_x select 2) select 0);
		private _loc_size_y = ((_x select 2) select 1);
		if ((_loc_size_x > 100) && (_loc_size_x >= _loc_size_y)) then {
			_size = _loc_size_x;
		} else {
			if (_loc_size_y > 100) then {
				_size = _loc_size_y;
			};
		};
		
		diag_log format ["Spawn %1: %2 size: %3", _x, (_x select 0), _size];
		
		private _roads = [_pos, _size, 16] call BrezBlock_fnc_GetEmptyRoads;
		_roads = [_roads] call Fn_Patrols_CreateMilitary_Traffic;
		_roads = [_roads] call Fn_Patrols_CreateCivilean_Traffic;
		[_roads] call Fn_Task_Spawn_Civilean_Cars;
		
		//create reinfrsement roads pool
		_roads = [];
		
		diag_log format ["Pos %1", _pos];
		
		scopeName "main";
		{
			scopeName "next_road";
			if (count _roads >= 5) then { breakTo "main"; };
			if ((_pos distance2D (getPosASL _x)) >= 600) then {
				
				private _clear = true;
				private _pos_x = getPosASL _x;
				if (_clear) then {
					if ((count (nearestObjects [_pos_x, ["Car", "Truck"], 50]) == 0) and (count (nearestTerrainObjects [_pos_x, ["TREE", "ROCK", "ROCKS"], 10, false, true]) == 0) and (count (nearestTerrainObjects [_pos_x, ["BUILDING", "HOUSE", "FENCE", "WALL"], 50, false, true]) == 0)) then {
						private _bbox = boundingboxReal _x;
						private _a = _bbox select 0;
						private _b = _bbox select 1;
						private _size = _a distance _b;
						
						if (_size >= 45) then {
							_roads pushBack _x;
						};
					};
				};
			};
		} forEach (_pos nearRoads 1000);
		{
			reinforcement_roads pushBackUnique _x;
		} forEach _roads;
	} forEach (_pios);
	
	diag_log format ["Count: %1", count reinforcement_roads];
	
};