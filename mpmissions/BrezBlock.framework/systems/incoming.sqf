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
Start shelling on markers
	Arguments: [spawn marker, targets, number of shells, shell type]
	Usage: [{SpawnMarker}],[{Tagets},{NumberOfShells},{ShellType}] execVM ["addons/brezblock/systems/incoming.sqf"];
	Return: true
*/

if (isServer) then {
	params["_marker_name", "_targets", "_shells", ["_shell", "Sh_82mm_AMOS"]];
	private["_pos", "_boom"];
	while {_shells > 0} do {
		_pos = getMarkerPos ([_marker_name, _targets] call BrezBlock_fnc_Get_RND_Index);
	   //Sh_155mm_AMOS //Sh_120mm_HE //Sh_82mm_AMOS
		_boom = createVehicle [_shell, _pos, [], 0, "FLY"];
		_boom setPos [((getPos _boom select 0) + (round(random 250) - 150)), ((getPos _boom select 1) + (round(random 250) - 150)), 250 + round random 50];
		_boom setVelocity [0,0,-50];
		_shells = _shells - 1;
		sleep 5;
	};
};
true
