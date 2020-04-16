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


bb_srv_dmg_chem   = 0; // 0 - 20 light damage; 30 - 100 heavy damage; 100 + letal damage
bb_srv_dmg_rad    = 0; // 0 - 20 light damage; 300 - 1000 heavy damage; 1000 + letal damage
bb_srv_dmg_bac    = 0; // 0 - 300 light damage; 300 - 1000 heavy damage; 1000 + letal damage
bb_srv_temp_body  = 36.6; // 0 - 32 -- cold; 32 - 35 -- chilly; 36 comfort; 
bb_srv_temp_body_feaver  = 0; // > 4.4 letal; 
bb_srv_temp_local = 0; // 0 - 32 -- cold; 32 - 35 -- chilly; 36 comfort; 
bb_srv_stimpack_level = 0;
player setVariable['bb_srv_derad',  0, true];
player setVariable['bb_srv_dechem', 0, true];
player setVariable['bb_srv_debac',  0, true];
player setVariable['bb_srv_st_lvl', 0, true];

_none = player;
_pos = markerPos "wp_zed";
player setPos _pos;
if (!bb_next_wave) then {
	_pos = [];
	{
		if (alive _x) exitWith { _pos = getPos _x };
	} forEach (switchableUnits + playableUnits);
	if (count _pos > 0) then {
		_pos = [_pos, 350, 500, 5, 0, 0, 0, [], []] call BIS_fnc_findSafePos;
	} else {
		_pos = markerPos "wp_test";
	};
	private _unit = (createGroup [civilian, true]) createUnit ["zombie_runner", _pos, [], 0, "FORM"];
		
	waitUntil {alive _unit};
		
	execVM "gear\zed_base.sqf";
	selectPlayer _unit;
	deleteVehicle _none;
	vehicle player switchCamera "EXTERNAL";
	[_unit, _none] spawn { params ["_unit", "_none"]; waitUntil { !alive _unit; }; selectPlayer _none; player addEventHandler ["Respawn", { params ["_unit", "_corpse"]; _unit = call Fn_MakeMeZombie; _unit} ]; player setDamage 1.0; };
	100 cutText ["", "PLAIN"];
	_unit addEventHandler ["InventoryOpened", {false}];
	//_unit;
} else {
	_pos = markerPos "wp_test";
	private _unit = (createGroup [west, true]) createUnit ["B_Survivor_F", _pos, [], 0, "FORM"];
	waitUntil {alive _unit};
	selectPlayer _unit;
	player addEventHandler ["Respawn", { params ["_unit", "_corpse"]; _unit = call Fn_MakeMeZombie; _unit} ];
	player setPos _pos;
	[true] call BrezBlock_fnc_Local_Systems_Survival_Medical;
	[true] call BrezBlock_fnc_Local_Systems_Survival_Fireplace;
	[player, [missionNamespace, "outpost_saved_loadout"]] call BIS_fnc_loadInventory;
	100 cutRsc ["BB_Survival_HUD","PLAIN", 1, false];
	bb_next_wave = false;
};
	