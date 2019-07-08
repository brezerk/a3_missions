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
	Fn_Local_Create_Mission_CrashSite = {
		private _markerPos = getMarkerPos "wp_crash_site";
		
		[
			player,
			"t_crash_site",
			[localize "TASK_04_DESC",
			localize "TASK_04_TITLE",
			localize "TASK_ORIG_01"],
			objNull,
			"CREATED",
			0,
			true
		] call BIS_fnc_taskCreate;
		['t_crash_site', "unknown"] call BIS_fnc_taskSetType;
			
		private _trg = createTrigger ["EmptyDetector", _markerPos];
		_trg setTriggerArea [50, 50, 0, false];
		_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
		_trg setTriggerStatements [
			"(vehicle player) in thisList",
			"[ localize 'INFO_LOC_01', localize 'INFO_SUBLOC_01', format [localize 'INFO_DATE_01', daytime call BIS_fnc_timeToString], mapGridPosition player ] spawn BIS_fnc_infoText;",
			""
		];
			
		trgEastCrashSite = createTrigger ["EmptyDetector", _markerPos];
		trgEastCrashSite setTriggerArea [15, 15, 0, false];
		trgEastCrashSite setTriggerActivation ["ANYPLAYER", "PRESENT", false];
		trgEastCrashSite setTriggerStatements [
			"(vehicle player) in thisList",
			"call Fn_Local_CrashSite_Complete;",
			""
		];
	};
	
	Fn_Local_CrashSite_Complete = {
		_task = ['t_crash_site', player] call BIS_fnc_taskReal;
		if (!isNull _task) then {
			_task setTaskState "Succeeded";
		};
	};
};