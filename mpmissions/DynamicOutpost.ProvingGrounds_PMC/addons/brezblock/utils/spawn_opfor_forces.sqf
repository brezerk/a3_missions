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
Spawn OPFOR composition and order to move to the designation using LARs_fnc_spawnComp
	Arguments: [spawn marker, composition name, designation marker]
	Usage: [{SpawnMarker}],[{CompositionName},{DesignationMarker}] call BrezBlock_fnc_Spawn_OPFOR_Forces
	Return: _unitRef to spawned Objects
*/

/* ================================= *\
 *            DEPRECATED             *
\* ================================= */

//run on dedicated server only
if (isServer) then {	
	params ["_spawnposition", "_composition", "_wppostistion"];
	//[format ["Enemy forces %1 inbound: %2", _composition, _spawnposition]] remoteExec ["systemChat"];
	_rndPos = [((getmarkerpos _spawnposition select 0) + (round(random 100) - 50)), ((getmarkerpos _spawnposition select 1) + (round(random 100) - 50)), getmarkerpos _spawnposition select 2];
	_unitRef = [_composition, _rndPos, [0,0,0], 0, true] call LARs_fnc_spawnComp;
	_HVT = [_unitRef] call LARs_fnc_getCompObjects;
	//_HVT = [getmarkerpos _spawnposition, [0, ], ["rhs_msv_emr_junior_sergeant"],[],[],[],[],[],180] call BIS_fnc_spawnGroup;     //spawn the unit on the random position.
	//_HVT = [getmarkerpos _spawnposition, 0, ["rhs_msv_emr_junior_sergeant"]] call BIS_fnc_ObjectsMapper;
	{
		_type = typeName _x;
		if (_type == "GROUP") then {
			_units = units _x;
			{
				_vehicle = assignedVehicle _x;
				if (!isNull _vehicle) then {
					_vehicle setUnloadInCombat [true, false];
				};
			} forEach _units;
			//[_x, getmarkerpos _wppostistion, 50, true] call CBA_fnc_taskAttack;
			_waypoint  = _x addWaypoint [getmarkerpos _wppostistion,0];
			_x setBehaviour "AWARE";
			_x setSpeedMode "FAST";
			_waypoint  = _x addWaypoint [getmarkerpos _wppostistion,1];
			_x setBehaviour "AWARE";
			_x setSpeedMode "FAST";
			_waypoint  = _x addWaypoint [getmarkerpos _wppostistion,2];
			_x setBehaviour "AWARE";
			_x setSpeedMode "FAST";
		};
	} forEach _HVT;
	_HVT;
};
