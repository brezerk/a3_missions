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
Create civilian presence module
	Arguments: [_marker]
	Usage: [_marker] call BrezBlock_fnc_CreateCivilianPresence;
	Return: none
*/
if (isServer) then {
	params['_marker'];
	private['_i'];
	
	private _radius = getMarkerSize _marker select 0;
	private _center = getMarkerPos _marker;
	
	private _grp = createGroup [civilian, true];
	
	for "_i" from 0 to (round (_radius / 25)) do
	{
		private _pos = [_center, 5, _radius, 3, 0, 0, 0] call BIS_fnc_findSafePos;
		private _obj = _grp createUnit ["ModuleCivilianPresenceSafeSpot_F", _pos, [], 0, "NONE"];
		_obj setVariable ["#capacity",    3];
		_obj setVariable ["#usebuilding", true];
		_obj setVariable ["#terminal",    false];
	};
	
	for "_i" from 0 to (round (_radius / 25) + 1) do
	{
		private _pos = [_center, 5, _radius, 3, 0, 0, 0] call BIS_fnc_findSafePos;
		private _obj = _grp createUnit ["ModuleCivilianPresenceUnit_F", _pos, [], 0, "NONE"];
		_obj setVariable ["#capacity",    3];
		_obj setVariable ["#usebuilding", false];
		_obj setVariable ["#terminal",    false];
	};
	
	private _pos = [_center, 5, _radius, 3, 0, 0, 0] call BIS_fnc_findSafePos;
	private _obj = _grp createUnit ["ModuleCivilianPresence_F", _pos, [], 0, "NONE"];
	_obj setVariable ["#area", [_center, _radius, _radius, 0, true, -1]];  // https://community.bistudio.com/wiki/inAreaArray 
	_obj setVariable ["#debug",        false ]; // Debug mode on
	_obj setVariable ["#useagents",    true ];
	_obj setVariable ["#usepanicmode", false];
	_obj setVariable ["#unitcount",    (round (_radius / 25))];
	
	_grp;
};