
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

	//Create markers
	{ 
		private _mark = createMarker [format ["wp_city_%1", _forEachIndex], _x select 1];
		_mark setMarkerType "hd_destroy";
		_mark setMarkerAlpha 0;
		
		[_x select 1, 900] execVM "addons\brezblock\utils\controller.sqf";
		
		private _pos = [_x select 1, 5, 150, 3, 0, 0, 0] call BIS_fnc_findSafePos;
		_mark = createMarker [format ["respawn_civilian_%1", _forEachIndex], _pos];
		_mark setMarkerType "hd_destroy";
		_mark setMarkerAlpha 0;
	} forEach avaliable_pois;

	//Select cities for spawn
	private _ret = [(getMarkerPos "wp_crash_site"), 4000, 6] call BrezBlock_fnc_GetAllCitiesInRange;
	private _pois = _ret select 1;
	
	[_pois] call Fn_Patrols_CreateCivilean_Traffic;
	[_pois] call Fn_Patrols_CreateMilitary_Traffic;
	[_pois] call Fn_Task_Spawn_Boats;
	[_pois] call Fn_Task_Spawn_Civilean_Cars;

	//Spawn stashes
	call Fn_Task_Create_Civilian_WaponStash;
	call Fn_Task_Create_Civilian_FloodedShip;
};