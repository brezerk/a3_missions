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
On player respawn event handler
*/

//resore loadout
//[player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_loadInventory;


	_none = player;
	_pos = markerPos "wp_zed";
	player setPos _pos;
	if (!bb_next_wave) then {
		{
			if (alive _x) exitWith { _pos = getPos _x };
		} forEach (switchableUnits + playableUnits);
		_pos = [_pos, 350, 500, 5, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
		_pos = markerPos "wp_test";
		private _unit = (createGroup [civilian, true]) createUnit ["zombie_runner", _pos, [], 0, "FORM"];
		
		waitUntil {alive _unit};
		
		//[_unit, 35] call rvg_fnc_setDamage;
		execVM "gear\base.sqf";
		//
		selectPlayer _unit;
		
		deleteVehicle _none;
		vehicle player switchCamera "EXTERNAL";
		
		[_unit, _none] spawn { params ["_unit", "_none"]; waitUntil { !alive _unit; }; selectPlayer _none; player addEventHandler ["Respawn", { params ["_unit", "_corpse"]; _unit = call Fn_MakeMeZombie; _unit} ]; player setDamage 1.0; };
		
		bb_next_wave = true;
		_unit;
	} else {
		private _unit = (createGroup [civilian, true]) createUnit ["B_Survivor_F", _pos, [], 0, "FORM"];
		waitUntil {alive _unit};
		selectPlayer _unit;
		player addEventHandler ["Respawn", { params ["_unit", "_corpse"]; _unit = call Fn_MakeMeZombie; _unit} ];
		execVM "gear\base.sqf";
		_pos = markerPos "wp_test";
		player setPos _pos;
		bb_next_wave = false;
	};
	