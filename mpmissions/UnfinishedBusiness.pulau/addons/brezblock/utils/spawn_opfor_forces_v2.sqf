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
Spawn OPFOR composition and order to move to the designation using BIS_fnc_spawnGroup
	Arguments: [spawn marker, composition name, designation marker, spwan offset array]
	Usage: [{SpawnMarker}],[{CompositionName},{DesignationMarker},{SpawnOffsetArray}] call BrezBlock_fnc_Spawn_OPFOR_Forces
	Return: _unitRef to spawned Objects
*/

//run on dedicated server only
if (isServer) then {
	params ["_spawnposition", "_composition", "_wppostistion", ["_offset", []]];
	private ["_unitCFG", "_pos", "_grp", "_wp", "_vec", "_vecCFG", "_assignedCFG", "_HVT", "_distance"];
	//sleep 5;
	_distance = 30;
	_unitCFG = [];
	_HVT = [];
	{
		if (_x find _composition >= 0) exitWith {
			_unitCFG = _x;
		};
	} forEach unitsSpawnMap;
		
	if ((count _unitCFG) == 0) then {
		[format ["ERROR: Unable to spawn %1", _composition]] remoteExec ["systemChat"];
	} else {
		//[format ["Spawning %1", _composition]] remoteExec ["systemChat"];
		_vecCFG = _unitCFG select 1 select 0;
		_assignedCFG = _unitCFG select 1 select 1;			
		//[format ["CFG %1", _vecCFG]] remoteExec ["systemChat"];
			
		if ((count _vecCFG) > 1) then {
			_pos = getMarkerPos _spawnposition findEmptyPosition [_distance, (_distance * 2), _vecCFG select 0];
			//spawn vec grup only (can have infantry too);
			_grp = [_pos, east, _vecCFG, _offset, [],[],[],[],markerDir _spawnposition] call BIS_fnc_spawnGroup;
			//grabage collection
			_grp deleteGroupWhenEmpty true;
			{
				_veh = assignedVehicle _x;
				if (!isNull _veh) exitWith {
					//make veh commander a group leader
					_grp selectLeader commander _veh;
				};
			} forEach units _grp;
			//give order to assigned units first
			_wp  = _grp addWaypoint [getMarkerPos _wppostistion, 0];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "NORMAL";
			_wp setWaypointFormation "DIAMOND";
			_grp setBehaviour "AWARE";
			_grp setSpeedMode "NORMAL";
			_HVT pushBack _grp;
		} else {
			//spwan vec and assign infantry on it as a cargo;
			_vec = _vecCFG select 0;
			_pos = getMarkerPos _spawnposition findEmptyPosition [_distance, (_distance * 2), _vec];
			_vecCFG = [_pos, markerDir _spawnposition, _vec, east] call BIS_fnc_spawnVehicle;
			_vec = _vecCFG select 0;
			//config cargo unload
			_vec setUnloadInCombat [true, false];
			_grp = [getMarkerPos _spawnposition, east, _assignedCFG,[],[],[],[],[],markerDir _spawnposition] call BIS_fnc_spawnGroup;
			//grabage collection
			_grp deleteGroupWhenEmpty true;
			{
				_x assignAsCargo _vec;
				_x moveInCargo _vec;
			} forEach units _grp;
			//give order to assigned units first
			_wp  = _grp addWaypoint [getMarkerPos _wppostistion, 0];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "FULL";
			_grp setBehaviour "AWARE";
			_grp setSpeedMode "FAST";
			_HVT pushBack _grp;
			//give order to vec
			_grp = _vecCFG select 2;
			//grabage collection
			_grp deleteGroupWhenEmpty true;
			_wp  = _grp addWaypoint [getMarkerPos _wppostistion, 0];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "FULL";
			_grp setBehaviour "AWARE";
			_grp setSpeedMode "FAST";
			_HVT pushBack _grp;
		};
	};
	_HVT;
};
