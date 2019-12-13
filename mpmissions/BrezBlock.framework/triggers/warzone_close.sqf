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
Paradrop
	Arguments: [Marker, Trigger Name]
	Usage: [{Marker}, {TriggerName}] execVM ["addons/BrezBlock.framework/triggers/warzone_close.sqf"];
	Return: true
*/

params ["_marker", "_trigger"];
private ["_grp", "_veh"];

waitUntil {
	sleep 5;
	{	
		_grp = group _x;
		if !(_grp getVariable [format ["%1_TriggerActivated", _marker], false]) then {
			//systemChat "FOUND GROUP IN TRIGGER";
			{
				_veh = assignedVehicle _x;
				if (!isNull _veh) exitWith {
					//systemChat "MECHA";
					{ 
						if ((_x == gunner _veh) || (_x == driver _veh) || (_x == commander _veh)) then {
						} else {
							_x leaveVehicle _veh;
							unassignVehicle _x;
							//doGetOut _x;
						};
					} forEach (crew _veh);
				};
			} forEach units _x;
			_grp setVariable [format ["%1_TriggerActivated", _marker], true];
			[_grp, getMarkerPos _marker, 10, true] call CBA_fnc_taskAttack;
		}
	} forEach list _trigger;
	false
};