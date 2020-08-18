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



//Player side triggers
// Client side code
if (hasInterface) then {

	west_rq_order_seen = false;

	Fn_Local_Create_RescueMission = {
		if (side player == civilian) then {
			if (!(player getVariable ["is_assault_group", false])) exitWith {};
		} else {
			if ((side player) != west) exitWith {};
			if (player getVariable ["is_specops_group", false]) exitWith {};
		};
		if ((side player) != west) exitWith {};


				[
					player,
					"t_west_rescue",
					[
					format [localize "TASK_09_DESC", D_LOCATION],
					format [localize "TASK_09_TITLE"],
					localize "TASK_ORIG_01"],
					getPos us_liberty_01,
					"CREATED",
					0,
					true
				] call BIS_fnc_taskCreate;
				['t_west_rescue', "run"] call BIS_fnc_taskSetType;
				if (!(player getVariable ["is_assault_group", false])) then {
					if (!west_rq_order_seen) then {
						[] execVM "UnfinishedBusiness.core\ui\orderDialog.sqf";
						west_rq_order_seen = true;
					};
					{
						private _task = format["t_west_rescue_city_%1", _forEachIndex];
						[
							player,
							_task,
							[format[localize "TASK_11_DESC", _forEachIndex, _x select 0],
							format[localize "TASK_11_TITLE", _x select 0],
							localize "TASK_ORIG_01"],
							getMarkerPos (format ["mrk_city_%1", _forEachIndex]),
							"CREATED",
							0,
							true
						] call BIS_fnc_taskCreate;
						[_task, "talk"] call BIS_fnc_taskSetType;			
					} forEach avaliable_pois;
				};
	};
};
