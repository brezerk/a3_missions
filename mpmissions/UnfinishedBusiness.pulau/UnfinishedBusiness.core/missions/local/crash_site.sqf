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

// Intended to be executed on player side
if (hasInterface) then {

	trgWestCrashSite = objNull;

	Fn_Local_Create_Mission_CrashSite = {
		//if ((!alive us_airplane_01) || (!canMove us_airplane_01)) then {
			private _markerPos = getMarkerPos "mrk_west_crashsite";
			private _side = (side player);
			if ((_side == west) && (player getVariable ["is_civilian", false])) then { _side = civilian; };
			if (player getVariable ["is_assault_group", false]) then { _side = "WEST_01"; _markerPos = objNull; };
			
			private _task_name = format["t_%1_crash_site", _side];
			private _task = [_task_name, player] call BIS_fnc_taskReal;
			if (isNull _task) then {
				[
					player,
					_task_name,
					[localize format["TASK_%1_CRASH_DESC", _side],
					localize format["TASK_%1_CRASH_TITLE", _side],
					localize "TASK_ORIG_01"],
					_markerPos,
					"CREATED",
					0,
					true
				] call BIS_fnc_taskCreate;
				[_task_name, "unknown"] call BIS_fnc_taskSetType;
			};

			if (isNull trgWestCrashSite) then {	
				trgWestCrashSite = createTrigger ["EmptyDetector", (getMarkerPos "mrk_west_crashsite")];
				trgWestCrashSite setTriggerArea [50, 50, 0, false];
				trgWestCrashSite setTriggerActivation ["ANYPLAYER", "PRESENT", true];
				trgWestCrashSite setTriggerStatements [
					"(vehicle player) in thisList",
					"[ format [localize 'INFO_LOC_01', D_LOCATION], localize 'INFO_SUBLOC_01', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText; call Fn_Local_CrashSite_Complete;",
					""
				];
			};
		//};
	};
	
	Fn_Local_CrashSite_Complete = {
		private _side = (side player);
		if ((_side == west) && (player getVariable ["is_civilian", false])) then { _side = civilian; };
		if ((_side == west) && (player in ((units us_group_01) + (units us_group_02) + (units us_group_03)))) then { _side = "WEST_01"; };
		private _task_name = format["t_%1_crash_site", _side];
		[_task_name, 'Succeeded', (localize format["TASK_%1_CRASH_TITLE", _side])] call Fn_Local_SetPersonalTaskState;
	};
};