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
Spawn start objectives, triggers for game intro and players allocation
*/

//Player side triggers
// Client side code
if (hasInterface) then {

	east_order_seen = false;

	Fn_Local_Create_EAST_MissionIntro = {
		if (side player != east) exitWith {};
		if (!east_order_seen) then {
			[] execVM "UnfinishedBusiness.core\ui\orderDialog.sqf";
			east_order_seen = true;
			"mrk_west_base_01" setMarkerAlphaLocal 0;
			"mrk_west_specops" setMarkerAlphaLocal 0;
			"mrk_west_safezone_01" setMarkerAlphaLocal 0;
			"mrk_east_stash_01" setMarkerAlphaLocal 0;
			"mrk_east_stash_02" setMarkerAlphaLocal 0;
		};
		private _task = ['t_east_defend_aa', player] call BIS_fnc_taskReal;
		if (isNull _task) then {
			private _marker = format ["wp_%1_aa", D_LOCATION];
			if (canFire obj_east_antiair) then {
				[
					player,
					"t_east_defend_aa",
					[format [localize "TASK_AOC_01_DESC", D_LOCATION],
					localize "TASK_AOC_01_TITLE",
					localize "TASK_ORIG_01"],
					getPos obj_east_antiair,
					"CREATED",
					0,
					true
				] call BIS_fnc_taskCreate;
				['t_east_defend_aa', "defend"] call BIS_fnc_taskSetType;
			};
		};
		_task = ['t_east_defend_commtower', player] call BIS_fnc_taskReal;
		if (isNull _task) then {
			if (alive obj_east_comtower) then {
				[
					player,
					"t_east_defend_commtower",
					[format [localize "TASK_AOC_02_DESC", D_LOCATION],
					localize "TASK_AOC_02_TITLE",
					localize "TASK_ORIG_02"],
					getPos obj_east_comtower,
					"CREATED",
					0,
					true
				] call BIS_fnc_taskCreate;
				['t_east_defend_commtower', "defend"] call BIS_fnc_taskSetType;
			};
		};
		call Fn_Local_Create_EAST_MissionCrashSite;
	};
	
	Fn_Local_Create_EAST_MissionCrashSite = {
		if (side player != east) exitWith {};
		private _us_airplane_01_alive = false;
		if (!isNil "us_airplane_01") then {
			_us_airplane_01_alive = alive us_airplane_01;
		};
		if (!_us_airplane_01_alive) then {
			private _task = ['t_east_eliminate_survivals', player] call BIS_fnc_taskReal;
			if (isNull _task) then {
				[
					player,
					"t_east_eliminate_survivals",
					[localize "TASK_AOC_03_DESC",
					localize "TASK_AOC_03_TITLE",
					localize "TASK_ORIG_03"],
					objNull,
					"CREATED",
					0,
					true
				] call BIS_fnc_taskCreate;
				['t_east_eliminate_survivals', "kill"] call BIS_fnc_taskSetType;
			};
			call Fn_Local_Create_Mission_CrashSite;
			{
				private _task_name = format["t_east_city_%1", _forEachIndex];
				_task = [_task_name, player] call BIS_fnc_taskReal;
				if (isNull _task) then {
					[
						player,
						_task_name,
						[format[localize "TASK_11_DESC", _forEachIndex, _x select 0],
						format[localize "TASK_11_TITLE", _x select 0],
						localize "TASK_ORIG_01"],
						getMarkerPos (format ["mrk_city_%1", _forEachIndex]),
						"CREATED",
						0,
						true
					] call BIS_fnc_taskCreate;
					[_task_name, "talk"] call BIS_fnc_taskSetType;		
				};
			} forEach avaliable_pois;
		};
		/*
		{
			if (!(_x in playableunits) && !(_x in switchableunits)) then {
				if ((side _x) == east) then {
					removeAllActions _x;
					[_x] call Fn_Local_Attach_Recruit_Action;
				};
			};
		} forEach (nearestObjects [getMarkerPos "respawn_east", ["Man"], 150]); //Note CUP does not really follow SoldierEB classification :)
		*/
	};
};